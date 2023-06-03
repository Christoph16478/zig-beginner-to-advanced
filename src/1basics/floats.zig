const expect = @import("std").testing.expect;

// Floats
// ------
// Zig’s floats are strictly IEEE compliant unless @setFloatMode(.Optimized)
// is used, which is equivalent to GCC’s -ffast-math. Floats coerce to
// larger float types.

test "float widening" {
    const a: f16 = 0;
    const b: f32 = a;
    const c: f128 = b;
    try expect(c == @as(f128, a));
}

// Floats support multiple kinds of literal.
const floating_point: f64 = 123.0E+77;
const another_float: f64 = 123.0;
const yet_another: f64 = 123.0e+77;
const hex_floating_point: f64 = 0x103.70p-5;
const another_hex_float: f64 = 0x103.70;
const yet_another_hex_float: f64 = 0x103.70P-5;

// Underscores may also be placed between digits.
const lightspeed: f64 = 299_792_458.000_000;
const nanosecond: f64 = 0.000_000_001;
const more_hex: f64 = 0x1234_5678.9ABC_CDEFp-10;

// Integers and floats may be converted using the built-in functions
// @intToFloat and @floatToInt. @intToFloat is always safe, whereas @floatToInt is detectable illegal behaviour if the float value cannot fit in the integer destination type.
test "int-float conversion" {
    const a: i32 = 0;
    const b = @intToFloat(f32, a);
    const c = @floatToInt(i32, b);
    try expect(c == a);
}
