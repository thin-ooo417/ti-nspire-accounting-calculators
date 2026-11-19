"""Accounting (activity-based costing) sheets."""

from __future__ import annotations

import pytest

from conftest import names
from form_drivers import V2

CASES = [
    ("01_Traditional_Costing",
     {"oh": "10000", "pa": "50", "qa": "100", "ca": "20", "pb": "80", "qb": "400", "cb": "30"},
     {"Total volume": 500.0, "OH rate /unit": 20.0, "A profit/unit": 10.0, "A profit": 1000.0,
      "B profit/unit": 30.0, "B profit": 12000.0, "Total profit": 13000.0}),
    ("02_Time_Driven_ABC",
     {"cp": "9000", "cm": "500", "nr": "2", "ta": "2", "qa": "100", "tb": "4", "qb": "150"},
     {"Minutes used": 800.0, "Rate /min": 9.0, "A OH/unit": 18.0, "A OH total": 1800.0,
      "B OH/unit": 36.0, "B OH total": 5400.0, "Unused cap cost": 1800.0}),
    # capacity left blank: the sheet assumes no idle time and says which capacity it used
    ("02_Time_Driven_ABC",
     {"cp": "9000", "ta": "2", "qa": "100", "tb": "4", "qb": "150"},
     {"Capacity min": 800.0, "Rate /min": 11.25, "A OH total": 2250.0, "B OH total": 6750.0, "Unused cap cost": 0.0}),
    ("03_ABC_Pool_Rate",
     {"pc": "6000", "dt": "300", "da": "100", "db": "150"},
     {"Driver avail": 300.0, "Rate /driver": 20.0, "A allocated": 2000.0, "B allocated": 3000.0,
      "Allocated total": 5000.0, "Unused driver": 50.0, "Unused cap cost": 1000.0}),
    ("03_ABC_Pool_Rate",
     {"pc": "6000", "da": "100", "db": "150"},
     {"Driver avail": 250.0, "Rate /driver": 24.0, "A allocated": 2400.0, "B allocated": 3600.0, "Unused driver": 0.0}),
    ("04_Traditional_vs_ABC",
     {"p": "100", "q": "50", "dc": "40", "o1": "30", "o2": "70"},
     {"Gross margin/u": 60.0, "Trad profit/u": 30.0, "Trad profit": 1500.0, "ABC profit/u": -10.0,
      "ABC profit": -500.0, "Cross-subsidy": -2000.0, "ABC B/E price": 110.0, "ABC margin": -0.10}),
    ("05_Cost_to_Serve",
     {"s": "10000", "d": "6000", "q1": "10", "r1": "50", "q2": "5", "r2": "100", "q3": "2", "r3": "25", "ot": "100"},
     {"Activity cost": 1150.0, "Total cost": 7150.0, "Profit": 2850.0, "Margin on sales": 0.285,
      "Cost-to-serve": 0.115}),
]


@pytest.mark.parametrize("sheet,typed,expected", CASES, ids=[f"{c[0]}-{i}" for i, c in enumerate(CASES)])
def test_outputs(sheet, typed, expected):
    V2(sheet).set(typed).expect(expected)


def test_every_accounting_sheet_is_covered():
    assert set(names(folder="accounting")) == {case[0] for case in CASES}


@pytest.mark.parametrize("sheet,typed,message", [
    ("01_Traditional_Costing", {"oh": "10000", "pa": "25", "qa": "100", "ca": "20", "qb": "400"},
     "Loss shown: re-test the driver with ABC."),
    ("02_Time_Driven_ABC", {"cp": "9000", "cm": "500", "ta": "2", "qa": "300"}, "Demand exceeds capacity: rate understated."),
    ("03_ABC_Pool_Rate", {"pc": "6000", "dt": "200", "da": "100", "db": "150"}, "Driver used exceeds qty available."),
    ("04_Traditional_vs_ABC", {"p": "100", "q": "50", "dc": "40", "o1": "30", "o2": "70"},
     "Ranking reverses: traditional view is wrong."),
    ("05_Cost_to_Serve", {"s": "1000", "d": "900", "q1": "10", "r1": "50"}, "Loss-making customer: fix or reprice."),
])
def test_warnings(sheet, typed, message):
    assert message in V2(sheet).set(typed).warnings()
