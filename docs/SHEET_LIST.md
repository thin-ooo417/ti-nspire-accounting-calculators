# Sheet list

Made by `python scripts/make_sheet_list.py` from the files in `src/`. Do not edit by hand.

"Title on screen" is what the calculator shows at the top of the sheet. "Formula or hint" is the
line printed under it. Inputs are listed in the order they appear on screen.

## Accounting (5 sheets)

Source folder: `src/accounting/`

| File | Title on screen | Formula or hint | Inputs | Form layout |
|---|---|---|---|---|
| `01_Traditional_Costing` | 1. Traditional (volume) costing | Rate = OH / total volume (same rate every unit) | OH overhead pool; PA price/unit A; QA volume A; CA direct cost/unit A; PB price/unit B; QB volume B; CB direct cost/unit B | `form_standard` |
| `02_Time_Driven_ABC` | 2. Time-driven ABC (TDABC) | Rate = pool / capacity min; OH/unit = rate x t | P cost pool; cap capacity min per resource; n resources in parallel; tA min/unit A; QA volume A; tB min/unit B; QB volume B | `form_standard` |
| `03_ABC_Pool_Rate` | 3. ABC pool rate & allocation | Rate = pool cost / driver qty (run once per pool) | P pool cost; D driver qty available; dA driver used by A; dB driver used by B | `form_standard` |
| `04_Traditional_vs_ABC` | 4. Traditional vs ABC (one product) | Cross-subsidy = (OH trad - OH abc) x Q | P price/unit; Q volume; DC direct cost/unit; OH1 traditional OH/unit; OH2 ABC OH/unit | `form_standard` |
| `05_Cost_to_Serve` | 5. Cost-to-serve (customer profit) | Profit = Sales - Direct - sum(qty x rate) - Other | S sales; D direct costs; q1 activity 1 qty; r1 activity 1 rate; q2 activity 2 qty; r2 activity 2 rate; q3 activity 3 qty; r3 activity 3 rate; Oth other activity cost | `form_standard` |

Total: 5 sheets.
