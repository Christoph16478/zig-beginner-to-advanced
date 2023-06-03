const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

// C Primitive Types
// Zig provides special c_ prefixed types for conforming to the C ABI. These do not have fixed sizes, but rather change in size depending on the ABI being used.

// Type	C Equivalent	Minimum Size (bits)
// c_short	short	16
// c_ushort	unsigned short	16
// c_int	int	16
// c_uint	unsigned int	16
// c_long	long	32
// c_ulong	unsigned long	32
// c_longlong	long long	64
// c_ulonglong	unsigned longlong	64
// c_longdouble	long double	N/A
// c_void	void	N/A
// Note: C’s void (and Zig’s c_void) has an unknown non-zero size. Zig’s void is a true zero-sized type.
