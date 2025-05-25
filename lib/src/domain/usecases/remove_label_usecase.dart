import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class RemoveLabelUsecase {
  final LabelRepository _labelRepository;

  RemoveLabelUsecase({required LabelRepository labelRepository})
    : _labelRepository = labelRepository;

  Future<void> execute(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) async {
    try {
      await _labelRepository.removeLabel(
        label,
        filePath: filePath,
        labelbaseConnection: labelbaseConnection,
      );
    } catch (e) {
      throw RemoveLabelException('$e');
    }
  }
}

class RemoveLabelException implements Exception {
  final String message;

  RemoveLabelException(this.message);

  @override
  String toString() => '[RemoveLabelUsecase]: $message';
}
