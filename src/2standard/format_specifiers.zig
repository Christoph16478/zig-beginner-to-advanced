const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;

// Formatting specifiers
// ----------------------
// std.fmt provides options for formatting various data types.

// std.fmt.fmtSliceHexLower and std.fmt.fmtSliceHexUpper provide
// hex formatting for strings as well as {x} and {X} for ints.

const bufPrint = std.fmt.bufPrint;

test "hex" {
    var b: [8]u8 = undefined;

    _ = try bufPrint(&b, "{X}", .{4294967294});
    try expect(mem.eql(u8, &b, "FFFFFFFE"));

    _ = try bufPrint(&b, "{x}", .{4294967294});
    try expect(mem.eql(u8, &b, "fffffffe"));

    _ = try bufPrint(&b, "{}", .{std.fmt.fmtSliceHexLower("Zig!")});
    try expect(mem.eql(u8, &b, "5a696721"));
}

// {d} performs decimal formatting for numeric types.
test "decimal float" {
    var b: [4]u8 = undefined;
    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{d}", .{16.5}),
        "16.5",
    ));
}

// {c} formats a byte into an ascii character.
test "ascii fmt" {
    var b: [1]u8 = undefined;
    _ = try bufPrint(&b, "{c}", .{66});
    try expect(mem.eql(u8, &b, "B"));
}

// std.fmt.fmtIntSizeDec and std.fmt.fmtIntSizeBin output memory sizes in metric (1000) and power-of-two (1024) based notation.
test "B Bi" {
    var b: [32]u8 = undefined;

    try expect(mem.eql(u8, try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeDec(1)}), "1B"));
    try expect(mem.eql(u8, try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeBin(1)}), "1B"));

    try expect(mem.eql(u8, try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeDec(1024)}), "1.024kB"));
    try expect(mem.eql(u8, try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeBin(1024)}), "1KiB"));

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeDec(1024 * 1024 * 1024)}),
        "1.073741824GB",
    ));
    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{}", .{std.fmt.fmtIntSizeBin(1024 * 1024 * 1024)}),
        "1GiB",
    ));
}

// {b} and {o} output integers in binary and octal format.
test "binary, octal fmt" {
    var b: [8]u8 = undefined;

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{b}", .{254}),
        "11111110",
    ));

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{o}", .{254}),
        "376",
    ));
}

// {*} performs pointer formatting, printing the address rather than the value.
test "pointer fmt" {
    var b: [16]u8 = undefined;
    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{*}", .{@intToPtr(*u8, 0xDEADBEEF)}),
        "u8@deadbeef",
    ));
}

// {e} outputs floats in scientific notation.
test "scientific" {
    var b: [16]u8 = undefined;

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{e}", .{3.14159}),
        "3.14159e+00",
    ));
}

// {s} outputs strings.
test "string fmt" {
    var b: [6]u8 = undefined;
    const hello: [*:0]const u8 = "hello!";

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{s}", .{hello}),
        "hello!",
    ));
}

// This list is non-exhaustive.

// Advanced Formatting
// -------------------
// So far we have only covered formatting specifiers. Format strings actually follow this format, where between each pair of square brackets is a parameter you have to replace with something.

// {[position][specifier]:[fill][alignment][width].[precision]}

// Name	Meaning
// Position	The index of the argument that should be inserted
// Specifier	A type-dependent formatting option
// Fill	A single character used for padding
// Alignment	One of three characters ‘<’, ‘^’ or ‘>’; these are for left, middle and right alignment
// Width	The total width of the field (characters)
// Precision	How many decimals a formatted number should have
// Position usage.
test "position" {
    var b: [3]u8 = undefined;
    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{0s}{0s}{1s}", .{ "a", "b" }),
        "aab",
    ));
}

// Fill, alignment and width being used.
test "fill, alignment, width" {
    var b: [6]u8 = undefined;

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{s: <5}", .{"hi!"}),
        "hi!  ",
    ));

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{s:_^6}", .{"hi!"}),
        "_hi!__",
    ));

    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{s:!>4}", .{"hi!"}),
        "!hi!",
    ));
}

// Using a specifier with precision.
test "precision" {
    var b: [4]u8 = undefined;
    try expect(mem.eql(
        u8,
        try bufPrint(&b, "{d:.2}", .{3.14159}),
        "3.14",
    ));
}
