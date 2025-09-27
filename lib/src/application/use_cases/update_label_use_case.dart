import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../../domain/label_type_value_object.dart';
import '../dtos/requests/update_label_request.dart';

class UpdateLabelUseCase {
  final LabelRepository _repository;

  UpdateLabelUseCase(this._repository);

  Future<void> execute(UpdateLabelRequest request) async {
    // Create a search label to find the existing one
    final searchLabel = _createLabelFromCurrentData(request);

    // Find the existing label
    final existingLabel = await _repository.findExistingLabel(searchLabel);
    if (existingLabel == null) {
      throw LabelNotFoundException(
        'Label not found: ${request.type}:${request.currentRef}',
      );
    }

    // Apply updates to the existing entity using business methods
    _applyUpdates(existingLabel, request);

    // Update in repository
    await _repository.updateLabel(
      labelToUpdate: searchLabel,
      updatedLabel: existingLabel,
    );
  }

  LabelEntity _createLabelFromCurrentData(UpdateLabelRequest request) {
    final type = LabelTypeValueObject.fromBip329Type(request.type);

    switch (type) {
      case LabelTypeValueObject.transaction:
        return TransactionLabelEntity(
          txId: request.currentRef,
          label: request.currentLabel,
          origin: request.currentOrigin,
          blockHeight: request.currentBlockHeight,
          blockTime: request.currentBlockTime,
          valueSat: request.currentValueSat,
          minerFeeSat: request.currentMinerFeeSat,
          exchangeRates: request.currentExchangeRates,
        );

      case LabelTypeValueObject.address:
        return AddressLabelEntity(
          address: request.currentRef,
          label: request.currentLabel,
          origin: request.currentOrigin,
          keyPath: request.currentKeyPath,
          heights: request.currentHeights,
        );

      case LabelTypeValueObject.pubkey:
        return PubkeyLabelEntity(
          publicKey: request.currentRef,
          label: request.currentLabel,
          origin: request.currentOrigin,
        );

      case LabelTypeValueObject.input:
        if (request.currentIndex == null) {
          throw ArgumentError('Index is required for input labels');
        }
        final parts = request.currentRef.split(':');
        if (parts.length != 2) {
          throw ArgumentError('Invalid input ref format. Expected txid:index');
        }
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: request.currentLabel,
          origin: request.currentOrigin,
          keyPath: request.currentKeyPath,
          valueSat: request.currentValueSat,
          fairMarketValue: request.currentFairMarketValue,
          blockHeight: request.currentBlockHeight,
          blockTime: request.currentBlockTime,
        );

      case LabelTypeValueObject.output:
        if (request.currentIndex == null) {
          throw ArgumentError('Index is required for output labels');
        }
        final parts = request.currentRef.split(':');
        if (parts.length != 2) {
          throw ArgumentError('Invalid output ref format. Expected txid:index');
        }
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: request.currentLabel,
          origin: request.currentOrigin,
          keyPath: request.currentKeyPath,
          spendable: request.currentSpendable,
          valueSat: request.currentValueSat,
          fairMarketValue: request.currentFairMarketValue,
          blockHeight: request.currentBlockHeight,
          blockTime: request.currentBlockTime,
        );

      case LabelTypeValueObject.xpub:
        return XpubLabelEntity(
          xpub: request.currentRef,
          label: request.currentLabel,
          origin: request.currentOrigin,
          keyPath: request.currentKeyPath,
        );
    }
  }

  void _applyUpdates(LabelEntity label, UpdateLabelRequest request) {
    // Apply common updates using business methods
    if (request.newLabel != null) {
      label.updateLabel(request.newLabel);
    }
    if (request.newOrigin != null) {
      label.updateOrigin(request.newOrigin);
    }

    // Apply type-specific updates using business methods
    switch (label) {
      case TransactionLabelEntity():
        if (request.newValueSat != null || request.newMinerFeeSat != null) {
          label.updateValue(
            request.newValueSat ?? label.valueSat,
            request.newMinerFeeSat ?? label.minerFeeSat,
          );
        }
        if (request.newBlockHeight != null || request.newBlockTime != null) {
          label.updateBlockInfo(
            request.newBlockHeight ?? label.blockHeight,
            request.newBlockTime ?? label.blockTime,
          );
        }
        if (request.newExchangeRates != null) {
          label.updateExchangeRates(request.newExchangeRates);
        }

      case AddressLabelEntity():
        if (request.newKeyPath != null) {
          label.updateKeyPath(request.newKeyPath);
        }
        if (request.newHeights != null) {
          label.updateHeights(request.newHeights!);
        }

      case PubkeyLabelEntity():
      // No type-specific updates for pubkey labels

      case InputLabelEntity():
        if (request.newKeyPath != null) {
          (label as InputLabelEntity).updateKeyPath(request.newKeyPath);
        }
        if (request.newValueSat != null) {
          (label as InputLabelEntity).updateValue(request.newValueSat);
        }
        if (request.newFairMarketValue != null) {
          (label as InputLabelEntity).updateFairMarketValue(
            request.newFairMarketValue,
          );
        }
        if (request.newBlockHeight != null || request.newBlockTime != null) {
          (label as InputLabelEntity).updateBlockInfo(
            request.newBlockHeight ?? label.blockHeight,
            request.newBlockTime ?? label.blockTime,
          );
        }

      case OutputLabelEntity():
        if (request.newKeyPath != null) {
          label.updateKeyPath(request.newKeyPath);
        }
        if (request.newSpendable != null) {
          label.updateSpendable(request.newSpendable);
        }
        if (request.newValueSat != null) {
          label.updateValue(request.newValueSat);
        }
        if (request.newFairMarketValue != null) {
          label.updateFairMarketValue(request.newFairMarketValue);
        }
        if (request.newBlockHeight != null || request.newBlockTime != null) {
          label.updateBlockInfo(
            request.newBlockHeight ?? label.blockHeight,
            request.newBlockTime ?? label.blockTime,
          );
        }

      case XpubLabelEntity():
        if (request.newKeyPath != null) {
          label.updateKeyPath(request.newKeyPath);
        }
    }
  }
}

class LabelNotFoundException implements Exception {
  final String message;
  LabelNotFoundException(this.message);

  @override
  String toString() => 'LabelNotFoundException: $message';
}
