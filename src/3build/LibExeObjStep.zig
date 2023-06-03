const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// LibExeObjStep
// The std.build.LibExeObjStep type contains information required to build a library, executable, object, or test.

// Let’s make use of our Builder and create a LibExeObjStep using Builder.addExecutable, which takes in a name and a path to the root of the source.

const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const exe = b.addExecutable("program", "src/main.zig");
    exe.install();
}
