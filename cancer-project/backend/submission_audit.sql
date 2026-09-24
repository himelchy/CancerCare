
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

    UPDATE blog_submissions
    SET status = 'approved', reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP, blog_id = new_blog_id
    WHERE submission_id = p_submission_id;
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
