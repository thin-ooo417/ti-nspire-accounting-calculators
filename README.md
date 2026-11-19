# TI-Nspire Activity-Based Costing Calculators

5 calculator sheets for traditional costing, time-driven ABC, pool rates, traditional-versus-ABC comparison and cost-to-serve. They are numbered in the order you would usually work through a case. Each sheet opens as a simple form on a TI-Nspire CX or CX CAS: type the numbers you
have and the answer appears underneath.

> **Version 1.0.0.** Every sheet has been tested on a computer but this version has not yet
> been tried on a calculator. Check one sheet first (step 6 below).

## Contents

1. [Put the sheets on your calculator](#1-put-the-sheets-on-your-calculator)
2. [Use a sheet](#2-use-a-sheet)
3. [The sheets](#3-the-sheets)
4. [Notes on particular sheets](#4-notes-on-particular-sheets)
5. [If something goes wrong](#5-if-something-goes-wrong)
6. [Known limitations](#6-known-limitations)
7. [For developers](#7-for-developers)
8. [Licence, security and support](#8-licence-security-and-support)

## 1. Put the sheets on your calculator

You need a TI-Nspire CX or CX CAS, its USB cable, and **TI-Nspire Computer Link Software** (free from
education.ti.com) on a Windows or Mac computer.

1. **Download.** Open this repository's **Releases** page, download `ti-nspire-accounting-calculators-1.0.0.zip` and unzip it.
   You get a folder called `accounting` and a `README.txt`.
2. **Connect.** Turn the calculator on and plug it into the computer.
3. **Open Computer Link.** In the Select Handheld window, click your calculator, then **Select**.
4. **Copy.** The top pane shows your computer and the bottom pane shows the calculator. Drag the
   `accounting` folder from the top pane to the bottom pane.
5. **Leave `README.txt` behind.** Computer Link only copies calculator files and cancels the whole
   copy if you include anything else.
6. **Check.** On the calculator press [home], open **My Documents**, then `accounting`, then
   `03_ABC_Pool_Rate`. Press 6000 [enter] 300 [enter] 100 [enter] 150 (words in square brackets are keys; the rest
   are numbers to type). You should see **Rate /driver** 20, **A allocated** 2000, **B allocated** 3000, **Unused cap cost** 1000.

The `README.txt` in the zip has the same steps in more detail, with fixes for common problems.
No release yet? Build the zip yourself (section 7).

## 2. Use a sheet

| Sheets | Move | Type | Reset |
|---|---|---|---|
| All sheets | [up] [down], or [enter] / [tab] for the next field | number keys, `.` and `(-)`; [backspace] deletes | [esc] empties the field you are on |

- Amounts are in whatever currency you type. Margins are shown as percentages.
- **Grey** values are defaults used while a field is empty. **Orange** text is a warning
  about your inputs. **Red** means an entry is not a complete number yet; results stay
  hidden until you fix it.
- If the calculator asks to save changes when you close a sheet, either answer is fine.

**Example.** Traditional costing (`01_Traditional_Costing`): overhead 10,000; product A price 50, volume 100, direct cost 20; product B price 80, volume 400, direct cost 30. Press 10000 [enter] 50 [enter] 100 [enter] 20 [enter] 80 [enter] 400 [enter] 30:

| Row | Shows |
|---|---|
| OH rate /unit | 20 |
| A profit | 1000 |
| B profit | 12000 |
| Total profit | 13000 |

## 3. The sheets

| Sheet | What it works out |
|---|---|
| `01_Traditional_Costing` | Spread one overhead pool over volume and see profit by product |
| `02_Time_Driven_ABC` | Cost products by minutes used, including the cost of unused capacity |
| `03_ABC_Pool_Rate` | Turn an activity pool into a driver rate and allocate it |
| `04_Traditional_vs_ABC` | Compare traditional and ABC overhead for one product |
| `05_Cost_to_Serve` | Profit from one customer after the activities it uses |

[docs/SHEET_LIST.md](docs/SHEET_LIST.md) lists every input of every sheet.

## 4. Notes on particular sheets

- **`01_Traditional_Costing`.** A product whose volume is left blank counts as zero. The "Total volume" row shows what the rate was based on.
- **`02_Time_Driven_ABC`.** Leave the capacity blank and the sheet assumes it is fully used. It shows the figure it assumed, and the unused-capacity cost is then zero.
- **`03_ABC_Pool_Rate`.** Run it once per activity pool. Leaving the driver quantity blank works the same way as the capacity in sheet 02.

## 5. If something goes wrong

| Problem | What to do |
|---|---|
| The calculator is not in the Select Handheld list | Turn it on, push the cable in fully at both ends, click Refresh. Try another USB port. |
| Computer Link says a file is not supported and copies nothing | You included `README.txt`. Drag only the `accounting` folder or `.tns` files. |
| A sheet will not open | Copy that file again. If it still fails, open an issue saying which sheet. |
| A percentage looks 100 times too big or small | Type rates as decimals: `0.08`, not `8`. |
| Nothing appears under the fields | The sheet needs more inputs. A dash means that row cannot be worked out yet. |
| A number looks wrong | Open an issue with the sheet name, what you typed and what it showed. |

## 6. Known limitations

- Not yet tried on a calculator in this version. Check one sheet first (step 6 above).
- Made for the TI-Nspire CX and CX CAS. CX II models have not been tried.

## 7. For developers

### What is in this repository

```
ti-nspire-accounting-calculators/
├── src/
│   ├── accounting/              one .lua file per sheet (5)
│   └── shared/                  code the sheets share
│       └── form_standard.lua
├── scripts/
│   ├── build.py                 builds every sheet into dist/
│   ├── tns_file.py              reads and writes .tns calculator files
│   ├── des_cipher.py            the cipher the .tns format needs
│   └── make_sheet_list.py       rebuilds docs/SHEET_LIST.md
├── tests/                       automated tests
├── docs/
│   ├── LOADING_GUIDE.txt        becomes README.txt in the download
│   ├── SHEET_LIST.md            every sheet and its inputs
│   ├── CHECK_ON_CALCULATOR.md   what to check on a real calculator
│   ├── HOW_IT_WORKS.md          how the build and tests work
│   └── TNS_FILE_FORMAT.md       the calculator file format
├── .github/workflows/           automatic tests and releases
├── CHANGELOG.md  CONTRIBUTING.md  SECURITY.md  THIRD_PARTY_NOTICES.md
└── VERSION  pyproject.toml  requirements-dev.txt
```

### Set up

You need Python 3.10 or later. Nothing else: no compiler and no TI software.

```bash
git clone <GITHUB_REPOSITORY_URL>
cd ti-nspire-accounting-calculators
python -m venv .venv
# Windows: .venv\Scripts\activate     macOS or Linux: source .venv/bin/activate
python -m pip install -r requirements-dev.txt
```

### Build

```bash
python scripts/build.py --zip
```

This writes `dist/accounting/` (the `.tns` files), `dist/README.txt` and `dist/ti-nspire-accounting-calculators-1.0.0.zip`.
Each build checks every sheet compiles as Lua 5.1 (the calculator's version) and that every file
holds exactly its source.

| Option | What it does |
|---|---|
| `--zip` | also make the zip |
| `--check` | change nothing; fail if `dist/` does not match `src/` |
| `--out FOLDER` | write somewhere other than `dist/` |

### Test

```bash
python -m pytest
ruff check .
python scripts/make_sheet_list.py --check
```

The tests check every result against an independent calculation, press random keys on every
sheet, and type the worked checks from the loading guide into the sheets.
[docs/HOW_IT_WORKS.md](docs/HOW_IT_WORKS.md) explains more.

### One file at a time

```bash
python scripts/tns_file.py pack   my_sheet.lua my_sheet.tns
python scripts/tns_file.py unpack my_sheet.tns my_sheet.lua
```

`unpack` cannot read a file the calculator has saved over; rebuild it from `src/` instead.

## 8. Licence, security and support

- **Licence:** none chosen yet, so all rights are reserved. See
  [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for code this project draws on.
- **Security:** the sheets cannot read files or use a network, and the repository holds no
  passwords or personal data. See [SECURITY.md](SECURITY.md).
- **Assessments:** check the rules before taking stored programs into any test or exam.
- **Contributing:** see [CONTRIBUTING.md](CONTRIBUTING.md).
- **Support:** open an issue on this repository.
