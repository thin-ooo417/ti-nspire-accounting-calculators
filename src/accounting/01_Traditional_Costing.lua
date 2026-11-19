local TITLE = "1. Traditional (volume) costing"
local FORMULA = "Rate = OH / total volume  (same rate every unit)"

local fields = {
  {k="oh", lab="OH  overhead pool", v=""},
  {k="pa", lab="PA  price/unit A", v=""},
  {k="qa", lab="QA  volume A", v=""},
  {k="ca", lab="CA  direct cost/unit A", v=""},
  {k="pb", lab="PB  price/unit B", v=""},
  {k="qb", lab="QB  volume B", v=""},
  {k="cb", lab="CB  direct cost/unit B", v=""},
}

local function calc(V)
  local out = {}
  local q = 0
  if V.qa then q = q + V.qa end
  if V.qb then q = q + V.qb end

  local rate
  if V.oh and q ~= 0 then rate = V.oh / q end

  local ua, ub, ta, tb, tot
  if rate and V.pa and V.ca then ua = V.pa - V.ca - rate end
  if rate and V.pb and V.cb then ub = V.pb - V.cb - rate end
  if ua and V.qa then ta = ua * V.qa end
  if ub and V.qb then tb = ub * V.qb end
  if ta and tb then tot = ta + tb end

  local n = 0
  local function row(a, b) n = n + 1 out[n] = {a, b} end

  if q ~= 0 then row("Total volume", fmt(q)) else row("Total volume", "-") end
  row("OH rate /unit", fmt(rate))
  row("A profit/unit", fmt(ua))
  row("A profit", fmt(ta))
  row("B profit/unit", fmt(ub))
  row("B profit", fmt(tb))
  row("Total profit", fmt(tot))

  if (ua and ua < 0) or (ub and ub < 0) then
    row("!", "Loss shown: re-test the driver with ABC.")
  end
  return out
end


--@include shared/form_standard.lua
