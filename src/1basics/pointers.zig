const expect = @import("std").testing.expect;

// Normal pointers in Zig aren’t allowed to have 0 or null as a value.
// They follow the syntax *T, where T is the child type.

// Referencing is done with &variable, and dereferencing is done with
// variable.*.
fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

// Trying to set a *T to the value 0 is detectable illegal behaviour.
test "naughty pointer" {
    var x: u16 = 0;
    var y: *u8 = @intToPtr(*u8, x);
    _ = y;
}
// test "naughty pointer"...cast causes pointer to be null
// .\tests.zig:241:18: 0x7ff69ebb22bd in test "naughty pointer" (test.obj)
//     var y: *u8 = @intToPtr(*u8, x);
//                  ^
// Zig also has const pointers, which cannot be used to modify
// the referenced data. Referencing a const variable will yield a
// const pointer.
test "const pointers" {
    //    const x: u8 = 1;
    //    var y = &x;
    //    y.* += 1;
}
// error: cannot assign to constant
//     y.* += 1;
//         ^
// A *T coerces to a *const T.

// Pointer sized integers
// usize and isize are given as unsigned and signed integers which
// are the same size as pointers.
test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}

// Many-Item Pointers
// ------------------
// Sometimes you may have a pointer to an unknown amount of elements.
// [*]T is the solution for this, which works like *T but also supports
// indexing syntax, pointer arithmetic, and slicing. Unlike *T, it
// cannot point to a type which does not have a known size. *T
// coerces to [*]T.

// These many pointers may point to any amount of elements, including
// 0 and 1.
