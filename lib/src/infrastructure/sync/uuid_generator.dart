import 'dart:math';

/// Simple UUID v4 generator for event IDs
class UuidGenerator {
  static final _random = Random.secure();

  /// Generate a UUID v4 string
  static String generate() {
    // Generate 16 random bytes
    final bytes = List<int>.generate(16, (i) => _random.nextInt(256));

    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // Version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // Variant 10

    // Format as UUID string
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }
}