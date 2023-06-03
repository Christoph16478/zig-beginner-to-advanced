const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Build steps
// Build steps are a way of providing tasks for the build runner to execute. Let’s create a build step, and make it the default. When you run zig build this will output Hello!.

const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const step = b.step("task", "do something");
    step.makeFn = myTask;
    b.default_step = step;
}

fn myTask(self: *std.build.Step) !void {
    std.debug.print("Hello!\n", .{});
    _ = self;
}
// We called exe.install() earlier - this adds a build step which tells the builder to build the executable.
