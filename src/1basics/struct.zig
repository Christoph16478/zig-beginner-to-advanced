const expect = @import("std").testing.expect;

// Structs
// -------
// Structs are Zig’s most common kind of composite data type, allowing
// you to define types that can store a fixed set of named fields.
// Zig gives no guarantees about the in-memory order of fields in a
// struct, or its size. Like arrays, structs are also neatly
// constructed with T{} syntax. Here is an example of declaring and filling a struct.
const Vec3 = struct { x: f32, y: f32, z: f32 };
test "struct usage" {
    const my_vector = Vec3{
        .x = 0,
        .y = 100,
        .z = 50,
    };
    _ = my_vector;
}

// All fields must be given a value.
// test "missing struct field" {
//     const my_vector = Vec3{
//         .x = 0,
//         .z = 50,
//     };
//     _ = my_vector;
// }

// error: missing field: 'y'
//     const my_vector = Vec3{
//                         ^
// Fields may be given defaults:
const Vec4 = struct { x: f32, y: f32, z: f32 = 0, w: f32 = undefined };
test "struct defaults" {
    const my_vector = Vec4{
        .x = 25,
        .y = -50,
    };
    _ = my_vector;
}

// Like enums, structs may also contain functions and declarations.

// Structs have the unique property that when given a pointer to a
// struct, one level of dereferencing is done automatically when
// accessing fields. Notice how in this example, self.x and self.y are accessed in the swap function without needing to dereference the self pointer.
const Stuff = struct {
    x: i32,
    y: i32,
    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

test "automatic dereference" {
    var thing = Stuff{ .x = 10, .y = 20 };
    thing.swap();
    try expect(thing.x == 20);
    try expect(thing.y == 10);
}

// Anonymous Structs
// -----------------
// The struct type may be omitted from a struct literal. These
// literals may coerce to other struct types.
test "anonymous struct literal" {
    const Point = struct { x: i32, y: i32 };

    var pt: Point = .{
        .x = 13,
        .y = 67,
    };
    try expect(pt.x == 13);
    try expect(pt.y == 67);
}

// Anonymous structs may be completely anonymous i.e. without
// being coerced to another struct type.
test "fully anonymous struct" {
    try dump(.{
        .int = @as(u32, 1234),
        .float = @as(f64, 12.34),
        .b = true,
        .s = "hi",
    });
}

fn dump(args: anytype) !void {
    try expect(args.int == 1234);
    try expect(args.float == 12.34);
    try expect(args.b);
    try expect(args.s[0] == 'h');
    try expect(args.s[1] == 'i');
}

// Anonymous structs without field names may be created, and are
// referred to as tuples. These have many of the properties that
// arrays do; tuples can be iterated over, indexed, can be used with
// the ++ and ** operators, and have a len field. Internally, these
// have numbered field names starting at "0", which may be accessed
// with the special syntax @"0" which acts as an escape for the syntax
// - things inside @"" are always recognised as identifiers.

// An inline loop must be used to iterate over the tuple here, as the
// type of each tuple field may differ.
test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;
    try expect(values[0] == 1234);
    try expect(values[4] == false);
    inline for (values) |v, i| {
        if (i != 2) continue;
        try expect(v);
    }
    try expect(values.len == 6);
    try expect(values.@"3"[0] == 'h');
}
