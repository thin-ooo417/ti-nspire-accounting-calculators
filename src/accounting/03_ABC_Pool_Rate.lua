local TITLE = "3. ABC pool rate & allocation"
local FORMULA = "Rate = pool cost / driver qty  (run once per pool)"

local fields = {
  {k="pc", lab="P   pool cost", v=""},
  {k="dt", lab="D   driver qty available", v=""},
  {k="da", lab="dA  driver used by A", v=""},
  {k="db", lab="dB  driver used by B", v=""},
}

local function calc(V)
  local out = {}
  local n = 0
  local function row(a, b) n = n + 1 out[n] = {a, b} end

  local used = 0
  if V.da then used = used + V.da end
  if V.db then used = used + V.db end

  -- driver qty blank => assume the whole driver capacity is consumed
  local avail = V.dt
  if avail == nil then avail = used end

  local rate
  if V.pc and avail ~= 0 then rate = V.pc / avail end

  local aa, ab, tot, uq, uc
  if rate and V.da then aa = rate * V.da end
  if rate and V.db then ab = rate * V.db end
  if aa and ab then tot = aa + ab end
  if avail then uq = avail - used end
  if rate and uq then uc = rate * uq end

  row("Driver avail", fmt(avail))
  row("Rate /driver", fmt(rate))
  row("A allocated", fmt(aa))
  row("B allocated", fmt(ab))
  row("Allocated total", fmt(tot))
  row("Unused driver", fmt(uq))
  row("Unused cap cost", fmt(uc))

  if avail and used > avail then
    row("!", "Driver used exceeds qty available.")
  end
  return out
end


--@include shared/form_standard.lua
