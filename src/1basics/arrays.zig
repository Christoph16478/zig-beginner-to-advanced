const std = @import("std");

pub fn main() void {
    // Arrays are denoted by [N]T, where N is the number of elements
    // in the array and T is the type of those elements (i.e., the
    // array’s child type). For array literals, N may be replaced by _
    // to infer the size of the array.
    const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    _ = a;
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };
    _ = b;

    // get size of an array
    const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    const length = array.len;
    _ = length; // 5 - get size of an array
}
