// Zig Build
// The zig build command allows users to compile based on a build.zig file. zig init-exe and zig-init-lib can be used to give you a baseline project.

// Let’s use zig init-exe inside a new folder. This is what you will find.

// .
// ├── build.zig
// └── src
//     └── main.zig
// build.zig contains our build script. The build runner will use this pub fn build function as its entry point - this is what is executed when you run zig build.

const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("init-exe", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
// main.zig contains our executable’s entry point.

const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
}
// Upon using the zig build command, the executable will appear in the install path. Here we have not specified an install path, so the executable will be saved in ./zig-cache/bin.
