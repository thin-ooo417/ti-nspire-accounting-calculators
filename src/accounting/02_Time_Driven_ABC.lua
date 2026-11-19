local TITLE = "2. Time-driven ABC (TDABC)"
local FORMULA = "Rate = pool / capacity min;  OH/unit = rate x t"

local fields = {
  {k="cp", lab="P    cost pool", v=""},
  {k="cm", lab="cap  capacity min per resource", v=""},
  {k="nr", lab="n    resources in parallel", v="", d=1},
  {k="ta", lab="tA   min/unit A", v=""},
  {k="qa", lab="QA   volume A", v=""},
  {k="tb", lab="tB   min/unit B", v=""},
  {k="qb", lab="QB   volume B", v=""},
}

local function calc(V)
  local out = {}
  local n = 0
  local function row(a, b) n = n + 1 out[n] = {a, b} end

  local mA, mB
  if V.ta and V.qa then mA = V.ta * V.qa end
  if V.tb and V.qb then mB = V.tb * V.qb end

  local used = 0
  if mA then used = used + mA end
  if mB then used = used + mB end

  -- capacity blank => assume no idle time (whole capacity is consumed)
  local cap, derived
  if V.cm and V.nr then cap = V.cm * V.nr end
  if cap == nil then cap = used derived = true end

  local rate
  if V.cp and cap ~= 0 then rate = V.cp / cap end

  local oa, ob, ka, kb, unused
  if rate and V.ta then oa = rate * V.ta end
  if rate and V.tb then ob = rate * V.tb end
  if oa and V.qa then ka = oa * V.qa end
  if ob and V.qb then kb = ob * V.qb end
  if rate and cap then
    local a = 0
    if ka then a = a + ka end
    if kb then a = a + kb end
    if V.cp then unused = V.cp - a end
  end

  if derived then row("Capacity min", fmt(cap)) end
  if used ~= 0 then row("Minutes used", fmt(used)) else row("Minutes used", "-") end
  row("Rate /min", fmt(rate))
  row("A OH/unit", fmt(oa))
  row("A OH total", fmt(ka))
  row("B OH/unit", fmt(ob))
  row("B OH total", fmt(kb))
  row("Unused cap cost", fmt(unused))

  if cap and used > cap then
    row("!", "Demand exceeds capacity: rate understated.")
  end
  return out
end


--@include shared/form_standard.lua
