
CREATE TABLE IF NOT EXISTS submission_status_audit (
    audit_id BIGSERIAL PRIMARY KEY,
    source_table TEXT NOT NULL,
    submission_id INTEGER NOT NULL,
    old_status TEXT NOT NULL,
    new_status TEXT NOT NULL,
    reviewed_by INTEGER,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION record_submission_status_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    row_data JSONB;
    row_id INTEGER;
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        -- All three submission tables use pending/approved/rejected statuses.
        IF OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected') THEN
            NEW.reviewed_at := COALESCE(NEW.reviewed_at, CURRENT_TIMESTAMP);
        END IF;

        row_data := to_jsonb(NEW);
        row_id := COALESCE(
            (row_data ->> 'submission_id')::INTEGER,
            (row_data ->> 'update_id')::INTEGER
        );

        INSERT INTO submission_status_audit (
            source_table, submission_id, old_status, new_status, reviewed_by
        ) VALUES (
            TG_TABLE_NAME, row_id, OLD.status, NEW.status,
            (row_data ->> 'reviewed_by')::INTEGER
        );
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS blog_submissions_status_audit ON blog_submissions;
CREATE TRIGGER blog_submissions_status_audit
BEFORE UPDATE OF status ON blog_submissions
FOR EACH ROW
EXECUTE FUNCTION record_submission_status_change();

DROP TRIGGER IF EXISTS learn_submissions_status_audit ON learn_submissions;
CREATE TRIGGER learn_submissions_status_audit
BEFORE UPDATE OF status ON learn_submissions
FOR EACH ROW
EXECUTE FUNCTION record_submission_status_change();

DROP TRIGGER IF EXISTS content_update_submissions_status_audit ON content_update_submissions;
CREATE TRIGGER content_update_submissions_status_audit
BEFORE UPDATE OF status ON content_update_submissions
FOR EACH ROW
EXECUTE FUNCTION record_submission_status_change();

CREATE TABLE IF NOT EXISTS doctor_registration_status_audit (
    audit_id BIGSERIAL PRIMARY KEY,
    application_id INTEGER NOT NULL REFERENCES doctor_registration_applications(application_id) ON DELETE CASCADE,
    old_status TEXT NOT NULL,
    new_status TEXT NOT NULL,
    reviewed_by INTEGER,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION record_doctor_registration_status_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        IF OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected') THEN
            NEW.reviewed_at := COALESCE(NEW.reviewed_at, CURRENT_TIMESTAMP);
        END IF;
        INSERT INTO doctor_registration_status_audit (
            application_id, old_status, new_status, reviewed_by
        ) VALUES (
            NEW.application_id, OLD.status, NEW.status, NEW.reviewed_by
        );
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS doctor_registration_status_audit_trigger ON doctor_registration_applications;
CREATE TRIGGER doctor_registration_status_audit_trigger
BEFORE UPDATE OF status ON doctor_registration_applications
FOR EACH ROW
EXECUTE FUNCTION record_doctor_registration_status_change();

-- Archive a completed visit before removing it from active appointment lists.
CREATE OR REPLACE FUNCTION archive_completed_appointment()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status AND NEW.status = 'completed' THEN
        INSERT INTO completed_appointment_history (
            appointment_id, patient_id, doctor_id, hospital_id, reason, requested_date,
            appointment_date, requested_at, marked_available_at, assigned_by,
            assigned_at, completed_at, archived_at
        ) VALUES (
            NEW.appointment_id, NEW.patient_id, NEW.doctor_id, NEW.hospital_id, NEW.reason,
            NEW.requested_date, NEW.appointment_date, NEW.requested_at,
            NEW.marked_available_at, NEW.assigned_by, NEW.assigned_at,
            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
        ) ON CONFLICT (appointment_id) DO NOTHING;

        UPDATE prescriptions
        SET visit_date = COALESCE(visit_date, NEW.appointment_date)
        WHERE appointment_id = NEW.appointment_id;

        DELETE FROM appointments WHERE appointment_id = NEW.appointment_id;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS appointment_completion_archive ON appointments;
CREATE TRIGGER appointment_completion_archive
AFTER UPDATE OF status ON appointments
FOR EACH ROW
EXECUTE FUNCTION archive_completed_appointment();

-- Database-computed dashboard statistics used by GET /api/overview.
CREATE OR REPLACE FUNCTION get_cancercare_statistics()
RETURNS TABLE (
    hospitals INTEGER,
    doctors INTEGER,
    cancer_types INTEGER,
    stories INTEGER,
    pending_blog_submissions INTEGER,
    pending_learn_submissions INTEGER,
    pending_content_updates INTEGER
)
LANGUAGE SQL
STABLE
AS $$
    SELECT
        (SELECT COUNT(*)::INTEGER FROM hospitals),
        (SELECT COUNT(*)::INTEGER FROM doctors),
        (SELECT COUNT(*)::INTEGER FROM cancers),
        (SELECT COUNT(*)::INTEGER FROM blogposts),
        (SELECT COUNT(*)::INTEGER FROM blog_submissions WHERE status = 'pending'),
        (SELECT COUNT(*)::INTEGER FROM learn_submissions WHERE status = 'pending'),
        (SELECT COUNT(*)::INTEGER FROM content_update_submissions WHERE status = 'pending');
$$;

-- Keep doctors.rating equal to the average of patient ratings from visits and stories.
ALTER TABLE doctors ADD COLUMN IF NOT EXISTS rating NUMERIC(3,2) NOT NULL DEFAULT 0;

CREATE OR REPLACE FUNCTION refresh_doctor_rating_average()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    affected_doctor_id INTEGER;
BEGIN
    IF TG_OP = 'DELETE' THEN
        affected_doctor_id := OLD.doctor_id;
    ELSE
        affected_doctor_id := NEW.doctor_id;
    END IF;
    UPDATE doctors d SET rating = COALESCE((
        SELECT ROUND(AVG(all_ratings.rating)::numeric, 2)
        FROM (
            SELECT rating FROM doctor_ratings WHERE doctor_id = affected_doctor_id
            UNION ALL
            SELECT rating FROM blogpost_doc WHERE doctor_id = affected_doctor_id
        ) all_ratings
    ), 0)
    WHERE d.doctor_id = affected_doctor_id;
    IF TG_OP = 'DELETE' THEN RETURN OLD; END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS doctor_rating_average_from_visits ON doctor_ratings;
CREATE TRIGGER doctor_rating_average_from_visits
AFTER INSERT OR UPDATE OR DELETE ON doctor_ratings
FOR EACH ROW EXECUTE FUNCTION refresh_doctor_rating_average();

DROP TRIGGER IF EXISTS doctor_rating_average_from_stories ON blogpost_doc;
CREATE TRIGGER doctor_rating_average_from_stories
AFTER INSERT OR UPDATE OR DELETE ON blogpost_doc
FOR EACH ROW EXECUTE FUNCTION refresh_doctor_rating_average();

-- Publish a patient story and link it to its author as one database operation.
CREATE OR REPLACE PROCEDURE approve_blog_submission(
    p_submission_id INTEGER,
    p_admin_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    submission_row blog_submissions%ROWTYPE;
    new_blog_id INTEGER;
BEGIN
    SELECT * INTO submission_row
    FROM blog_submissions
    WHERE submission_id = p_submission_id AND status = 'pending'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pending story not found.' USING ERRCODE = 'P0002';
    END IF;

    INSERT INTO blogposts (title, feel, post_date)
    VALUES (submission_row.title, submission_row.body, CURRENT_TIMESTAMP)
    RETURNING blog_id INTO new_blog_id;

    INSERT INTO patient_blogpost (patient_id, blog_id, write_date)
    VALUES (submission_row.patient_id, new_blog_id, CURRENT_DATE);

    IF submission_row.doctor_id IS NOT NULL AND submission_row.doctor_rating IS NOT NULL THEN
        INSERT INTO blogpost_doc (blog_id, patient_id, doctor_id, rating, review)
        VALUES (new_blog_id, submission_row.patient_id, submission_row.doctor_id,
                submission_row.doctor_rating, submission_row.doctor_review)
        ON CONFLICT (blog_id, patient_id, doctor_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP;
    END IF;

    IF submission_row.hospital_id IS NOT NULL AND submission_row.hospital_rating IS NOT NULL THEN
        INSERT INTO blogpost_hospital (blog_id, patient_id, hospital_id, rating, review)
        VALUES (new_blog_id, submission_row.patient_id, submission_row.hospital_id,
                submission_row.hospital_rating, submission_row.hospital_review)
        ON CONFLICT (blog_id, patient_id, hospital_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP;
    END IF;

    UPDATE blog_submissions
    SET status = 'approved', reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP, blog_id = new_blog_id
    WHERE submission_id = p_submission_id;
END;
$$;

-- Create an approved Doctor account and its hospital/admin links atomically.
CREATE OR REPLACE PROCEDURE approve_doctor_registration(
    p_application_id INTEGER,
    p_admin_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    application_row doctor_registration_applications%ROWTYPE;
    admin_hospital_id INTEGER;
    new_doctor_id INTEGER;
BEGIN
    SELECT * INTO application_row
    FROM doctor_registration_applications
    WHERE application_id = p_application_id AND status = 'pending'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pending doctor application not found.' USING ERRCODE = 'P0002';
    END IF;

    SELECT hospital_id INTO admin_hospital_id
    FROM admins WHERE admin_id = p_admin_id;

    IF NOT FOUND OR admin_hospital_id <> application_row.hospital_id THEN
        RAISE EXCEPTION 'This doctor application belongs to another hospital.' USING ERRCODE = '42501';
    END IF;

    INSERT INTO users (first_name, last_name, contact, password_hash)
    VALUES (application_row.first_name, application_row.last_name,
            application_row.contact, application_row.password_hash)
    RETURNING user_id INTO new_doctor_id;

    INSERT INTO doctors (
        doctor_id, license_no, fees, gender, email, qualification,
        address, district, area, experience_years
    ) VALUES (
        new_doctor_id, application_row.license_no, application_row.fees,
        application_row.gender, application_row.email, application_row.qualification,
        application_row.address, application_row.district, application_row.area,
        application_row.experience_years
    );

    INSERT INTO doctor_hospital (doctor_id, hospital_id, since_date)
    VALUES (new_doctor_id, application_row.hospital_id, CURRENT_DATE);

    INSERT INTO admin_doctor_assignment (admin_id, doctor_id, assignment_date)
    VALUES (p_admin_id, new_doctor_id, CURRENT_DATE)
    ON CONFLICT (admin_id, doctor_id) DO NOTHING;

    UPDATE doctor_registration_applications
    SET status = 'approved', reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP, password_hash = NULL
    WHERE application_id = p_application_id;
END;
$$;

-- Publish a doctor's Learn article and mark its submission approved atomically.
CREATE OR REPLACE PROCEDURE approve_learn_submission(
    p_submission_id INTEGER,
    p_admin_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    submission_row learn_submissions%ROWTYPE;
    new_article_id INTEGER;
BEGIN
    SELECT * INTO submission_row
    FROM learn_submissions
    WHERE submission_id = p_submission_id AND status = 'pending'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pending Learn article not found.' USING ERRCODE = 'P0002';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM admins admin_account
        JOIN doctor_hospital dh ON dh.hospital_id = admin_account.hospital_id
        WHERE admin_account.admin_id = p_admin_id
          AND dh.doctor_id = submission_row.doctor_id
    ) THEN
        RAISE EXCEPTION 'This Learn article belongs to another hospital.' USING ERRCODE = 'P0002';
    END IF;

    INSERT INTO learn_articles
        (doctor_id, title, category, body, sources, photo_bytes, photo_mime)
    VALUES
        (submission_row.doctor_id, submission_row.title, submission_row.category,
         submission_row.body, submission_row.sources, submission_row.photo_bytes,
         submission_row.photo_mime)
    RETURNING article_id INTO new_article_id;

    UPDATE learn_submissions
    SET status = 'approved', reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP, article_id = new_article_id
    WHERE submission_id = p_submission_id;
END;
$$;
