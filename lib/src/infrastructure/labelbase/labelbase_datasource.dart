import 'dart:convert';
import 'package:http/http.dart' as http;

import 'labelbase_label_model.dart';

class LabelbaseDatasource {
  final http.Client _httpClient;
  final String _baseUrl;
  final String _apiKey;
  final String _labelbaseId;

  LabelbaseDatasource({
    required http.Client httpClient,
    required String baseUrl,
    required String apiKey,
    required String labelbaseId,
  }) : _httpClient = httpClient,
       _baseUrl = baseUrl,
       _apiKey = apiKey,
       _labelbaseId = labelbaseId;

  Uri labelUri({int? labelId}) => Uri.parse(
    '$_baseUrl'
    'labelbase/$_labelbaseId/label/${labelId != null ? '$labelId/' : ''}',
  );

  Future<LabelbaseLabelModel> addLabel(
    LabelbaseLabelDataModel labelData,
  ) async {
    final response = await _httpClient.post(
      labelUri(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $_apiKey',
      },
      body: json.encode(labelData.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return LabelbaseLabelModel.fromJson(jsonData);
    } else {
      throw LabelbaseException(
        'Failed to add label: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<List<LabelbaseLabelModel>> getAllLabels() async {
    final response = await _httpClient.get(
      labelUri(),
      headers: {'Authorization': 'Token $_apiKey'},
    );

    if (response.statusCode == 200) {
      final labels = json.decode(response.body) as List<dynamic>;
      return labels
          .map(
            (json) =>
                LabelbaseLabelModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw LabelbaseException(
        'Failed to get labels: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<LabelbaseLabelModel?> findExactLabel(
    LabelbaseLabelDataModel searchLabelData,
  ) async {
    final labels = await getAllLabels();

    for (final label in labels) {
      if (_isExactMatch(label.data, searchLabelData)) {
        return label;
      }
    }
    return null;
  }

  Future<void> updateLabel(LabelbaseLabelModel updatedLabel) async {
    final response = await _httpClient.put(
      labelUri(labelId: updatedLabel.id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $_apiKey',
      },
      body: json.encode(updatedLabel.data.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw LabelbaseException(
        'Failed to update label: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<void> deleteLabel(int labelId) async {
    final response = await _httpClient.delete(
      labelUri(labelId: labelId),
      headers: {'Authorization': 'Token $_apiKey'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw LabelbaseException(
        'Failed to delete label: ${response.statusCode} ${response.body}',
      );
    }
  }

  bool _isExactMatch(
    LabelbaseLabelDataModel label1,
    LabelbaseLabelDataModel label2,
  ) {
    return label1.type == label2.type &&
        label1.ref == label2.ref &&
        label1.label == label2.label &&
        label1.origin == label2.origin &&
        label1.spendable == label2.spendable;
  }

  void dispose() {
    _httpClient.close();
  }
}

class LabelbaseException implements Exception {
  final String message;
  LabelbaseException(this.message);

  @override
  String toString() => 'LabelbaseException: $message';
}
