import 'package:bip329_wallet_labels/src/application/dtos/responses/get_label_response.dart';

import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../dtos/requests/get_labels_request.dart';

class GetLabelsUseCase {
  final LabelRepository _repository;

  GetLabelsUseCase(this._repository);

  Future<List<GetLabelResponse>> execute(GetLabelsRequest request) async {
    final labels = await _repository.getLabels(
      type: request.type,
      ref: request.ref,
      label: request.label,
      origin: request.origin,
    );

    return labels.map((label) => _mapToResponse(label)).toList();
  }

  GetLabelResponse _mapToResponse(LabelEntity label) {
    return GetLabelResponse(
      type: label.type.bip329Type,
      ref: label.ref,
      label: label.label,
      origin: label.origin,
    );
  }
}
