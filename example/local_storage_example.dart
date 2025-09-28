import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

Future<void> main() async {
  print('=== BIP329 Wallet Labels - Local Encrypted Storage Example ===\n');

  // Create wallet labels instance with local encrypted storage
  print('Creating wallet labels with local encrypted storage...');
  final walletLabels = await Bip329WalletLabels.createLocal(
    config: LocalEncryptedConfig(
      passphrase: 'my-secure-passphrase-123!',
      //dbPath: 'wallet_labels.db',
    ),
  );
  print('✓ Local encrypted storage initialized\n');

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
    address: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
    label: 'My savings address',
  );
  final label4 = OutputLabel(
    txId: '0e3e2357e806b6cdb1f70b54c3a3a17b6714ee1f0e68bebb44a74b1efd512098',
    index: 0,
    label: 'Change output',
    spendable: true,
  );

  // Add labels to encrypted storage
  print('Adding labels to encrypted storage...');
  await walletLabels.addLabel(label1);
  await walletLabels.addLabel(label2);
  await walletLabels.addLabel(label3);
  await walletLabels.addLabel(label4);
  print('✓ Labels added successfully\n');

  // Fetch and display all labels
  print('Fetching all labels from encrypted storage...');
  final allLabels = await walletLabels.getLabels();
  print('Found ${allLabels.length} labels:');
  for (final label in allLabels) {
    print('  - [${label.type}] ${label.ref}: ${label.label}');
  }
  print('');

  // Search for specific labels
  print('Searching for transaction labels...');
  final txLabels = await walletLabels.getLabels(type: 'tx');
  print('Found ${txLabels.length} transaction labels:');
  for (final label in txLabels) {
    print('  - ${label.ref}: ${label.label}');
  }
  print('');

  // Update a label
  print('Updating a label...');
  final updatedLabel1 = label1.copyWith(
    label: () => 'Satoshi sending some sats (updated)',
  );
  await walletLabels.updateLabel(
    currentLabel: label1,
    updatedLabel: updatedLabel1,
  );
  print('✓ Label updated successfully\n');

  // Delete a label
  print('Deleting a label...');
  await walletLabels.deleteLabel(label2);
  print('✓ Label deleted successfully\n');

  // Demonstrate passphrase change
  print('Changing passphrase...');
  await walletLabels.changePassphrase('new-secure-passphrase-456!');
  print('✓ Passphrase changed successfully\n');

  // Verify labels are still accessible after passphrase change
  print('Verifying labels are still accessible...');
  final labelsAfterChange = await walletLabels.getLabels();
  print('Found ${labelsAfterChange.length} labels after passphrase change');

  // Change the passphrase back to the original for consecutive runs
  print('Changing back passphrase...');
  await walletLabels.changePassphrase('my-secure-passphrase-123!');
  print('✓ Passphrase changed back successfully\n');

  // Export labels in BIP329 format
  print('Exporting labels in BIP329 JSON Lines format...');
  final exportedLabels = await walletLabels.exportLabels();
  print('Exported labels:');
  print(exportedLabels);
  print('');
  print('✓ All operations completed successfully!\n');

  // Clean up resources
  print('Cleaning up resources...');
  await walletLabels.dispose();
  print('✓ All resources disposed successfully');
}
