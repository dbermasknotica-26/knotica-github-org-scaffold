# sales

_Knotica Solutions Inc_

Pipeline, proposals, quotations and pricing.

## Structure

| Folder | Purpose |
|---|---|
| `pipeline/` | One folder per prospect: <year>-<prospect>/ (lead notes, proposal, quotation). |
| `templates/` | Proposal, quotation, SOW and NDA templates. |
| `pricing/` | Rate cards and estimation models (management review). |
| `registers/` | Knotica_Document_Register.xlsx: proposal (PROP-YYYY-###) and quotation (QUO-YYYY-###) ID register. One owner edits it; read the Instructions tab. |
| `win-loss/` | Post-decision reviews. |

An accepted quotation is billed from the `billing` repo. Keep the `QUO-` ID on every invoice request so each invoice traces back to its quotation.
