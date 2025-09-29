import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

import '../../domain/label_entity.dart';
import 'sync_types.dart';

/// Utilities for canonical JSON serialization and digest computation
class CanonicalUtils {

  /// Convert a label entity to canonical BIP329 JSON
  /// This produces a stable JSON representation for digest computation
  static String toCanonicalJson(LabelEntity label) {
    // Create a map with standardized BIP329 fields in alphabetical order
    final Map<String, dynamic> canonical = {};

    // Always include type and ref
    canonical['type'] = _normalizeType(label.type.bip329Type);
    canonical['ref'] = _normalizeRef(label.ref, label.type.bip329Type);

    // Add label if present (normalized)
    if (label.label != null && label.label!.isNotEmpty) {
      canonical['label'] = _normalizeLabel(label.label!);
    }

    // Add origin if present (normalized)
    if (label.origin != null && label.origin!.isNotEmpty) {
      canonical['origin'] = _normalizeOrigin(label.origin!);
    }

    // Add spendable for output labels (base BIP329 field)
    if (label is OutputLabelEntity && label.spendable != null) {
      canonical['spendable'] = label.spendable;
    }

    // Convert to JSON with consistent ordering
    return jsonEncode(canonical);
  }

  /// Create a LabelKey from a label entity using normalized values
  static LabelKey toLabelKey(LabelEntity label) {
    return LabelKey(
      originNorm: _normalizeOrigin(label.origin ?? ''),
      type: _normalizeType(label.type.bip329Type),
      refNorm: _normalizeRef(label.ref, label.type.bip329Type),
    );
  }

  /// Compute HMAC-SHA256 digest of canonical JSON using MEK
  /// Returns truncated digest (32 bytes for security)
  static Uint8List computeDigest(String canonicalJson, Uint8List mek) {
    final hmac = Hmac(sha256, mek);
    final digest = hmac.convert(utf8.encode(canonicalJson));
    return Uint8List.fromList(digest.bytes); // Full 32 bytes
  }

  /// Normalize type field
  static String _normalizeType(String type) {
    return type.toLowerCase().trim();
  }

  /// Normalize ref field based on type
  static String _normalizeRef(String ref, String type) {
    final normalizedType = _normalizeType(type);
    final trimmed = ref.trim();

    switch (normalizedType) {
      case 'tx':
      case 'transaction':
        // Transaction IDs should be lowercase hex
        return trimmed.toLowerCase();
      case 'addr':
      case 'address':
        // Addresses are case-sensitive in Bitcoin, keep as-is
        return trimmed;
      case 'pubkey':
        // Public keys should be lowercase hex
        return trimmed.toLowerCase();
      case 'input':
      case 'output':
        // Format: txid:index - normalize txid part
        final parts = trimmed.split(':');
        if (parts.length == 2) {
          return '${parts[0].toLowerCase()}:${parts[1]}';
        }
        return trimmed.toLowerCase();
      case 'xpub':
        // Extended public keys are case-sensitive, keep as-is
        return trimmed;
      default:
        return trimmed;
    }
  }

  /// Normalize label text
  static String _normalizeLabel(String label) {
    // Trim whitespace but preserve internal spacing and case
    return label.trim();
  }

  /// Normalize origin field
  static String _normalizeOrigin(String origin) {
    // Origins are BIP380 descriptors, preserve case and format
    return origin.trim();
  }
}