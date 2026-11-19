local TITLE = "4. Traditional vs ABC (one product)"
local FORMULA = "Cross-subsidy = (OH trad - OH abc) x Q"

local fields = {
  {k="p",  lab="P   price/unit", v=""},
  {k="q",  lab="Q   volume", v=""},
  {k="dc", lab="DC  direct cost/unit", v=""},
  {k="o1", lab="OH1 traditional OH/unit", v=""},
  {k="o2", lab="OH2 ABC OH/unit", v=""},
}

local function calc(V)
  local out = {}
  local n = 0
  local function row(a, b) n = n + 1 out[n] = {a, b} end

  local gm, u1, t1, u2, t2, sub, be, mg
  if V.p and V.dc then gm = V.p - V.dc end
  if gm and V.o1 then u1 = gm - V.o1 end
  if gm and V.o2 then u2 = gm - V.o2 end
  if u1 and V.q then t1 = u1 * V.q end
  if u2 and V.q then t2 = u2 * V.q end
  if V.o1 and V.o2 and V.q then sub = (V.o1 - V.o2) * V.q end
  if V.dc and V.o2 then be = V.dc + V.o2 end
  if u2 and V.p and V.p ~= 0 then mg = u2 / V.p end

  row("Gross margin/u", fmt(gm))
  row("Trad profit/u", fmt(u1))
  row("Trad profit", fmt(t1))
  row("ABC profit/u", fmt(u2))
  row("ABC profit", fmt(t2))
  row("Cross-subsidy", fmt(sub))
  row("ABC B/E price", fmt(be))
  row("ABC margin", pct(mg))

  if u1 and u2 and ((u1 > 0 and u2 < 0) or (u1 < 0 and u2 > 0)) then
    row("!", "Ranking reverses: traditional view is wrong.")
  end
  return out
end


--@include shared/form_standard.lua
