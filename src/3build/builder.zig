const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Builder
// Zig’s std.build.Builder type contains the information used by the build runner. This includes information such as:

// the build target
// the release mode
// locations of libraries
// the install path
// build steps
