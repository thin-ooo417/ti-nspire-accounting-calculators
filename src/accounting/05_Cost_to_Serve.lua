local TITLE = "5. Cost-to-serve (customer profit)"
local FORMULA = "Profit = Sales - Direct - sum(qty x rate) - Other"

local fields = {
  {k="s",  lab="S   sales", v=""},
  {k="d",  lab="D   direct costs", v=""},
  {k="q1", lab="q1  activity 1 qty", v=""},
  {k="r1", lab="r1  activity 1 rate", v=""},
  {k="q2", lab="q2  activity 2 qty", v=""},
  {k="r2", lab="r2  activity 2 rate", v=""},
  {k="q3", lab="q3  activity 3 qty", v=""},
  {k="r3", lab="r3  activity 3 rate", v=""},
  {k="ot", lab="Oth other activity cost", v="", d=0},
}

local function calc(V)
  local out = {}
  local n = 0
  local function row(a, b) n = n + 1 out[n] = {a, b} end

  local act = 0
  if V.q1 and V.r1 then act = act + V.q1 * V.r1 end
  if V.q2 and V.r2 then act = act + V.q2 * V.r2 end
  if V.q3 and V.r3 then act = act + V.q3 * V.r3 end
  if V.ot then act = act + V.ot end

  local tc, pr, mg, cs
  if V.d then tc = V.d + act end
  if V.s and tc then pr = V.s - tc end
  if pr and V.s and V.s ~= 0 then mg = pr / V.s end
  if V.s and V.s ~= 0 then cs = act / V.s end

  row("Activity cost", fmt(act))
  row("Total cost", fmt(tc))
  row("Profit", fmt(pr))
  row("Margin on sales", pct(mg))
  row("Cost-to-serve", pct(cs))

  if pr and pr < 0 then
    row("!", "Loss-making customer: fix or reprice.")
  end
  return out
end


--@include shared/form_standard.lua
