# Policy: Billing, Payment and Collections

| Field | Value |
|---|---|
| Document ID | POL-BILL-001 |
| Owner | Finance lead / Management |
| Status | Draft for review. Every figure marked **(default)** is a proposal for management to confirm |
| Process | `handbook/processes/billing-and-collections.md` |

## 1. Principles

1. **No invoice without a basis:** an accepted quotation (`QUO-...`), SOW, or approved Change Request. The invoice quotes that reference and the client's PO if one is required.
2. **Every document has an ID** (`INV`, `RCT`, `CN`, `STMT`). IDs are never reused or deleted.
3. **Issued documents are never edited.** Corrections are made with a credit note and, if needed, a new invoice.
4. **GitHub is not the ledger.** The accounting system and bank are the books of record. The register and repo are reconciled to them monthly.
5. **Clients never see internal billing data.** Invoices and statements go to them as PDFs and into their own `07-billing/` folder. This repo stays finance-only.

## 2. Billing models

| Model | When we invoice | Evidence required |
|---|---|---|
| Deposit / advance | At signature or kickoff (default 30% of the quoted total) | Signed SOW |
| Fixed-price milestone | On client acceptance of the milestone | Sign-off or UAT acceptance |
| Time and materials | Monthly in arrears | Approved timesheets and rate card |
| Retainer / support plan | Monthly or quarterly in advance | Support agreement |
| Change request | On approval of the Change Request, or per its own schedule | Approved CR |
| Expenses | With the next invoice, at cost | Receipts and prior client approval where the contract requires it |

## 3. Terms

- **Payment terms (default):** net 30 days from the invoice date. The client's terms are recorded in the register Clients sheet; the invoice and the issue form carry them.
- **Currency:** the quotation currency. Do not mix currencies on one invoice. Totals in the register are not converted.
- **Tax:** apply the tax treatment agreed in the quotation. Where the client withholds tax at source, record the withheld amount on the payment and chase the withholding certificate. Local rules decide the details; confirm them with your accountant.
- **Late payment:** as stated in the agreement. Do not add late fees that the contract does not allow.

## 4. Approvals

| Item | Approver |
|---|---|
| Invoice up to `<threshold>` (default: finance lead) | Finance lead |
| Invoice above `<threshold>` | Management |
| Every credit note | Management |
| Final notice letter | Management |
| Write-off up to `<limit>` | Management |
| Write-off above `<limit>` | Board (approval request in `board-governance`) |
| Refund of an overpayment | Management |

Management sets the thresholds. Until they are set, management approves every invoice.

## 5. Collections

Reminders are prompted by the `overdue-reminder` workflow. Defaults:

| Days past due | Action | Who |
|---|---|---|
| 1 | Friendly reminder (level 1) | Finance |
| 15 | Firm reminder (level 2) and a call to the client billing contact | Finance |
| 30 | Escalate to management. Review pausing non-contractual work | Management |
| 60 | Final notice (level 3) or write-off review | Management, Board if above limit |

A disputed invoice is paused (label `billing:disputed`). Acknowledge the dispute within 2 business days, ask the client to pay any undisputed portion, and resolve with evidence, a credit note, or written confirmation that the invoice stands.

## 6. Overpayments, part payments and unmatched funds

- Part payments are recorded against the invoice and the balance stays open.
- An overpayment is held as a credit and applied to the next invoice or refunded, as management decides, within 10 business days (default).
- Funds that cannot be matched to an invoice are recorded as unmatched and queried with the client within 2 business days.

## 7. Data handling

- Never store client card numbers, client bank account numbers, passwords or bank statements in GitHub.
- Our own bank details appear only on invoices, copied from the finance-approved source.
- Contacts are recorded by role and business address where possible.
- Retention: keep billing records for the period required by local law. Confirm the period with your accountant and record it here: `<years>`.

## 8. Controls

- Separation of duties where staffing allows (prepare, approve, record payments).
- Register Dashboard integrity checks must show OK at month-end.
- Month-end reconciliation to the accounting system and bank is signed off by management.
- Quarterly access review of the `billing` repo (included in the access review issue).
