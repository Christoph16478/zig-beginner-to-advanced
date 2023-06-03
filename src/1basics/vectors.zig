const expect = @import("std").testing.expect;

// Vectors
// -------
// Zig provides vector types for SIMD. These are not to be
// conflated with vectors in a mathematical sense, or vectors like
// C++’s std::vector (for this, see “Arraylist” in chapter 2). Vectors
// may be created using the @Type built-in we used earlier, and
// std.meta.Vector provides a shorthand for this.

// Vectors can only have child types of booleans, integers, floats
// and pointers.

// Operations between vectors with the same child type and length can
// take place. These operations are performed on each of the values in
// the vector.std.meta.eql is used here to check for equality between
// two vectors (also useful for other types like structs).
const meta = @import("std").meta;
const Vector = meta.Vector;

test "vector add" {
    const x: Vector(4, f32) = .{ 1, -10, 20, -1 };
    const y: Vector(4, f32) = .{ 2, 10, 0, 1 };
    const z = x + y;
    try expect(meta.eql(z, Vector(4, f32){ 3, 0, 20, 0 }));
}

// Vectors are indexable.
test "vector indexing" {
    const x: Vector(4, u8) = .{ 255, 0, 255, 0 };
    try expect(x[0] == 255);
}

// The built-in function @splat may be used to construct a vector
// where all of the values are the same. Here we use it to multiply
// a vector by a scalar.
test "vector * scalar" {
    const x: Vector(3, f32) = .{ 12.5, 37.5, 2.5 };
    const y = x * @splat(3, @as(f32, 2));
    try expect(meta.eql(y, Vector(3, f32){ 25, 75, 5 }));
}

// Vectors do not have a len field like arrays, but may still be
// looped over. Here, std.mem.len is used as a shortcut for
// @typeInfo(@TypeOf(x)).Vector.len.
const len = @import("std").mem.len;

test "vector looping" {
    const x = Vector(4, u8){ 255, 0, 255, 0 };
    var sum = blk: {
        var tmp: u10 = 0;
        var i: u8 = 0;
        while (i < len(x)) : (i += 1) tmp += x[i];
        break :blk tmp;
    };
    try expect(sum == 510);
}

// Vectors coerce to their respective arrays.
// const arr: [4]f32 = @Vector(4, f32){ 1, 2, 3, 4 };
// It is worth noting that using explicit vectors may result in
// slower software if you do not make the right decisions - the
// compiler’s auto-vectorisation is fairly smart as-is.
