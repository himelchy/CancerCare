CREATE TABLE IF NOT EXISTS cancer_treatment_information (
    information_id SERIAL PRIMARY KEY,
    cancer_id INTEGER NOT NULL REFERENCES cancers(cancer_id) ON DELETE CASCADE,
    medicine_name VARCHAR(160) NOT NULL,
    treatment_class VARCHAR(120) NOT NULL,
    indication_summary TEXT NOT NULL,
    how_it_works TEXT NOT NULL,
    common_side_effects TEXT NOT NULL,
    serious_side_effects TEXT,
    stage_scope VARCHAR(80),
    outcome_summary TEXT,
    outcome_population TEXT,
    information_source_title VARCHAR(250) NOT NULL,
    information_source_url TEXT NOT NULL,
    outcome_source_title VARCHAR(250),
    outcome_source_url TEXT,
    reviewed_at DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (cancer_id, medicine_name)
);

CREATE INDEX IF NOT EXISTS cancer_treatment_information_cancer_idx
    ON cancer_treatment_information (cancer_id, medicine_name);

-- Starter reference records for breast cancer. These are educational summaries,
-- not treatment recommendations. A stage_scope of NULL means the reference is
-- not restricted to one numbered stage; biomarker and clinical context still apply.
INSERT INTO cancer_treatment_information (
    cancer_id, medicine_name, treatment_class, indication_summary, how_it_works,
    common_side_effects, serious_side_effects, stage_scope, outcome_summary,
    outcome_population, information_source_title, information_source_url,
    outcome_source_title, outcome_source_url, reviewed_at
)
SELECT c.cancer_id,
       'Tamoxifen',
       'Hormone therapy (selective estrogen receptor modulator)',
       'May be used for hormone receptor-positive breast cancer, including some early-stage, recurrent, or advanced disease. Whether it is appropriate depends on tumor biomarkers, menopausal status, prior treatment, and the oncology team’s assessment.',
       'Blocks estrogen signaling in breast tissue. It is used as part of a clinician-selected treatment plan, not as a stand-alone recommendation from this page.',
       'Possible effects include hot flashes and fatigue. Side effects differ between people.',
       'Tamoxifen is associated with increased risks of blood clots and endometrial cancer. A clinician should review personal risk factors and new symptoms.',
       NULL,
       'In the ATLAS trial, among people with estrogen receptor-positive early breast cancer who had already completed 5 years of tamoxifen, the reported recurrence risk during years 5–9 was 25.1% for those stopping at 5 years and 21.4% for those continuing to 10 years. Breast-cancer death risk during that period was 15.0% and 12.2%, respectively. These are trial-group comparisons, not a personal cure or success rate.',
       'ATLAS trial population: people with ER-positive early breast cancer after 5 years of adjuvant tamoxifen; compared continuing to 10 years with stopping at 5 years.',
       'Tamoxifen Citrate — NCI Drug Information',
       'https://www.cancer.gov/about-cancer/treatment/drugs/tamoxifencitrate',
       'Ten Years of Tamoxifen Reduces Breast Cancer Recurrences, Improves Survival — NCI',
       'https://www.cancer.gov/types/breast/research/10-years-tamoxifen',
       DATE '2026-09-25'
FROM cancers c
WHERE LOWER(c.cancer_name) LIKE '%breast%'
ON CONFLICT (cancer_id, medicine_name) DO NOTHING;

-- Glioblastoma-specific references under the brain/CNS cancer category.
INSERT INTO cancer_treatment_information (
    cancer_id, medicine_name, treatment_class, indication_summary, how_it_works,
    common_side_effects, serious_side_effects, stage_scope, outcome_summary,
    outcome_population, information_source_title, information_source_url,
    outcome_source_title, outcome_source_url, reviewed_at
)
SELECT c.cancer_id,
       'Temozolomide',
       'Chemotherapy (alkylating agent)',
       'For adults with newly diagnosed glioblastoma, temozolomide is used with radiation therapy and then as maintenance treatment. Brain tumors are not all the same; this entry applies to glioblastoma and not every brain/CNS cancer.',
       'Damages tumor-cell DNA. The standard newly diagnosed glioblastoma approach combines it with radiation, followed by maintenance cycles; a neuro-oncology team determines whether it is suitable.',
       'Common reported effects include fatigue, nausea, vomiting, constipation, reduced appetite, headache, and hair loss.',
       'It can suppress bone marrow and lower blood cell counts, increasing infection or bleeding risk. Blood counts require monitoring by the treating team.',
       NULL,
       'In the pivotal newly diagnosed glioblastoma trial, 3-year overall survival was 16.0% with radiation plus temozolomide and 4.4% with radiation alone. This measures the combined treatment regimen in that trial population; it is not a temozolomide-only cure rate or an individual prediction.',
       'Adults with newly diagnosed glioblastoma treated after surgery; randomized comparison of radiation plus concurrent/adjuvant temozolomide versus radiation alone.',
       'Temozolomide — NCI Drug Information',
       'https://www.cancer.gov/about-cancer/treatment/drugs/temozolomide',
       'Central Nervous System Tumors Treatment (PDQ), Glioblastoma evidence — NCI',
       'https://www.cancer.gov/types/brain/hp/adult-brain-treatment-pdq',
       DATE '2026-09-25'
FROM cancers c
WHERE LOWER(c.cancer_name) LIKE '%brain%'
ON CONFLICT (cancer_id, medicine_name) DO NOTHING;

INSERT INTO cancer_treatment_information (
    cancer_id, medicine_name, treatment_class, indication_summary, how_it_works,
    common_side_effects, serious_side_effects, stage_scope, outcome_summary,
    outcome_population, information_source_title, information_source_url,
    outcome_source_title, outcome_source_url, reviewed_at
)
SELECT c.cancer_id,
       'Bevacizumab',
       'Targeted therapy (angiogenesis inhibitor)',
       'Approved for adults with glioblastoma that has come back (recurrent disease). It is not a general medicine for every brain tumor or a standard first treatment for newly diagnosed glioblastoma.',
       'Blocks VEGF, a signal tumors can use to grow new blood vessels. A neuro-oncology team decides whether it fits the specific situation.',
       'Possible effects include high blood pressure, nosebleeds or other bleeding, headache, and protein in the urine.',
       'Important risks include serious bleeding or blood clots and impaired wound healing. The care team needs to consider surgery timing and individual risks.',
       NULL,
       'In an NCI-described phase II study of recurrent glioblastoma, tumor responses were observed in 26% of patients receiving bevacizumab alone, with a median response duration of 4.2 months. This was a single-arm study and a tumor-response measure, not a cure rate or proof of longer survival.',
       'Adults with recurrent glioblastoma in a noncomparative phase II study; bevacizumab-alone arm used for FDA approval review.',
       'Bevacizumab — NCI Drug Information',
       'https://www.cancer.gov/about-cancer/treatment/drugs/bevacizumab',
       'Central Nervous System Tumors Treatment (PDQ), recurrent glioblastoma evidence — NCI',
       'https://www.cancer.gov/types/brain/hp/adult-brain-treatment-pdq',
       DATE '2026-09-25'
FROM cancers c
WHERE LOWER(c.cancer_name) LIKE '%brain%'
ON CONFLICT (cancer_id, medicine_name) DO NOTHING;

INSERT INTO cancer_treatment_information (
    cancer_id, medicine_name, treatment_class, indication_summary, how_it_works,
    common_side_effects, serious_side_effects, stage_scope, outcome_summary,
    outcome_population, information_source_title, information_source_url,
    outcome_source_title, outcome_source_url, reviewed_at
)
SELECT c.cancer_id,
       'Anastrozole',
       'Hormone therapy (aromatase inhibitor)',
       'May be used for certain hormone receptor-positive breast cancers in postmenopausal patients, including some early-stage and advanced disease. Eligibility depends on biomarkers, menopausal status, prior treatment, and clinical assessment.',
       'Reduces estrogen production by inhibiting aromatase. It can slow cancers that depend on estrogen; it is not appropriate for every breast cancer subtype.',
       'Possible effects of aromatase inhibitors include fatigue, joint or muscle pain, and reduced bone mineral density.',
       'Bone loss and fractures are concerns that clinicians may monitor during aromatase-inhibitor therapy.',
       NULL,
       NULL,
       NULL,
       'Anastrozole — NCI Drug Information',
       'https://www.cancer.gov/about-cancer/treatment/drugs/anastrozole',
       NULL,
       NULL,
       DATE '2026-09-25'
FROM cancers c
WHERE LOWER(c.cancer_name) LIKE '%breast%'
ON CONFLICT (cancer_id, medicine_name) DO NOTHING;
