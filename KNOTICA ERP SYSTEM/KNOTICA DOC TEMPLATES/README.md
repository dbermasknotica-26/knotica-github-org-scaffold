# Client Workspace: <CLIENT NAME> / <PROJECT>

_Knotica Solutions Inc_

TEMPLATE: standard structure for every client workspace.

> **Template repo.** Do not work in this repo directly. Use `setup/new-client.sh` to create `cl-<code>-<project>` from it, then replace the placeholders below.

| Field | Value |
|---|---|
| Client | `<CLIENT NAME>` |
| Client code | `<CODE>` |
| Engagement lead | `@handle` |
| Client contact | `<name, email>` |

## How to raise a request
Open an issue using **New issue** and pick the matching form (Service Request, Change Request, Bug Report, Incident).

## Structure

| Folder | Purpose |
|---|---|
| `00-engagement/` | Charter, signed SOW copy, RACI, communication plan, contacts. |
| `01-specs/` | SPEC-<CODE>-###-*.md using the Specification Design template. |
| `02-design/` | Architecture, decision records (ADRs), diagrams, UX. |
| `03-delivery/` | Plan, weekly status reports, meeting notes, RAID log. |
| `04-testing/` | Test plans, UAT scripts, results. |
| `05-releases/` | CHANGELOG.md, release notes, deployment runbooks. |
| `06-support/` | Runbooks, SLA, client-facing incident reports. |
| `07-billing/` | Client-facing billing documents: agreed billing schedule, issued invoices, statements, payment acknowledgements (internal billing data stays in the `billing` repo). |
| `assets/` | Images and diagrams (large binaries via Git LFS). |
