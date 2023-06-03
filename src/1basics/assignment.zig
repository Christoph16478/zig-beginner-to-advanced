const std = @import("std");

// const indicates that identifier is a constant that stores an
// immutable value.

// var indicates that identifier is a variable that
// stores a mutable value.

// : type is a type annotation for identifier, and may
// be omitted if the data type of value can be inferred.
pub fn main() void {
    const constant: i32 = 5;
    _ = constant; // signed 32-bit constant
    var variable: u32 = 5000;
    _ = variable; // unsigned 32-bit variable

    // @as performs an explicit type coercion
    const inferred_constant = @as(i32, 5);
    _ = inferred_constant;
    var inferred_variable = @as(u32, 5000);
    _ = inferred_variable;

    // constants and variables must have a value, type
    // annotation must be provided
    const a: i32 = undefined;
    _ = a;
    var b: u32 = undefined;
    _ = b;
}
