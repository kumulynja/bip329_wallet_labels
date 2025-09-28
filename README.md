<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# BIP329 Wallet Labels Dart Package

`bip329_wallet_labels` is a Dart package that provides functionality for managing wallet labels according to the [BIP329](https://github.com/bitcoin/bips/blob/master/bip-0329.mediawiki) standard. It supports both local encrypted storage (default) and remote storage using [Labelbase](https://labelbase.space), with the ability to use both simultaneously. Labels can be exported in the standardized BIP329 JSON Lines format.

## Features

- [x] **Local encrypted storage** - Store labels locally with encryption and searchable blind indexes
- [x] **Remote storage** - Configure your own Labelbase server or use the public one at [labelbase.space](https://labelbase.space)
- [x] **Dual storage mode** - Use both local and remote storage simultaneously
- [x] **BIP329 compliance** - Add, get, update, and delete labels following the BIP329 standard
- [x] **Export functionality** - Export labels as a BIP329 JSON Lines file
- [x] **Privacy-focused** - Local storage uses XChaCha20-Poly1305 AEAD encryption with blind indexes for searching
- [x] **Pure Dart** - No platform-specific dependencies for maximum compatibility
- [x] **Easy to use** - Simple unified API for managing wallet labels
- [x] **Configurable** - Flexible configuration options for local and remote storage
- [x] **Documentation** - Comprehensive documentation and examples
- [ ] **Auto-sync** - Automatic synchronization between local and remote storage
- [ ] **BIP329 type-specific fields** - Support for additional type-specific fields in labels as per BIP329
- [ ] **Well-tested** - Comprehensive unit and integration tests to ensure reliability

## Getting started

To use the `bip329_wallet_labels` package, add it to your `pubspec.yaml` file as a dependency or run

```bash
dart pub add bip329_wallet_labels
```

Then, import the package in your Dart or Flutter project:

```dart
import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';
```

## Usage

### Local Storage Only (Default)

```dart
import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

Future<void> main() async {
  // Create with local encrypted storage only
  final walletLabels = await Bip329WalletLabels.createLocal(
    config: LocalEncryptedConfig(
      passphrase: 'your-secure-passphrase',
    ),
  );

  // Use the wallet labels API as normal
  final label = TransactionLabel(
    txId: 'F4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16',
    label: 'Satoshi sending sats',
  );
  await walletLabels.addLabel(label);
  final labels = await walletLabels.getLabels();

  // Change passphrase if needed
  await walletLabels.changePassphrase('new-secure-passphrase');
}
```

### Combined Local and Remote Storage

```dart
import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

Future<void> main() async {
  // Create with both local and remote storage
  final walletLabels = await Bip329WalletLabels.createWithRemote(
    localConfig: LocalEncryptedConfig(
      passphrase: 'your-secure-passphrase',
    ),
    remoteConfig: LabelbaseConfig(
      baseUrl: Uri.parse('https://labelbase.space'),
      labelbaseId: 'your-labelbase-id',
      apiKey: 'your-api-key',
    ),
  );

  // Labels will be stored in both local and remote storage
  final label = AddressLabel(
    address: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
    label: 'My savings address',
  );
  await walletLabels.addLabel(label);
}
```

### Complete Example

```dart
import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

Future<void> main() async {
  // Create wallet labels instance with local storage
  final walletLabels = await Bip329WalletLabels.createLocal(
    config: LocalEncryptedConfig(
      passphrase: 'your-secure-passphrase',
    ),
  );

  // Example labels to add
  final label1 = TransactionLabel(
    txId: 'F4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16',
    label: 'Satoshi sending sats',
  );
  final label2 = TransactionLabel(
    txId: 'Cca7507897abc89628f450e8b1e0c6fca4ec3f7b34cccf55f3f531c659ff4d79',
    label: 'Two supreme pizzas from Papa John\'s',
  );
  final label3 = AddressLabel(
    address:
        '04ae1a62fe09c5f51b13905f07f06b99a2f7159b2225f374cd378d71302fa28414e7aab37397f554a7df5f142c21c1b7303b8a0626f1baded5c72a704f7e6cd84c',
    label: 'Address of Satoshi',
  );

  // Add labels
  await walletLabels.addLabel(label1);
  await walletLabels.addLabel(label2);
  await walletLabels.addLabel(label3);
  print('labels added');

  // Fetch and print all labels
  final labels = await walletLabels.getLabels();
  print('Labels: $labels');

  // Update a label
  final label1Update = label1.copyWith(
    // label: null, // No change to label, keep existing, unnecessary to specify
    // label: () => 'Satoshi sending some sats', // Update label
    // label: () => null, // Remove label
    label: () => 'Satoshi sending some sats',
  );
  await walletLabels.updateLabel(
    currentLabel: label1,
    updatedLabel: label1Update,
  );
  print('label1 updated');

  // Delete a label
  await walletLabels.deleteLabel(label2);
  print('label2 deleted');

  // Export updated and remaining labels
  final exportedLabels = await walletLabels.exportLabels();
  print('Labels exported in JSON format:\n $exportedLabels');
}
```

## Storage Modes

### Local Encrypted Storage

The default and recommended mode. Labels are stored locally with:

- **Encryption**: XChaCha20-Poly1305 AEAD for label data
- **Key Management**: PBKDF2-HMAC-SHA256 for key derivation from passphrase
- **Searchable Encryption**: Blind indexes using HMAC for equality searches
- **Privacy**: No plaintext data stored, frequency and access pattern leakage acceptable for label use case

### Remote Storage (Labelbase)

Optional remote storage using the Labelbase API for cloud backup and cross-device access.

### Combined Mode

When both local and remote configs are provided:

- Labels are stored in both locations
- Reads query both sources and merge results
- No automatic synchronization (planned for future versions)

## Security Considerations

- **Passphrase**: Use a strong passphrase for local encryption
- **Blind Indexes**: Provide search capability but leak access patterns
- **Key Derivation**: PBKDF2 iterations calibrated to ~200-500ms
- **Pure Dart**: Uses well-tested cryptography libraries

## Additional information

- BIP329 specification: https://github.com/bitcoin/bips/blob/master/bip-0329.mediawiki
- For bugs or feature requests, please open an issue on GitHub

## Acknowledgements

- Thanks to xavierfiechter for the Labelbase project and API
