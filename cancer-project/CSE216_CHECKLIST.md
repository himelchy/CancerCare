# CancerCare CSE216 Review Notes

This project keeps its current patient, doctor, and admin workflow. The browser controls navigation and role-specific screens; the Express API and PostgreSQL enforce access and data changes.

## Authentication and permissions

- Patient passwords are hashed with Node.js `scrypt`; plaintext passwords are not stored.
- The API signs 12-hour bearer tokens with an HMAC key. Tokens include the user ID, expiry, and role. The local key is saved in the ignored `backend/.auth-secret` file, or supplied as `AUTH_SECRET` in the environment.
- `GET /api/auth/me` verifies a saved token before the browser restores a role-specific dashboard. Protected API routes verify the signature and expiry, look up the current account role in PostgreSQL, and compare it with `requireRole("Patient")`, `requireRole("Doctor")`, or `requireRole("Admin")`.
- The browser’s displayed role is not authorization. Changing browser storage cannot grant API permissions.
- Patient-only routes return that patient’s own appointments, prescriptions, story submissions, and author-owned stories. Published community stories and Learn articles are public. Doctors can read appointment requests for their doctor account; prescription writes require an appointment assigned to that doctor. Admin review and assignment routes require an admin account.
- Public hospital, doctor-directory, cancer-guide, published-story, and published-Learn endpoints contain the site’s public information. Private API responses use `Cache-Control: no-store`.
- Login failures are rate-limited per client address. CORS permits local development origins and any explicit origins listed in `CORS_ORIGINS`.

## Transactions and database routines

- `withTransaction` starts a transaction, commits on success, rolls back on failure, and always releases its database connection. `transactionQuery` uses it for single-statement writes.
- Multi-table workflows use one checked-out client and explicit `BEGIN`, `COMMIT`, and `ROLLBACK`. Patient registration, prescription saves, content approval, and content deletion are examples.
- Blog and Learn approvals call their stored procedures inside an application-managed transaction. The procedure either publishes content and approves its submission together or the call is rolled back.
- `record_submission_status_change()` is the trigger function for the blog, Learn, and content-update status triggers. It records old and new status in `submission_status_audit` and sets `reviewed_at` when a pending item is approved or rejected.
- `get_cancercare_statistics()` is the database function used for overview counts.
- `approve_blog_submission()` and `approve_learn_submission()` are the multi-table publishing procedures.

## Complex query examples

- `GET /api/overview` calls the statistics function, which aggregates network and review counts.
- `GET /api/doctors` combines user, doctor, cancer-specialty, and hospital data, then sorts and limits matching results.
- `GET /api/cancers` joins cancer and hospital mappings and counts distinct hospitals per cancer type.
- `GET /api/prescriptions/mine` joins prescriptions, doctors, visits, medicines, and prescription-medicine rows, aggregating medicine details for the signed-in patient.
- Admin appointment and submission routes join patient, doctor, user, and workflow tables for review and assignment screens.

## Database configuration

Local database credentials are read from the ignored root `.env` file or process environment variables. `.env.example` documents the expected settings without containing a real password. Runtime initialization creates the application workflow tables and database routines when the backend starts.
