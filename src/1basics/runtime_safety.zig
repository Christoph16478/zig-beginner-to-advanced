const expect = @import("std").testing.expect;

// Zig provides a level of safety, where problems may be found during execution. Safety can be left on, or turned off. Zig has many cases of so-called detectable illegal behaviour, meaning that illegal behaviour will be caught (causing a panic) with safety on, but will result in undefined behaviour with safety off. Users are strongly recommended to develop and test their software with safety on, despite its speed penalties.

// For example, runtime safety protects you from out of bounds indices.

test "out of bounds" {
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
}
// test "out of bounds"...index out of bounds
// .\tests.zig:43:14: 0x7ff698cc1b82 in test "out of bounds" (test.obj)
//     const b = a[index];
//              ^
// The user may choose to disable runtime safety for the current block by using the built-in function @setRuntimeSafety.

test "out of bounds, no safety" {
    @setRuntimeSafety(false);
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
}

// Safety is off for some build modes (to be discussed later).
