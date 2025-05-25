import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class SetupLabelbaseUsecase {
  final LabelbaseRepository _labelbaseRepository;

  SetupLabelbaseUsecase({required LabelbaseRepository labelbaseRepository})
    : _labelbaseRepository = labelbaseRepository;

  Future<Labelbase> execute({
    required String name,
    required String fingerprint,
    required String about,
    required LabelbaseConnectionBase connection,
  }) async {
    try {
      final labelbase = await _labelbaseRepository.createNewLabelBase(
        name: name,
        fingerprint: fingerprint,
        about: about,
        connection: connection,
      );

      return labelbase;
    } catch (e) {
      throw SetupLabelbaseException('$e');
    }
  }
}

class SetupLabelbaseException implements Exception {
  final String message;

  SetupLabelbaseException(this.message);

  @override
  String toString() => '[SetupLabelbaseUsecase]: $message';
}
