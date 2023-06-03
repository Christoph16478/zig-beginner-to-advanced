const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Outputting an Executable
// The commands zig build-exe, zig build-lib, and zig build-obj can be used to output executables, libraries and objects, respectively. These commands take in a source file and arguments.

// Some common arguments:

// --single-threaded, which asserts the binary is single-threaded. This will turn thread safety measures such as mutexes into no-ops.
// --strip, which removes debug info from the binary.
// --dynamic, which is used in conjunction with zig build-lib to output a dynamic/shared library.
// Let’s create a tiny hello world. Save this as tiny-hello.zig, and run zig build-exe .\tiny-hello.zig -O ReleaseSmall --strip --single-threaded. Currently for x86_64-windows, this produces a 2.5KiB executable.

const std = @import("std");

pub fn main() void {
    std.io.getStdOut().writeAll(
        "Hello World!",
    ) catch unreachable;
}
