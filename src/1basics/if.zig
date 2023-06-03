const expect = @import("std").testing.expect;

// Run zig test if.zig

// Zig’s basic if statement is simple in that it only accepts a bool
// value (of values true or false). There is no concept of truthy or
// falsy values.

// Here we will introduce testing. Save the below code and compile + run
// it with zig test file-name.zig. We will be using the expect function
// from the standard library, which will cause the test to fail if its
// given the value false. When a test fails, the error and stack trace
// will be shown.
test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}
