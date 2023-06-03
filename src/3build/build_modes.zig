const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;
// Build Modes
// Zig provides four build modes, with debug being the default as it produces the shortest compile times.

// Runtime Safety	Optimizations
// Debug	Yes	No
// ReleaseSafe	Yes	Yes, Speed
// ReleaseSmall	No	Yes, Size
// ReleaseFast	No	Yes, Speed
// These may be enabled in zig run and zig test with the arguments -O ReleaseSafe, -O ReleaseSmall and -O ReleaseFast.

// Users are recommended to develop their software with runtime safety enabled, despite its small speed disadvantage.
