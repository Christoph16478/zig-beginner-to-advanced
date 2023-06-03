const expect = @import("std").testing.expect;

// unreachable is an assertion to the compiler that this statement will not be reached. It can be used to tell the compiler that a branch is impossible, which the optimiser can then take advantage of. Reaching an unreachable is detectable illegal behaviour.

// As it is of the type noreturn, it is compatible with all other types. Here it coerces to u32.

test "unreachable" {
    const x: i32 = 1;
    const y: u32 = if (x == 2) 5 else unreachable;
    _ = y;
}
// test "unreachable"...reached unreachable code
// .\tests.zig:211:39: 0x7ff7e29b2049 in test "unreachable" (test.obj)
//     const y: u32 = if (x == 2) 5 else unreachable;
//                                      ^
// Here is an unreachable being used in a switch.
fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}
