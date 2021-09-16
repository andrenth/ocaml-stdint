# Unreleased

## Fixes:

* Fix undefined reference to `get_uint128` (#62)

# 0.7.0 (28/10/2020)

## Fixes:

* Correct conversion from uint24 to other ints (#39, @rixed)
* Fix conversion from all ints to uint24 and int24 (#41, @rixed)
* Fix int24 failing to recover from casts (#43, @rixed)
* Fix sign extensions (#49, @rixed)
* `Long_val` returns `intnat`, previously `long` was used (#53, @dra27)
* Reduce size of marshalled custom values on 4.08+ (#54, @dra27)
* Store 128-bit ints as structs to prevent unaligned access (#55, @dra27)

## New features:

* Add `of_substring` (#49, @darlentar)

# 0.6.0 (12/3/2019)

* Speed up generic comparison of int backed types (#34, @rixed)
* Port to dune (#35, @tuncer)
* Move to stdlib from pervasives (#36, @tuncer)
