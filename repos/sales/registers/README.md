# registers

`Knotica_Document_Register.xlsx` is the register of proposal (PROP-YYYY-###) and quotation (QUO-YYYY-###) IDs,
with status, value, validity and client codes. Read the **Instructions** tab first.

- One register owner edits the file (binary files cannot be merged). Others request IDs from the owner.
- Always take the next ID from the **Dashboard** tab. Never delete rows; set the status to Void.
- File and folder names in `pipeline/` must start with the ID, e.g. `PROP-2026-002-core-migration.md`.
- Invoices, payments and credit notes are tracked separately in `billing/registers/Knotica_Billing_Register.xlsx`.
