# Unreleased

## Fixes:

* Correct conversion from uint24 to other ints (#39, @rixed)
* Fix conversion from all ints to uint24 and int24 (#41, @rixed)
* Fix int24 failing to recover from casts (#43, @rixed)
* Fix sign extensions (#49, @rixed)
* `Longval` returns `intnat`, previously `long` was used (#53, @dra27)

## New features:

* Add `of_substring` (#49, @darlentar)

# 0.6.0 (12/3/2019)

* Speed up generic comparison of int backed types (#34, @rixed)
* Port to dune (#35, @tuncer)
* Move to stdlib from pervasives (#36, @tuncer)
