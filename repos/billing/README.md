# billing

_Knotica Solutions Inc_

Invoices, payments, credit notes and collections. **Finance-only: never share this repo with clients.**
The client-facing copies of what we issue (invoices, statements, payment confirmations) go into each client's
`cl-<code>-<project>/07-billing/` folder.

> **GitHub is not the accounting ledger.** Your accounting software (and bank) stay the source of truth for the books and tax filings.
> This repo holds the documents, approvals and an operational register, and is reconciled to the accounting system every month.

## Structure

| Folder | Purpose |
|---|---|
| `invoices/<year>/` | Issued invoices: `INV-YYYY-###-<code>-<slug>.md` (+ PDF export). |
| `payments/<year>/` | Payment acknowledgements: `RCT-YYYY-###-<code>-<slug>.md`. Reference numbers only, never account or card numbers. |
| `credit-notes/<year>/` | Credit notes: `CN-YYYY-###-<code>-<slug>.md`. Issued invoices are never edited; correct them with a credit note. |
| `statements/` | Monthly client statements: `STMT-<CODE>-YYYY-MM.md`. |
| `collections/` | Per-client follow-up log and dispute notes: `<CODE>.md`. |
| `registers/` | `Knotica_Billing_Register.xlsx`: invoice, payment and credit note IDs, balances and ageing. Read its **Instructions** tab. |
| `reports/` | Month-end receivables (ageing) reports and reconciliation sign-off. |

## The billing flow

1. Delivery lead opens an **Invoice Request** issue (needs an accepted quotation `QUO-...` or an approved change request).
2. Finance takes the next ID from the register, prepares the invoice from `handbook/templates/invoice.md`, and gets it approved.
3. Finance issues it, sets the label `billing:issued`, and copies the PDF to the client's `07-billing/` folder.
4. When money arrives, finance opens a **Payment Received** issue, records it in the register, and issues the acknowledgement.
5. The overdue workflow labels and nudges unpaid invoices on a schedule. Finance follows the reminder levels in `handbook/policies/billing-policy.md`.
6. Fully paid: label `billing:paid` and close the invoice issue.

## Document IDs

| Document | Pattern | Example |
|---|---|---|
| Invoice | `INV-YYYY-###` | `INV-2026-001` |
| Payment acknowledgement | `RCT-YYYY-###` | `RCT-2026-001` |
| Credit note | `CN-YYYY-###` | `CN-2026-001` |
| Statement | `STMT-<CODE>-YYYY-MM` | `STMT-NWB-2026-10` |

Numbers are sequential within a year, never reused and never skipped silently (void a number instead of deleting it).

## Never put in this repo

Client card numbers, client bank account numbers, passwords, bank statements, payroll or personal data.
Payment evidence is a reference (bank reference, remittance advice number), not the account details.
