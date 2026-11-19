# Changelog

All notable changes. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and versions follow [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-11-19

First public release.

### Fixed since the earlier, unpublished version

- **Large results keep their digits.** Values were always shown to 6 significant figures, so 123,456.78 appeared as `123457`. From 10,000 upward values now show two decimal places. Smaller values look exactly as before.

### Added

- One source file per sheet, with shared code in `src/shared/`.
- A build that needs only Python (`scripts/build.py`).
- Automated tests that run every sheet under Lua 5.1 and check its results.
- A step-by-step guide to loading the sheets with TI-Nspire Computer Link Software, shipped as
  `README.txt` in the download.
- Automatic tests, releases and a weekly dependency check on GitHub.
