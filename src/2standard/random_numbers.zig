const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Random Numbers
// Here we create a new prng using a 64 bit random seed. a, b, c, and d are given random values via this prng. The expressions giving c and d values are equivalent. DefaultPrng is Xoroshiro128; there are other prngs available in std.rand.

test "random numbers" {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    //suppress unused local constant compile error
    if (false) _ = .{ a, b, c, d };
}
// Cryptographically secure random is also available.

test "crypto random numbers" {
    const rand = std.crypto.random;

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    //suppress unused local constant compile error
    if (false) _ = .{ a, b, c, d };
}
