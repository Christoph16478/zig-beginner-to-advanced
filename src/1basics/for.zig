test "for" {
    const expect = @import("std").testing.expect;
    _ = expect;

    // Run zig test for.zig

    // character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b', 'c' };

    // For loops are used to iterate over arrays (and other types, to be
    // discussed later). For loops follow this syntax. Like while, for
    // loops can use break and continue. Here we’ve had to assign values
    // to _, as Zig does not allow us to have unused values.
    for (string) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}
