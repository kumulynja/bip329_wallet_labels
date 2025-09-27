import 'dart:convert';

import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';

class ExportLabelsUseCase {
  final LabelRepository _repository;

  ExportLabelsUseCase(this._repository);

  Future<String> execute() async {
    final labels = await _repository.getLabels();

    final jsonLines = <String>[];

    for (final label in labels) {
      final bip329Record = _convertToBip329Record(label);
      jsonLines.add(json.encode(bip329Record));
    }

    return jsonLines.join('\n');
  }

  Map<String, dynamic> _convertToBip329Record(LabelEntity label) {
    final record = <String, dynamic>{
      'type': label.type.bip329Type,
      'ref': label.ref,
    };

    // Add optional label field
    if (label.label != null) {
      record['label'] = label.label;
    }

    // Add optional origin field
    if (label.origin != null) {
      record['origin'] = label.origin;
    }

    // Add type-specific fields
    switch (label) {
      case TransactionLabelEntity():
        // Add additional transaction fields if available
        if (label.blockHeight != null) {
          record['height'] = label.blockHeight;
        }
        if (label.blockTime != null) {
          record['time'] = label.blockTime!.toIso8601String();
        }
        if (label.minerFeeSat != null) {
          record['fee'] = label.minerFeeSat;
        }
        if (label.valueSat != null) {
          record['value'] = label.valueSat;
        }
        if (label.exchangeRates != null && label.exchangeRates!.isNotEmpty) {
          record['rate'] = label.exchangeRates;
        }

      case AddressLabelEntity():
        // Add keypath if available
        if (label.keyPath != null) {
          record['keypath'] = label.keyPath;
        }
        // Add heights if available
        if (label.heights.isNotEmpty) {
          record['heights'] = label.heights;
        }

      case InputLabelEntity():
        // Add keypath if available
        if (label.keyPath != null) {
          record['keypath'] = label.keyPath;
        }
        // Add value if available
        if (label.valueSat != null) {
          record['value'] = label.valueSat;
        }
        // Add fair market value if available
        if (label.fairMarketValue != null &&
            label.fairMarketValue!.isNotEmpty) {
          record['fmv'] = label.fairMarketValue;
        }
        // Add block info if available
        if (label.blockHeight != null) {
          record['height'] = label.blockHeight;
        }
        if (label.blockTime != null) {
          record['time'] = label.blockTime!.toIso8601String();
        }

      case OutputLabelEntity():
        // Add keypath if available
        if (label.keyPath != null) {
          record['keypath'] = label.keyPath;
        }
        // Add spendable field if available (required for outputs in BIP329)
        if (label.spendable != null) {
          record['spendable'] = label.spendable;
        }
        // Add value if available
        if (label.valueSat != null) {
          record['value'] = label.valueSat;
        }
        // Add fair market value if available
        if (label.fairMarketValue != null &&
            label.fairMarketValue!.isNotEmpty) {
          record['fmv'] = label.fairMarketValue;
        }
        // Add block info if available
        if (label.blockHeight != null) {
          record['height'] = label.blockHeight;
        }
        if (label.blockTime != null) {
          record['time'] = label.blockTime!.toIso8601String();
        }

      case XpubLabelEntity():
        // Add keypath if available
        if (label.keyPath != null) {
          record['keypath'] = label.keyPath;
        }

      case PubkeyLabelEntity():
        // No additional fields for pubkey labels
        break;
    }

    return record;
  }
}
