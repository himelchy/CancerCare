CREATE TABLE users 
(
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    contact VARCHAR(15) UNIQUE,
    dob DATE,
    password_hash  VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    emergency_contact VARCHAR(15),

    FOREIGN KEY (patient_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    license_no VARCHAR(50) UNIQUE NOT NULL,
    fees NUMERIC(10,2) CHECK (fees > 0),
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255) NOT NULL,
    district VARCHAR(100),
    area VARCHAR(100) NOT NULL,
    experience_years INT CHECK (experience_years >= 0),
    FOREIGN KEY (doctor_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE hospitals (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(150) NOT NULL,
    registration_no VARCHAR(50) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL,
    district VARCHAR(100) NOT NULL,
    area VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    established_year INT NOT NULL CHECK (established_year >= 1800 AND established_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    website VARCHAR(255),
    bed_capacity INT NOT NULL CHECK (bed_capacity > 0),
    hospital_type VARCHAR(30) DEFAULT 'Private' CHECK (hospital_type IN ('Government', 'Private', 'NGO'))
);
CREATE TABLE admins (
    admin_id INT PRIMARY KEY,
    hospital_id INT NOT NULL,

    FOREIGN KEY (admin_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    FOREIGN KEY (hospital_id)
        REFERENCES hospitals(hospital_id)
);
CREATE TABLE cancers (
    cancer_id SERIAL PRIMARY KEY,
    cancer_name VARCHAR(150) NOT NULL UNIQUE,
    recovery_pct NUMERIC(5,2) CHECK (recovery_pct >= 0 AND recovery_pct <= 100),
    causes TEXT    
);
CREATE TABLE stages (
    cancer_id INT NOT NULL,
    stage_no INT NOT NULL CHECK (stage_no BETWEEN 1 AND 4),
    success NUMERIC(5,2)
        CHECK (success >= 0 AND success <= 100),
    symptoms TEXT,
    PRIMARY KEY (cancer_id, stage_no),
    FOREIGN KEY (cancer_id)
        REFERENCES cancers(cancer_id)
        ON DELETE CASCADE
);
CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL,
    price NUMERIC(10,2) CHECK (price >= 0),
    side_effects TEXT,
    description TEXT,
    ratings NUMERIC(2,1) CHECK (ratings >= 0 AND ratings <= 5),
    manufacturer VARCHAR(150) NOT NULL
);
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    prescription_date DATE NOT NULL DEFAULT CURRENT_DATE,
    description TEXT,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (patient_id)
        REFERENCES patient(patient_id)
        ON DELETE CASCADE
);
CREATE TABLE blogposts (
    blog_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    feel TEXT,
    post_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (patient_id)
        REFERENCES patient(patient_id)
        ON DELETE CASCADE
);