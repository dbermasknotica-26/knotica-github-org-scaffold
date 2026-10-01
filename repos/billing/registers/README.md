# registers

`Knotica_Billing_Register.xlsx` holds the invoice (INV), payment (RCT) and credit note (CN) registers, client billing
profiles, balances, ageing and integrity checks. Read the **Instructions** tab first.

- One register owner edits the file (binary files cannot be merged). Others request IDs from the owner.
- Take the next ID from the **Dashboard** tab. Never delete rows: set the status to Void.
- Reconcile to the accounting system and bank at month-end, then save the sign-off in `reports/`.
