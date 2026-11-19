# Checking on a real calculator

The automated tests run on a computer and cannot show that a sheet looks right on a TI-Nspire.
Before you rely on a new build, and after any change to `src/shared/`, work through this list.
It takes about ten minutes. `docs/LOADING_GUIDE.txt` explains how to copy the files across.

## 1. One sheet of each layout

Words in square brackets are keys to press; the rest are numbers to type.

| Sheet | Press | You should see |
|---|---|---|
| `03_ABC_Pool_Rate` | 6000 [enter] 300 [enter] 100 [enter] 150 | Rate /driver 20; A allocated 2000; B allocated 3000; Unused cap cost 1000 |

For each, also check:

- the title, labels and boxes are all on screen and nothing overlaps;
- a letter key does nothing;
- the `(-)` key types a minus sign in an empty field.

## 2. Changes in version 1.0.0

| Check | How |
|---|---|
| Large values keep their digits | `05_Cost_to_Serve`: 123456.78, enter, 0. Profit should read 123456.78, not 123457. |

## If something is wrong

Note the sheet, what you typed and what the screen showed, and open an issue.
