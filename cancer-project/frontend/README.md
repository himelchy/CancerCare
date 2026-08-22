# CancerCare React Frontend

A frontend-only React implementation based on the Cancer Care ERD supplied with the project.

## Included
- Dashboard
- Hospitals
- Doctors
- Patients
- Cancers
- Cancer Stages (weak entity)
- Medicines
- Prescriptions
- Blog Posts
- Admins
- Mock relationship records
- Add-record modal forms using local in-memory state

## ERD coverage
The interface reflects these major relationships:
- Hospital manages Admin
- Hospital treats Cancer
- Hospital works with Doctor
- Doctor specializes in Cancer
- Cancer has Stage records
- Cancer is treated with Medicine
- Doctor issues Prescription
- Prescription is given to Patient
- Prescription contains Medicine
- Stage is diagnosed for Patient
- Doctor/Admin assignment
- Doctor-to-Doctor referral
- Patient writes Blogpost
- Doctor mentions Blogpost

## Run

```bash
npm install
npm run dev
```

Then open the local Vite URL shown in the terminal.

## Note
This is intentionally frontend-only. The current records are mock data in `src/data/mockData.js`.
Later, replace the mock arrays and local form handlers with API calls when the backend/database is ready.
