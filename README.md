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

`bip329_wallet_labels` is a Dart package that provides functionality for managing wallet labels according to the [BIP329](https://github.com/bitcoin/bips/blob/master/bip-0329.mediawiki) standard, both locally in a BIP329 JSON file as remotely in a [Labelbase](https://labelbase.space) server.

## Features

- [ ] Let users create, read, update, and delete wallet labels.
- [ ] Support for both local BIP329 JSON files and remote Labelbase servers.
- [ ] No need for wallet end-users to manually export their labels to a BIP329 JSON file, an up-to-date BIP329 JSON file is always available.
- [ ] Automatic synchronization of labels between local and remote storage.

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

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information
