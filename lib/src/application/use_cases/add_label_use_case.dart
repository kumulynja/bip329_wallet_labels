import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../../domain/label_type_value_object.dart';
import '../dtos/requests/add_label_request.dart';

class AddLabelUseCase {
  final LabelRepository _repository;

  AddLabelUseCase(this._repository);

  Future<void> execute(AddLabelRequest request) async {
    // Create the label entity from the request
    final label = _createLabelFromRequest(request);

    // Business rule: Check if label already exists
    final existingLabel = await _repository.findExistingLabel(label);
    if (existingLabel != null) {
      throw LabelAlreadyExistsException(
        'Label already exists: ${label.type.bip329Type}:${label.ref}',
      );
    }

    await _repository.addLabel(label);
  }

  LabelEntity _createLabelFromRequest(AddLabelRequest request) {
    final type = LabelTypeValueObject.fromBip329Type(request.type);

    switch (type) {
      case LabelTypeValueObject.transaction:
        return TransactionLabelEntity(
          txId: request.ref,
          label: request.label,
          origin: request.origin,
          blockHeight: request.blockHeight,
          blockTime: request.blockTime,
          valueSat: request.valueSat,
          minerFeeSat: request.minerFeeSat,
          exchangeRates: request.exchangeRates,
        );

      case LabelTypeValueObject.address:
        return AddressLabelEntity(
          address: request.ref,
          label: request.label,
          origin: request.origin,
          keyPath: request.keyPath,
          heights: request.heights,
        );

      case LabelTypeValueObject.pubkey:
        return PubkeyLabelEntity(
          publicKey: request.ref,
          label: request.label,
          origin: request.origin,
        );

      case LabelTypeValueObject.input:
        if (request.index == null) {
          throw ArgumentError('Index is required for input labels');
        }
        final parts = request.ref.split(':');
        if (parts.length != 2) {
          throw ArgumentError('Invalid input ref format. Expected txid:index');
        }
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: request.label,
          origin: request.origin,
          keyPath: request.keyPath,
          valueSat: request.valueSat,
          fairMarketValue: request.fairMarketValue,
          blockHeight: request.blockHeight,
          blockTime: request.blockTime,
        );

      case LabelTypeValueObject.output:
        if (request.index == null) {
          throw ArgumentError('Index is required for output labels');
        }
        final parts = request.ref.split(':');
        if (parts.length != 2) {
          throw ArgumentError('Invalid output ref format. Expected txid:index');
        }
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: request.label,
          origin: request.origin,
          keyPath: request.keyPath,
          spendable: request.spendable,
          valueSat: request.valueSat,
          fairMarketValue: request.fairMarketValue,
          blockHeight: request.blockHeight,
          blockTime: request.blockTime,
        );

      case LabelTypeValueObject.xpub:
        return XpubLabelEntity(
          xpub: request.ref,
          label: request.label,
          origin: request.origin,
          keyPath: request.keyPath,
        );
    }
  }
}

class LabelAlreadyExistsException implements Exception {
  final String message;
  LabelAlreadyExistsException(this.message);

  @override
  String toString() => 'LabelAlreadyExistsException: $message';
}
