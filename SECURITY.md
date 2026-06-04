# Security Policy

## Sensitive Data

Do not commit:

- Power Platform access tokens, refresh tokens, cookies, session exports, or CLI caches.
- SQL, Dataverse, SharePoint, Outlook, HTTP, custom connector, or gateway credentials.
- Supabase service-role keys or other backend API keys.
- Environment-variable current values.
- Exported cloud-flow run payloads containing customer data.
- Connection IDs, tenant-private URLs, or screenshots unless explicitly sanitized.

## Reporting

Open a private GitHub security advisory or contact the maintainer directly for suspected secret exposure or unsafe tenant-impacting guidance.
