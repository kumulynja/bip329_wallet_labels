import 'package:http/http.dart' as http;

import 'application/use_cases/add_label_use_case.dart';
import 'application/use_cases/delete_label_use_case.dart';
import 'application/use_cases/export_labels_use_case.dart';
import 'application/use_cases/get_labels_use_case.dart';
import 'application/use_cases/update_label_use_case.dart';
import 'infrastructure/labelbase/labelbase_datasource.dart';
import 'infrastructure/labelbase/labelbase_datasource_adapter.dart';
import 'infrastructure/labelbase/labelbase_sync_datasource_adapter.dart';
import 'infrastructure/local/local_encrypted_datasource.dart';
import 'infrastructure/local/local_sync_datasource_adapter.dart';
import 'infrastructure/sync/sync_repository.dart';
import 'interface_adapters/controllers/label_controller.dart';
import 'interface_adapters/persistence/label_repository_impl.dart';

// The classes in this file are the public API of our library.
sealed class Label {
  final String? label;
  final String? origin;

  const Label({this.label, this.origin});

  String get type;
  String get ref;
}

class TransactionLabel extends Label {
  final String txId;

  const TransactionLabel({required this.txId, super.label, super.origin});

  @override
  String get type => 'tx';

  @override
  String get ref => txId;

  TransactionLabel copyWith({
    String? txId,
    String? Function()? label,
    String? Function()? origin,
  }) {
    return TransactionLabel(
      txId: txId ?? this.txId,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionLabel &&
          txId == other.txId &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(txId, label, origin);

  @override
  String toString() => 'TransactionLabel(txId: $txId, label: $label)';
}

class AddressLabel extends Label {
  final String address;

  const AddressLabel({required this.address, super.label, super.origin});

  @override
  String get type => 'addr';

  @override
  String get ref => address;

  AddressLabel copyWith({
    String? address,
    String? Function()? label,
    String? Function()? origin,
  }) {
    return AddressLabel(
      address: address ?? this.address,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressLabel &&
          address == other.address &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(address, label, origin);

  @override
  String toString() => 'AddressLabel(address: $address, label: $label)';
}

class PubkeyLabel extends Label {
  final String publicKey;

  const PubkeyLabel({required this.publicKey, super.label, super.origin});

  @override
  String get type => 'pubkey';

  @override
  String get ref => publicKey;

  PubkeyLabel copyWith({
    String? publicKey,
    String? Function()? label,
    String? Function()? origin,
  }) {
    return PubkeyLabel(
      publicKey: publicKey ?? this.publicKey,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PubkeyLabel &&
          publicKey == other.publicKey &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(publicKey, label, origin);

  @override
  String toString() => 'PubkeyLabel(publicKey: $publicKey, label: $label)';
}

class InputLabel extends Label {
  final String txId;
  final int index;

  const InputLabel({
    required this.txId,
    required this.index,
    super.label,
    super.origin,
  });

  @override
  String get type => 'input';

  @override
  String get ref => '$txId:$index';

  InputLabel copyWith({
    String? txId,
    int? index,
    String? Function()? label,
    String? Function()? origin,
  }) {
    return InputLabel(
      txId: txId ?? this.txId,
      index: index ?? this.index,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputLabel &&
          txId == other.txId &&
          index == other.index &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(txId, index, label, origin);

  @override
  String toString() => 'InputLabel(txId: $txId, index: $index, label: $label)';
}

class OutputLabel extends Label {
  final String txId;
  final int index;
  final bool? spendable;

  const OutputLabel({
    required this.txId,
    required this.index,
    super.label,
    super.origin,
    this.spendable,
  });

  @override
  String get type => 'output';

  @override
  String get ref => '$txId:$index';

  OutputLabel copyWith({
    String? txId,
    int? index,
    String? Function()? label,
    String? Function()? origin,
    bool? Function()? spendable,
  }) {
    return OutputLabel(
      txId: txId ?? this.txId,
      index: index ?? this.index,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
      spendable: spendable != null ? spendable() : this.spendable,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutputLabel &&
          txId == other.txId &&
          index == other.index &&
          label == other.label &&
          origin == other.origin &&
          spendable == other.spendable;

  @override
  int get hashCode => Object.hash(txId, index, label, origin, spendable);

  @override
  String toString() =>
      'OutputLabel(txId: $txId, index: $index, label: $label, spendable: $spendable)';
}

class XpubLabel extends Label {
  final String xpub;

  const XpubLabel({required this.xpub, super.label, super.origin});

  @override
  String get type => 'xpub';

  @override
  String get ref => xpub;

  XpubLabel copyWith({
    String? xpub,
    String? Function()? label,
    String? Function()? origin,
  }) {
    return XpubLabel(
      xpub: xpub ?? this.xpub,
      label: label != null ? label() : this.label,
      origin: origin != null ? origin() : this.origin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is XpubLabel &&
          xpub == other.xpub &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(xpub, label, origin);

  @override
  String toString() => 'XpubLabel(xpub: $xpub, label: $label)';
}

class LabelbaseConfig {
  final Uri baseUrl;
  final String apiKey;
  final String labelbaseId;

  const LabelbaseConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.labelbaseId,
  });
}

class LocalEncryptedConfig {
  final String passphrase;
  final String? dbPath;

  const LocalEncryptedConfig({
    required this.passphrase,
    this.dbPath,
  });
}

class Bip329WalletLabels {
  final LabelController _controller;
  final LocalSyncDatasourceAdapter? _localDatasource;
  final LabelRepositoryImpl _repository;
  final SyncRepository? _syncRepository;

  Bip329WalletLabels._(this._controller, this._localDatasource, this._repository, [this._syncRepository]);

  /// Creates with local encrypted storage only (default mode)
  static Future<Bip329WalletLabels> createLocal({
    required LocalEncryptedConfig config,
  }) async {
    // Create local encrypted datasource
    final localDatasource = LocalEncryptedDatasource(
      passphrase: config.passphrase,
      dbPath: config.dbPath,
    );
    await localDatasource.initialize();

    final localAdapter = LocalSyncDatasourceAdapter(localDatasource);

    // Create repository with only local datasource
    final repository = LabelRepositoryImpl([localAdapter]);

    // Create use cases
    final getLabelsUseCase = GetLabelsUseCase(repository);
    final addLabelUseCase = AddLabelUseCase(repository);
    final updateLabelUseCase = UpdateLabelUseCase(repository);
    final deleteLabelUseCase = DeleteLabelUseCase(repository);
    final exportLabelsUseCase = ExportLabelsUseCase(repository);

    // Create controller
    final controller = LabelController(
      getLabelsUseCase: getLabelsUseCase,
      addLabelUseCase: addLabelUseCase,
      updateLabelUseCase: updateLabelUseCase,
      deleteLabelUseCase: deleteLabelUseCase,
      exportLabelsUseCase: exportLabelsUseCase,
    );

    return Bip329WalletLabels._(controller, localAdapter, repository);
  }

  /// Creates with both local and remote storage with sync capabilities
  static Future<Bip329WalletLabels> createWithRemote({
    required LocalEncryptedConfig localConfig,
    required LabelbaseConfig remoteConfig,
  }) async {
    // Create local encrypted datasource
    final localDatasource = LocalEncryptedDatasource(
      passphrase: localConfig.passphrase,
      dbPath: localConfig.dbPath,
    );
    await localDatasource.initialize();

    final localSyncAdapter = LocalSyncDatasourceAdapter(localDatasource);

    // Create remote datasource
    final httpClient = http.Client();
    final remoteDatasource = LabelbaseDatasource(
      httpClient: httpClient,
      baseUrl: remoteConfig.baseUrl.toString(),
      apiKey: remoteConfig.apiKey,
      labelbaseId: remoteConfig.labelbaseId,
    );
    final remoteSyncAdapter = LabelbaseSyncDatasourceAdapter(remoteDatasource);

    // Create sync repository for remote-first operations
    final syncRepository = SyncRepository(
      localDatasource: localSyncAdapter,
      remoteDatasource: remoteSyncAdapter,
    );

    // Create use cases with sync repository
    final getLabelsUseCase = GetLabelsUseCase(syncRepository);
    final addLabelUseCase = AddLabelUseCase(syncRepository);
    final updateLabelUseCase = UpdateLabelUseCase(syncRepository);
    final deleteLabelUseCase = DeleteLabelUseCase(syncRepository);
    final exportLabelsUseCase = ExportLabelsUseCase(syncRepository);

    // Create controller
    final controller = LabelController(
      getLabelsUseCase: getLabelsUseCase,
      addLabelUseCase: addLabelUseCase,
      updateLabelUseCase: updateLabelUseCase,
      deleteLabelUseCase: deleteLabelUseCase,
      exportLabelsUseCase: exportLabelsUseCase,
    );

    // Also create a fallback repository for basic operations (backward compatibility)
    final basicRepository = LabelRepositoryImpl([localSyncAdapter, remoteSyncAdapter]);

    return Bip329WalletLabels._(controller, localSyncAdapter, basicRepository, syncRepository);
  }

  /// Creates with Labelbase remote storage only (legacy mode)
  @Deprecated('Use createLocal or createWithRemote instead')
  static Bip329WalletLabels create(LabelbaseConfig config) {
    // Create HTTP client
    final httpClient = http.Client();

    // Create datasource
    final datasource = LabelbaseDatasource(
      httpClient: httpClient,
      baseUrl: config.baseUrl.toString(),
      apiKey: config.apiKey,
      labelbaseId: config.labelbaseId,
    );
    final adapter = LabelbaseDatasourceAdapter(datasource);

    // Create repository
    final repository = LabelRepositoryImpl([adapter]);

    // Create use cases
    final getLabelsUseCase = GetLabelsUseCase(repository);
    final addLabelUseCase = AddLabelUseCase(repository);
    final updateLabelUseCase = UpdateLabelUseCase(repository);
    final deleteLabelUseCase = DeleteLabelUseCase(repository);
    final exportLabelsUseCase = ExportLabelsUseCase(repository);

    // Create controller
    final controller = LabelController(
      getLabelsUseCase: getLabelsUseCase,
      addLabelUseCase: addLabelUseCase,
      updateLabelUseCase: updateLabelUseCase,
      deleteLabelUseCase: deleteLabelUseCase,
      exportLabelsUseCase: exportLabelsUseCase,
    );

    return Bip329WalletLabels._(controller, null, repository);
  }

  /// Get all labels, optionally filtered by type, ref, label, and/or origin
  Future<List<Label>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    return await _controller.getLabels(
      type: type,
      ref: ref,
      label: label,
      origin: origin,
    );
  }

  /// Add a new label
  Future<void> addLabel(Label label) async {
    await _controller.addLabel(label);
  }

  /// Update an existing label
  Future<void> updateLabel({
    required Label currentLabel,
    required Label updatedLabel,
  }) async {
    await _controller.updateLabel(
      currentLabel: currentLabel,
      updatedLabel: updatedLabel,
    );
  }

  /// Delete a label
  Future<void> deleteLabel(Label label) async {
    await _controller.deleteLabel(label);
  }

  /// Export all labels in BIP329 JSON Lines format
  Future<String> exportLabels() async {
    return await _controller.exportLabels();
  }

  /// Sync labels between local and remote storage
  ///
  /// This method reconciles local and remote label state by:
  /// 1. Pushing any pending local changes to remote
  /// 2. Pulling remote changes and resolving conflicts
  ///
  /// Only available when both local and remote storage are configured.
  Future<void> sync() async {
    if (_syncRepository != null) {
      await _syncRepository.sync();
    } else {
      throw UnsupportedError(
        'Sync is only available when both local and remote storage are configured. '
        'Use createWithRemote() to enable sync capabilities.'
      );
    }
  }

  /// Change passphrase for local encrypted storage
  Future<void> changePassphrase(String newPassphrase) async {
    if (_localDatasource != null) {
      await _localDatasource.changePassphrase(newPassphrase);
    } else {
      throw UnsupportedError('No local storage configured');
    }
  }

  /// Close the database connection and free resources
  Future<void> close() async {
    await dispose();
  }

  /// Dispose of all resources (database connections, HTTP clients, etc.)
  Future<void> dispose() async {
    await _repository.dispose();
  }
}
