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

`bip329_wallet_labels` is a Dart package that provides functionality for managing wallet labels according to the [BIP329](https://github.com/bitcoin/bips/blob/master/bip-0329.mediawiki) standard. Currently it provides the [Labelbase](https://labelbase.space) client functionality to store labels remotely on a Labelbase server and export them from there as a BIP329 JSON file. Future versions will also include encrypted local BIP329 management with automatic synchronization with the Labelbase server if one is configured.

## Features

- [x] Configure your own Labelbase server or use the public one at [labelbase.space](https://labelbase.space).
- [x] Add, get, update, and delete labels following the BIP329 standard.
- [x] Export labels from the Labelbase server as a BIP329 JSON file.
- [ ] (Planned) Local encrypted BIP329 label management with automatic synchronization with the Labelbase server.

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

```dart
import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  // Load environment variables from .env file
  var env = DotEnv(includePlatformEnvironment: true)..load();

  // Get environment variables
  final labelbaseUrl = env['LABELBASE_URL'];
  final labelbaseId = env['LABELBASE_ID'];
  final apiKey = env['LABELBASE_API_KEY'];

  // Validate that all required environment variables are present
  if (labelbaseUrl == null || labelbaseId == null || apiKey == null) {
    print('Error: Missing required environment variables.');
    print('Please create a .env file with:');
    print('  LABELBASE_URL=<your_labelbase_url>');
    print('  LABELBASE_ID=<your_labelbase_id>');
    print('  LABELBASE_API_KEY=<your_api_key>');
    return;
  }

  // Set up Labelbase configuration
  final labelbaseConfig = LabelbaseConfig(
    baseUrl: Uri.parse(labelbaseUrl),
    labelbaseId: labelbaseId,
    apiKey: apiKey,
  );

  // Create Bip329WalletLabels instance with the configuration
  final walletLabels = await Bip329WalletLabels.create(labelbaseConfig);

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

## Additional information

Thanks to xavierfiechter for the Labelbase project and API.
