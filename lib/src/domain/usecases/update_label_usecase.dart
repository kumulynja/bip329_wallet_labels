import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class UpdateLabelUsecase {
  final LabelRepository _labelRepository;

  UpdateLabelUsecase({required LabelRepository labelRepository})
    : _labelRepository = labelRepository;

  Future<void> execute(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) async {
    try {
      await _labelRepository.addLabel(
        label,
        filePath: filePath,
        labelbaseConnection: labelbaseConnection,
      );
    } catch (e) {
      throw UpdateLabelException('$e');
    }
  }
}

class UpdateLabelException implements Exception {
  final String message;

  UpdateLabelException(this.message);

  @override
  String toString() => '[UpdateLabelUsecase]: $message';
}
