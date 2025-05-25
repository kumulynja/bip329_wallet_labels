import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class GetLabelsUsecase {
  final LabelRepository _labelRepository;

  GetLabelsUsecase({required LabelRepository labelRepository})
    : _labelRepository = labelRepository;

  Future<List<Label>> execute({
    LabelFilter? filter,
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) async {
    try {
      final labels = await _labelRepository.getLabels(
        filter: filter,
        filePath: filePath,
        labelbaseConnection: labelbaseConnection,
      );

      return labels;
    } catch (e) {
      // Handle exceptions as needed
      throw Exception('$e');
    }
  }
}

class GetLabelsException implements Exception {
  final String message;

  GetLabelsException(this.message);

  @override
  String toString() => '[GetLabelsUsecase]: $message';
}
