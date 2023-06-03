const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Extern Structs
// Normal structs in Zig do not have a defined layout; extern structs are required for when you want the layout of your struct to match the layout of your C ABI.

// Let’s create an extern struct. This test should be run with x86_64 with a gnu ABI, which can be done with -target x86_64-native-gnu.

const expect = @import("std").testing.expect;

const Data = extern struct { a: i32, b: u8, c: f32, d: bool, e: bool };

test "hmm" {
    const x = Data{
        .a = 10005,
        .b = 42,
        .c = -10.5,
        .d = false,
        .e = true,
    };
    const z = @ptrCast([*]const u8, &x);

    try expect(@ptrCast(*const i32, z).* == 10005);
    try expect(@ptrCast(*const u8, z + 4).* == 42);
    try expect(@ptrCast(*const f32, z + 8).* == -10.5);
    try expect(@ptrCast(*const bool, z + 12).* == false);
    try expect(@ptrCast(*const bool, z + 13).* == true);
}
// This is what the memory inside our x value looks like.

// Field	a	a	a	a	b				c	c	c	c	d	e
// Bytes	15	27	00	00	2A	00	00	00	00	00	28	C1	00	01	00	00
// Note how there are gaps in the middle and at the end - this is called “padding”. The data in this padding is undefined memory, and won’t always be zero.

// As our x value is that of an extern struct, we could safely pass it into a C function expecting a Data, providing the C function was also compiled with the same gnu ABI and CPU arch.
