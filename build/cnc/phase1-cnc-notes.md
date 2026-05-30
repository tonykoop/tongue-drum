# Phase-1 CNC Readiness Notes

Status: gate definitions only.

These notes define what must be proven before prototype cutting. They are not a
CAM plan, toolpath, DXF coordinate set, or machine setup sheet.

- Verify fixture datum, stock orientation, clamp keepouts, and repeatable
  zeroing before any cut.
- Cut and measure same-material kerf coupons before slot geometry is promoted.
- Record cutter, bit, feed/speed source, cleanup method, and edge condition in
  the CNC gate table.
- Run a first-article or sacrificial pass before cutting a real top or body
  panel.
- Keep every CNC row at `pending_measurement` until shop evidence is committed.
