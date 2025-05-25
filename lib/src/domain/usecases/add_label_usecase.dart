import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class AddLabelUsecase {
  final LabelRepository _labelRepository;

  AddLabelUsecase({required LabelRepository labelRepository})
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
      throw AddLabelException('$e');
    }
  }
}

class AddLabelException implements Exception {
  final String message;

  AddLabelException(this.message);

  @override
  String toString() => '[AddLabelUsecase]: $message';
}
