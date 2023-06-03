const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// Translate-C
// Zig provides the command zig translate-c for automatic translation from C source code.

// Create the file main.c with the following contents.

// #include <stddef.h>

// void int_sort(int* array, size_t count) {
//     for (int i = 0; i < count - 1; i++) {
//         for (int j = 0; j < count - i - 1; j++) {
//             if (array[j] > array[j+1]) {
//                 int temp = array[j];
//                 array[j] = array[j+1];
//                 array[j+1] = temp;
//             }
//         }
//     }
// }
// Run the command zig translate-c main.c to get the equivalent Zig code output to your console (stdout). You may wish to pipe this into a file with zig translate-c main.c > int_sort.zig (warning for windows users: piping in powershell will produce a file with the incorrect encoding - use your editor to correct this).

// In another file you could use @import("int_sort.zig") to make use of this function.

// Currently the code produced may be unnecessarily verbose, though translate-c successfully translates most C code into Zig. You may wish to use translate-c to produce Zig code before editing it into more idiomatic code; a gradual transfer from C to Zig within a codebase is a supported use case.

// cImport
// Zig’s @cImport builtin is unique in that it takes in an expression, which can only take in @cInclude, @cDefine, and @cUndef. This works similarly to translate-c, translating C code to Zig under the hood.

// @cInclude takes in a path string, can adds the path to the includes list.

// @cDefine and @cUndef define and undefine things for the import.

// These three functions work exactly as you’d expect them to work within C code.

// Similar to @import this returns a struct type with declarations. It is typically recommended to only use one instance of @cImport in an application to avoid symbol collisions; the types generated within one cImport will not be equivalent to those generated in another.

// cImport is only available when linking libc.

// Linking libc
// Linking libc can be done via the command line via -lc, or via build.zig using exe.linkLibC();. The libc used is that of the compilation’s target; Zig provides libc for many targets.

// Zig cc, Zig c++
// The Zig executable comes with Clang embedded inside it alongside libraries and headers required to cross compile for other operating systems and architectures.

// This means that not only can zig cc and zig c++ compile C and C++ code (with Clang-compatible arguments), but it can also do so while respecting Zig’s target triple argument; the single Zig binary that you have installed has the power to compile for several different targets without the need to install multiple versions of the compiler or any addons. Using zig cc and zig c++ also makes use of Zig’s caching system to speed up your workflow.

// Using Zig, one can easily construct a cross-compiling toolchain for languages which make use of a C and/or C++ compiler.

// Some examples in the wild:

// Using zig cc to cross compile LuaJIT to aarch64-linux from x86_64-linux

// Using zig cc and zig c++ in combination with cgo to cross compile hugo from aarch64-macos to x86_64-linux, with full static linking
