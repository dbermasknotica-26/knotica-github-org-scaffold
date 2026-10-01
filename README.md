# GitHub Org Scaffold: Knotica Solutions Inc

Turns the design in `KNOTICA ERP SYSTEM/CONFIGS/docs/GITHUB_ORG_DESIGN.md` into real repositories, labels, issue forms, templates and (in an organization) teams and permissions. See [Modules and Workflows](KNOTICA%20ERP%20SYSTEM/CONFIGS/docs/MODULES_AND_WORKFLOWS.md) for the operating model and display-name-to-slug mapping.

```
KNOTICA ERP SYSTEM/  Content of each repository (folders, README, CODEOWNERS, issue forms, templates)
KNOTICA ERP SYSTEM/CONFIGS/setup/  Scripts that create everything with the GitHub CLI
KNOTICA ERP SYSTEM/CONFIGS/docs/   Design, module, workflow, and specification documentation
```

Repositories: `.github`, `handbook`, `hrm`, `board-governance`, `sales`, `marketing`, `service-intake`, **`finance-accounting`** (new), `account-management`, `knotica-doc-templates` (+ one `cl-<code>-<project>` per client).

## Two modes

| | `MODE=personal` (default now) | `MODE=org` |
|---|---|---|
| Where | Your personal GitHub account (`ORG` = your username) | A GitHub organization (`ORG` = org slug) |
| Creates | All repos, initial content, labels, template repo, new client repos | Everything in personal mode, plus teams, team permissions, org settings, branch protection, org Project wiring |
| Skipped (prints "skipped") | Teams, team permissions, org settings, org Projects, branch protection | Nothing |
| CODEOWNERS | Team names are replaced by your username so the files are valid | Team names kept |
| Use for | Trying the design, forms, templates and register before committing to an organization | The real setup |

Set it in `KNOTICA ERP SYSTEM/CONFIGS/setup/config.env`, or per command: `MODE=org ./KNOTICA ERP SYSTEM/CONFIGS/setup/setup.sh`.

## Test in a personal account first

1. Install **Git** and the **GitHub CLI** (https://cli.github.com). On Windows use Git Bash or WSL.
2. `gh auth login` and sign in as `dbermasknotica-26` (scopes: `repo`, `workflow`).
3. Open `KNOTICA ERP SYSTEM/CONFIGS/setup/config.env`. `ORG` and `GIT_USER_NAME` are already `dbermasknotica-26`. **Set `GIT_USER_EMAIL`** to your own email or your GitHub no-reply address (GitHub > Settings > Emails); the real run stops until you do.
4. **Preview:** `./KNOTICA ERP SYSTEM/CONFIGS/setup/setup.sh` (dry run: prints commands only).
5. **Apply:** `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/setup.sh`. It stops if you are signed in as a different account.
6. Try it:
   - Open each repo's **New issue** page and check the forms (billing: Invoice Request, Payment Received, Credit Note Request, Billing Dispute).
   - Read the templates in `handbook/templates/` (invoice, payment acknowledgement, credit note, statement, reminders, billing schedule, plus the earlier ones).
   - Open `billing/registers/Knotica_Billing_Register.xlsx`, replace the example rows, and watch the Dashboard.
   - Create a client workspace: `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/new-client.sh TST pilot`. It has `00-engagement` to `07-billing`.
   - Open a PR in `billing` with a wrongly named file (for example `invoices/2026/INVOICE-1.md`) and see the ID check fail.
   - In `billing`, open an Invoice Request issue, add the label `billing:issued`, set *Issue date* to a date well in the past and run **Actions > Overdue Invoice Reminder > Run workflow**. It labels the issue and posts a reminder.
7. **Reset or migrate:** `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/teardown-test.sh` deletes the test repos (it asks you to type a confirmation, and needs `gh auth refresh -s delete_repo`). Then create the organization and run the real setup with `MODE=org`. Your other repos (for example `Specification-Agent`) are never touched.

What does not work in personal mode: teams and permissions, org-wide Projects and their automation (the Project workflows simply do nothing without `PROJECT_URLS`), required reviews on `main`, and the `.github/profile` org page. Collaborators added to a personal repo always get write access.

## Organization setup (when you are ready)

1. **Create the organization** on github.com (Free plan is fine to start). Choose the URL slug (for example `knotica-solutions`) and set the display name to **Knotica Solutions Inc**.
2. `gh auth login` as an org **owner**; add scopes: `gh auth refresh -s admin:org -s workflow`.
3. In `KNOTICA ERP SYSTEM/CONFIGS/setup/config.env` set `MODE="org"` and `ORG="<your-org-slug>"`; set your own name and email.
4. Preview with `./KNOTICA ERP SYSTEM/CONFIGS/setup/setup.sh`, then apply with `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/setup.sh`.
5. In the web UI: add people to the teams (now including `finance`), require two-factor authentication, create the org Projects (see below).
6. Onboard a client: `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/new-client.sh NWB core-migration <client-github-username>`.

Run any single step on its own, e.g. `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/04-labels.sh finance-accounting`.

| Automated by these scripts | Manual (GitHub web UI) |
|---|---|
| Repos, initial content, template-repo flag | Create the organization itself |
| Teams and team-to-repo permissions (org mode) | Add people to teams |
| Standard labels in every repo, billing labels in `billing` | Require two-factor authentication for members |
| Branch protection on `main` (org mode, see plan note) | Create org-level Projects (boards) |
| Org defaults (org mode) | Invite clients (new-client.sh does it per client) |
| New client workspace from template | Git LFS / document store decisions |

## Billing module

Covers the billing practice for clients: invoices, payments, credit notes, statements, reminders and collections.

| Piece | Where |
|---|---|
| Finance-only repo with folders, issue forms, workflows | `KNOTICA ERP SYSTEM/FINANCE & ACCOUNTING` (becomes the `finance-accounting` repo) |
| Billing register workbook (invoices, payments, credit notes, client billing profiles, ageing, integrity checks) | `KNOTICA ERP SYSTEM/FINANCE & ACCOUNTING/registers/Knotica_Billing_Register.xlsx` (Instructions tab inside) |
| Invoice, payment acknowledgement, credit note, statement, reminder letters, billing schedule | `KNOTICA ERP SYSTEM/HANDBOOK/templates/` |
| Billing process (Mermaid flow, roles, target times, month-end checklist) | `KNOTICA ERP SYSTEM/HANDBOOK/processes/billing-and-collections.md` |
| Billing policy (models, terms, approvals, collections, data handling) | `KNOTICA ERP SYSTEM/HANDBOOK/policies/billing-policy.md` |
| Client-facing billing folder | `KNOTICA ERP SYSTEM/KNOTICA DOC TEMPLATES/07-billing/` (in every client repo) |
| `finance` team, billing labels, Project 7 *Billing & Collections* | `KNOTICA ERP SYSTEM/CONFIGS/setup/teams.txt`, `KNOTICA ERP SYSTEM/CONFIGS/setup/labels-finance-accounting.txt`, `KNOTICA ERP SYSTEM/CONFIGS/setup/projects.txt` |

Things to decide (they are marked as defaults in the policy): standard payment terms, approval thresholds, write-off limits, deposit percentage, and which accounting system is the book of record. Check the invoice content and retention rules for your country with your accountant.

## Automation (GitHub Actions)

| Workflow | Where | What it does |
|---|---|---|
| `project-automation.yml` | reusable in `.github`; called from `sales`, `marketing`, `service-intake`, `hrm`, `finance-accounting`, `knotica-doc-templates` and every client repo | Adds issues/PRs to the Project(s), sets **Status** from `status:*` labels, sets **Client** from the repo name. Does nothing without the repo variable `PROJECT_URLS` (organization only) |
| `sla-reminder.yml` | reusable; hourly from `service-intake` and client repos | Labels `sla:breached` and comments when an issue is still in triage past its window |
| `quarterly-access-review.yml` | `handbook` | Opens the access review checklist each quarter (includes `finance-accounting`) |
| `id-check.yml` | `sales` | Fails a PR if a `PROP-`/`QUO-` file name is wrong |
| `id-check.yml` | `finance-accounting` | Fails a PR if an `INV-`, `RCT-`, `CN-` or `STMT-` file name is wrong |
| `overdue-reminder.yml` | `finance-accounting`, daily | For open issues labelled `billing:issued`: works out the due date from *Issue date* + *Payment terms (days)* in the issue, labels `billing:overdue`, and posts one escalation comment at 1, 15, 30 and 60 days past due. Skips `billing:paid` and `billing:disputed`. Works in personal mode too |

### Project automation setup (organization only)

1. Create the org Projects in this order so the numbers match `KNOTICA ERP SYSTEM/CONFIGS/setup/projects.txt`: 1 Sales Pipeline, 2 Delivery Portfolio, 3 Service Requests, 4 Product Roadmap, 5 Internal Ops, 6 Marketing Calendar, **7 Billing & Collections**.
2. In each Project add a **Status** single-select field (Triage, In Progress, Blocked, In Review, Approved, Done). In *Delivery Portfolio* also add a text field **Client**.
3. Create a token with `project` and `repo` scope (classic PAT, or a GitHub App). The default `GITHUB_TOKEN` cannot write org Projects.
4. `export PROJECT_TOKEN_VALUE=<token>` then `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/07-project-config.sh`.
5. Re-run `DRY_RUN=false ./KNOTICA ERP SYSTEM/CONFIGS/setup/04-labels.sh` so labels such as `sla:breached` exist.
6. Test: open an issue in `service-intake` and check it appears in the Project with Status *Triage*.

## Document registers

- `KNOTICA ERP SYSTEM/SALES/registers/Knotica_Document_Register.xlsx`: proposals (`PROP-`) and quotations (`QUO-`).
- `KNOTICA ERP SYSTEM/FINANCE & ACCOUNTING/registers/Knotica_Billing_Register.xlsx`: invoices (`INV-`), payments (`RCT-`), credit notes (`CN-`).

Both are binary files: one owner edits at a time, or keep the live file in SharePoint / Google Drive and store a copy in the repo.

## Notes and limits

- Scripts are **idempotent where practical** (existing repos are skipped; labels use `--force`). Review the dry run first.
- **`.github` is created public** on purpose: org-wide defaults and reusable workflows only apply to private repos when it is public. It holds no confidential content.
- **Branch protection on private repos needs a paid GitHub plan** (org mode). It is skipped entirely in personal mode, because required reviews would stop a sole owner from merging.
- Team names in `CODEOWNERS` need **write access** to the repo, which `permissions.csv` and `new-client.sh` grant.
- The scripts and workflows were syntax-checked and dry-run, but **not run against a live GitHub account** (GitHub Actions cannot run from here). The personal test is the first real run; start there.
- `GITHUB_ORG_DESIGN.md` is also saved as `KNOTICA ERP SYSTEM/HANDBOOK/standards/github-org-design.md`. Keep the two in step.
- Not included yet: release-notes drafter, PDF export of approved proposals and invoices, and a workflow version of the new-client bootstrap.

## Customising

- Add or remove repos: edit `KNOTICA ERP SYSTEM/CONFIGS/setup/repos.txt`, update `source-folders.txt`, and add or rename the corresponding source folder under `KNOTICA ERP SYSTEM/`.
- Change access: edit `KNOTICA ERP SYSTEM/CONFIGS/setup/permissions.csv` and re-run `03-permissions.sh` (org mode).
- Change labels: edit `KNOTICA ERP SYSTEM/CONFIGS/setup/labels.txt` (all repos) or `KNOTICA ERP SYSTEM/CONFIGS/setup/labels-finance-accounting.txt` (`finance-accounting` only) and re-run `04-labels.sh`.
- Change teams: edit `KNOTICA ERP SYSTEM/CONFIGS/setup/teams.txt`, `KNOTICA ERP SYSTEM/CONFIGS/setup/permissions.csv` and the team names in the `CODEOWNERS` files.
