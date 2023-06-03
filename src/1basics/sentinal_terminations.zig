const expect = @import("std").testing.expect;

// Sentinel Termination
// --------------------
// Arrays, slices and many pointers may be terminated by a value of
// their child type. This is known as sentinel termination. These follow
// the syntax [N:t]T, [:t]T, and [*:t]T, where t is a value of the
// child type T.

// An example of a sentinel terminated array. The built-in @bitCast is
// used to perform an unsafe bitwise type conversion. This shows us
// that the last element of the array is followed by a 0 byte.
test "sentinel termination" {
    const terminated = [3:0]u8{ 3, 2, 1 };
    try expect(terminated.len == 3);
    // try expect(@bitCast([4]u8, terminated)[3] == 0);
}
// The types of string literals is *const [N:0]u8, where N is the
// length of the string. This allows string literals to coerce to
// sentinel terminated slices, and sentinel terminated many pointers.
// Note: string literals are UTF-8 encoded.
test "string literal" {
    try expect(@TypeOf("hello") == *const [5:0]u8);
}

// [*:0]u8 and [*:0]const u8 perfectly model C’s strings.
test "C string" {
    const c_string: [*:0]const u8 = "hello";
    var array: [5]u8 = undefined;

    var i: usize = 0;
    while (c_string[i] != 0) : (i += 1) {
        array[i] = c_string[i];
    }
}

// Sentinel terminated types coerce to their
// non-sentinel-terminated counterparts.
test "coercion" {
    var a: [*:0]u8 = undefined;
    const b: [*]u8 = a;
    _ = b;

    var c: [5:0]u8 = undefined;
    const d: [5]u8 = c;
    _ = d;

    var e: [:10]f32 = undefined;
    const f = e;
    _ = f;
}

// Sentinel terminated slicing is provided which can be used to
// create a sentinel terminated slice with the syntax x[n..m:t],
// where t is the terminator value. Doing this is an assertion from
// the programmer that the memory is terminated where it should be -
// getting this wrong is detectable illegal behaviour.
test "sentinel terminated slicing" {
    var x = [_:0]u8{255} ** 3;
    const y = x[0..3 :0];
    _ = y;
}
