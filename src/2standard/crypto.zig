const expect = @import("std").testing.expect;
const std = @import("std");
const mem = std.mem;

// Crypto
// ------
// std.crypto includes many cryptographic utilities, including:

// AES (Aes128, Aes256)
// Diffie-Hellman key exchange (x25519)
// Elliptic-curve arithmetic (curve25519, edwards25519, ristretto255)
// Crypto secure hashing (blake2, Blake3, Gimli, Md5, sha1, sha2, sha3)
// MAC functions (Ghash, Poly1305)
// Stream ciphers (ChaCha20IETF, ChaCha20With64BitNonce, XChaCha20IETF, Salsa20, XSalsa20)
// This list is inexhaustive. For more in-depth information,
// try A tour of std.crypto in Zig 0.7.0 - Frank Denis.
