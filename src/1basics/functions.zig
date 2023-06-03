const expect = @import("std").testing.expect;

// all functions arguments are immutable. if copy is deisred explicitly make one
// function names are camelCase
//
fn addFive(x: u32) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(0); // explicit copy of function
    try expect(@TypeOf(y) == u32);
    try expect(y == 5);
}

// Recursion allowed
fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);
    try expect(x == 55);
}
