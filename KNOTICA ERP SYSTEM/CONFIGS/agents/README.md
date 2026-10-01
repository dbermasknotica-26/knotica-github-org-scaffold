# Knotica Module Agents

These files define the operating contract for one agent per main ERP module. They are implementation-neutral specifications for a future GitHub App, workflow runner, or agent host.

## Common contract

Every agent must:

- Read only the repositories and paths listed in its scope.
- Use the GitHub-safe repository slug, not the human-facing folder name, for API calls.
- Prefer approved templates and existing records over invented formats.
- Create drafts, issues, or pull requests before changing controlled records.
- Apply labels, owners, due dates, and links required by the module workflow.
- Record the requester, source issue, action taken, generated artifacts, and approval state.
- Stop and request human approval for sensitive, irreversible, external, financial, personnel, legal, governance, or publication actions.
- Never send email or modify permissions without an explicitly approved integration policy.

## Agent registry

| Agent | Repository slug | Primary scope |
| --- | --- | --- |
| Account Management Agent | `account-management` | Client context and account plans |
| Finance and Accounting Agent | `finance-accounting` | Billing, collections, payments, and reconciliation |
| Handbook Agent | `handbook` | Policies, processes, standards, training, and templates |
| HRM Agent | `hrm` | Leave, incidents, meetings, handovers, and announcements |
| Board Governance Agent | `board-governance` | Approvals, minutes, resolutions, decks, and financial summaries |
| Document Templates Agent | `knotica-doc-templates` | Client workspace structure and delivery templates |
| Marketing Agent | `marketing` | Campaigns, brand, content, case studies, and analytics |
| Sales Agent | `sales` | Pipeline, pricing, proposals, registers, and win/loss |
| Service Intake Agent | `service-intake` | Request capture, triage, routing, and SLA tracking |

## Shared tool interface

A host should expose these logical tools with repository-level authorization:

- `search_records(query, scope)`
- `read_record(path)`
- `create_draft(path, template, fields)`
- `create_issue(fields)`
- `create_pull_request(files, title, summary)`
- `apply_labels(issue, labels)`
- `assign_owner(issue, owner)`
- `link_records(source, target)`
- `generate_report(type, period, sources)`
- `request_approval(action, approvers, evidence)`
- `notify(recipient, message, source_link)`

The host must enforce scope and approval policy before a tool call. Agents should not receive unrestricted shell, repository-admin, email-send, or delete permissions.

## Delivery stages

1. Read-only search and summarization.
2. Draft generation from approved templates.
3. Issue or pull-request creation.
4. Labels, ownership, due dates, Project updates, and cross-links.
5. Human approval and controlled merge.
6. Notifications and scheduled reports.

Start every agent at stage 1 or 2. Promote actions only after the module owner has tested the agent with representative records.
