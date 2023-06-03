const expect = @import("std").testing.expect;

// Opaque
// -------
// opaque types in Zig have an unknown (albeit non-zero) size and
// alignment. Because of this these data types cannot be stored directly. These are used to maintain type safety with pointers to types that we don’t have information about.

// const Window = opaque {};
// const Button = opaque {};

extern fn show_window(*Window) callconv(.C) void;

// test "opaque" {
//     var main_window: *Window = undefined;
//     show_window(main_window);

// var ok_button: *Button = undefined;
// show_window(ok_button);
// }
// ./test-c1.zig:653:17: error: expected type '*Window', found '*Button'
//     show_window(ok_button);
//                 ^
// ./test-c1.zig:653:17: note: pointer type child 'Button' cannot cast into pointer type child 'Window'
//     show_window(ok_button);
//                 ^
// Opaque types may have declarations in their definitions
// (the same as structs, enums and unions).

const Window = opaque {
    fn show(self: *Window) void {
        _ = self;
        // show_window(self);
    }
};

// extern fn show_window(*Window) callconv(.C) void;

test "opaque with declarations" {
    var main_window: *Window = undefined;
    main_window.show();
}
// The typical usecase of opaque is to maintain type safety when
// interoperating with C code that does not expose complete type
// information.
