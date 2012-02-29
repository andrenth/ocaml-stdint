describe "An unsigned integer" do
  it "should not modify an int when converted" do
    forall int x . (to_int (of_int x)) should = x
  done;

  it "should not modify an int32 when converted" do
    forall int32 x . (to_int32 (of_int32 x)) should = x
  done;

  it "should not modify strings when converted" do
    (of_string (to_string max_int)) should = max_int;
    forall int32 x . (to_string (of_int32 x)) should = (Int32.to_string x)
  done;

  it "should perform logical and correctly" do
    forall int x . forall int y .
      (to_int (logand (of_int x) (of_int y))) should = (x land y)
  done;

  it "should perform logical or correctly" do
    forall int x . forall int y .
      (to_int (logor (of_int x) (of_int y))) should = (x lor y)
  done;

  it "should perform logical xor correctly" do
    forall int x . forall int y .
      (to_int (logxor (of_int x) (of_int y))) should = (x lxor y)
  done;

  it "should perform logical not correctly" do
    forall int32 x . (to_int32 (lognot (of_int32 x))) should = (Int32.lognot x)
  done;

  it "should perform left-shifts correctly" do
    forall int32 x . forall (int_in_range 0 31) y .
      (to_int32 (shift_left (of_int32 x) y)) should = (Int32.shift_left x y)
  done;

  it "shoult perform right-shifts correctly" do
    forall int x . forall (int_in_range 0 31) y .
      (to_int (shift_right (of_int x) y)) should = (x asr y)
  done;

  it "should perform float conversions correctly" do
    forall float x .
      (to_float (of_float x)) should = (float_of_int (int_of_float x))
  done;
done
