# Payment Reminder Templates

Three levels. Send the level that matches the days past due (the `overdue-reminder` workflow in `billing` prompts you at 1, 15, 30 and 60 days).
Replace every `<placeholder>`. Keep a record in `billing/collections/<CODE>.md`.

## Level 1: Friendly reminder (1+ days overdue)

**Subject:** Reminder: invoice `<INV-YYYY-###>` was due on `<date>`

Hello `<name>`,

Our records show invoice `<INV-YYYY-###>` for `<currency amount>` was due on `<date>`. If payment is already on its way, thank you, and please send the remittance advice. If anything is blocking payment (a missing PO, a query, a change of billing contact), let us know and we will sort it out quickly.

A copy of the invoice is attached.

Kind regards,
`<name>`, Knotica Solutions Inc

## Level 2: Firm reminder (15+ days overdue)

**Subject:** Overdue: invoice `<INV-YYYY-###>`, `<n>` days past due

Hello `<name>`,

Invoice `<INV-YYYY-###>` for `<currency amount>` is now `<n>` days past its due date of `<date>`. Please arrange payment by `<date, within 7 days>` or tell us the date you expect to pay. If you dispute any part of the invoice, tell us which part and why so we can resolve it; the undisputed portion remains payable.

Statement of account attached.

Kind regards,
`<name>`, Knotica Solutions Inc

## Level 3: Final notice (30+ days overdue, management approved before sending)

**Subject:** Final notice: invoice `<INV-YYYY-###>`

Dear `<name>`,

Despite our earlier reminders, invoice `<INV-YYYY-###>` for `<currency amount>` remains unpaid, `<n>` days after its due date. Under the agreement (`<clause reference>`), if payment or a written payment plan is not received by `<date>`, we may `<pause non-contractual work / apply the late payment terms / escalate>`.

Please contact `<name, role>` today to resolve this.

Yours sincerely,
`<management signatory>`, Knotica Solutions Inc
