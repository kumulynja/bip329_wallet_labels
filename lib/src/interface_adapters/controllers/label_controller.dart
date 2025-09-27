import 'package:bip329_wallet_labels/src/application/dtos/responses/get_label_response.dart';

import '../../application/dtos/requests/get_labels_request.dart';

import '../../application/dtos/requests/add_label_request.dart';
import '../../application/dtos/requests/delete_label_request.dart';
import '../../application/dtos/requests/update_label_request.dart';
import '../../application/use_cases/add_label_use_case.dart'
    hide LabelAlreadyExistsException;
import '../../application/use_cases/delete_label_use_case.dart'
    hide LabelNotFoundException;
import '../../application/use_cases/export_labels_use_case.dart';
import '../../application/use_cases/get_labels_use_case.dart';
import '../../application/use_cases/update_label_use_case.dart'
    hide LabelNotFoundException;
import '../../bip329_wallet_labels_base.dart';
import '../../exceptions/bip329_exceptions.dart';

class LabelController {
  final GetLabelsUseCase _getLabelsUseCase;
  final AddLabelUseCase _addLabelUseCase;
  final UpdateLabelUseCase _updateLabelUseCase;
  final DeleteLabelUseCase _deleteLabelUseCase;
  final ExportLabelsUseCase _exportLabelsUseCase;

  LabelController({
    required GetLabelsUseCase getLabelsUseCase,
    required AddLabelUseCase addLabelUseCase,
    required UpdateLabelUseCase updateLabelUseCase,
    required DeleteLabelUseCase deleteLabelUseCase,
    required ExportLabelsUseCase exportLabelsUseCase,
  }) : _getLabelsUseCase = getLabelsUseCase,
       _addLabelUseCase = addLabelUseCase,
       _updateLabelUseCase = updateLabelUseCase,
       _deleteLabelUseCase = deleteLabelUseCase,
       _exportLabelsUseCase = exportLabelsUseCase;

  Future<List<Label>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    try {
      final request = GetLabelsRequest(
        type: type,
        ref: ref,
        label: label,
        origin: origin,
      );
      final labels = await _getLabelsUseCase.execute(request);

      return labels.map((label) => _convertGetLabelResponse(label)).toList();
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<void> addLabel(Label label) async {
    try {
      final request = _convertPublicModelToAddRequest(label);
      await _addLabelUseCase.execute(request);
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<void> updateLabel({
    required Label currentLabel,
    required Label updatedLabel,
  }) async {
    try {
      final request = _convertPublicModelToUpdateRequest(
        currentLabel,
        updatedLabel,
      );
      await _updateLabelUseCase.execute(request);
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<void> deleteLabel(Label label) async {
    try {
      final request = _convertPublicModelToDeleteRequest(label);
      await _deleteLabelUseCase.execute(request);
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<String> exportLabels() async {
    try {
      return await _exportLabelsUseCase.execute();
    } catch (e) {
      throw _handleException(e);
    }
  }

  // Conversion methods
  Label _convertGetLabelResponse(GetLabelResponse label) {
    switch (label.type) {
      case 'tx':
        return TransactionLabel(
          txId: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case 'addr':
        return AddressLabel(
          address: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case 'pubkey':
        return PubkeyLabel(
          publicKey: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case 'input':
        return InputLabel(
          txId: label.ref.split(':').first,
          index: int.parse(label.ref.split(':').last),
          label: label.label,
          origin: label.origin,
        );

      case 'output':
        return OutputLabel(
          txId: label.ref.split(':').first,
          index: int.parse(label.ref.split(':').last),
          spendable: label.spendable ?? false,
          label: label.label,
          origin: label.origin,
        );

      case 'xpub':
        return XpubLabel(
          xpub: label.ref,
          label: label.label,
          origin: label.origin,
        );

      default:
        throw LabelbaseConnectionException('Unknown label type: ${label.type}');
    }
  }

  AddLabelRequest _convertPublicModelToAddRequest(Label label) {
    switch (label) {
      case TransactionLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case AddressLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case PubkeyLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case InputLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
          index: label.index,
        );

      case OutputLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
          index: label.index,
          spendable: label.spendable,
        );

      case XpubLabel():
        return AddLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );
    }
  }

  UpdateLabelRequest _convertPublicModelToUpdateRequest(
    Label currentLabel,
    Label updatedLabel,
  ) {
    switch (currentLabel) {
      case TransactionLabel():
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
        );

      case AddressLabel():
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
        );

      case PubkeyLabel():
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
        );

      case InputLabel():
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          currentIndex: currentLabel.index,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
        );

      case OutputLabel():
        final updatedOutput = updatedLabel as OutputLabel;
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          currentIndex: currentLabel.index,
          currentSpendable: currentLabel.spendable,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
          newSpendable: updatedOutput.spendable,
        );

      case XpubLabel():
        return UpdateLabelRequest(
          type: currentLabel.type,
          currentRef: currentLabel.ref,
          currentLabel: currentLabel.label,
          currentOrigin: currentLabel.origin,
          newLabel: updatedLabel.label,
          newOrigin: updatedLabel.origin,
        );
    }
  }

  DeleteLabelRequest _convertPublicModelToDeleteRequest(Label label) {
    switch (label) {
      case TransactionLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case AddressLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case PubkeyLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );

      case InputLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
          index: label.index,
        );

      case OutputLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
          index: label.index,
          spendable: label.spendable,
        );

      case XpubLabel():
        return DeleteLabelRequest(
          type: label.type,
          ref: label.ref,
          label: label.label,
          origin: label.origin,
        );
    }
  }

  Bip329Exception _handleException(Object e) {
    if (e is Bip329Exception) return e;

    // Convert internal exceptions to public ones
    final message = e.toString();
    if (message.contains('LabelNotFoundException')) {
      return LabelNotFoundException(message);
    } else if (message.contains('LabelAlreadyExistsException')) {
      return LabelAlreadyExistsException(message);
    } else if (message.contains('LabelbaseException')) {
      return LabelbaseConnectionException(message);
    } else {
      return LabelbaseConnectionException(
        'An unexpected error occurred: $message',
      );
    }
  }
}
