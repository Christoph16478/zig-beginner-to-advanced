const expect = @import("std").testing.expect;

// Loops
// ------

// Labelled Loops
// Loops can be given labels, allowing you to break and continue to
// outer loops.
test "nested continue" {
    var count: usize = 0;
    outer: for ([_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 }) |_| {
        for ([_]i32{ 1, 2, 3, 4, 5 }) |_| {
            count += 1;
            continue :outer;
        }
    }
    try expect(count == 8);
}
// Loops as expressions
// Like return, break accepts a value. This can be used to yield a
// value from a loop. Loops in Zig also have an else branch on loops,
// which is evaluated when the loop is not exited from with a break.
fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression" {
    try expect(rangeHasNumber(0, 10, 3));
}

// Inline Loops
// inline loops are unrolled, and allow some things to happen which only
// work at compile time. Here we use a for, but a while works similarly.
test "inline for" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;
    inline for (types) |T| sum += @sizeOf(T);
    try expect(sum == 10);
}

// Using these for performance reasons is inadvisable unless
// you’ve tested that explicitly unrolling is faster; the compiler
// tends to make better decisions here than you.
