import 'dart:developer';

import 'package:bip329_wallet_labels/src/data/models/label_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_connection_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_label_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class RemoteLabelbaseDatasource {
  Future<ExistingLabelbaseModel> createNewLabelbase(
    NewLabelbaseModel labelbase, {
    required UnscopedLabelbaseConnectionModel connection,
  });
  Future<LabelbaseLabelModel> createLabel(
    LabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  });
  Future<List<LabelbaseLabelModel>> getLabels({
    required ScopedLabelbaseConnectionModel connection,
  });
  Future<LabelbaseLabelModel> updateLabel(
    LabelbaseLabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  });
  Future<void> deleteLabel(
    LabelbaseLabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  });
}

class RemoteLabelbaseDatasourceImpl implements RemoteLabelbaseDatasource {
  final http.Client _httpClient;

  const RemoteLabelbaseDatasourceImpl({required http.Client httpClient})
    : _httpClient = httpClient;

  @override
  Future<ExistingLabelbaseModel> createNewLabelbase(
    NewLabelbaseModel newLabelbase, {
    required UnscopedLabelbaseConnectionModel connection,
  }) async {
    final url = connection.baseUrl.replace(
      pathSegments: [...connection.baseUrl.pathSegments, 'labelbase'],
    );

    final headers = {
      ...connection.headers,
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // The api expects only string values in the body since it uses application/x-www-form-urlencoded
    final body = _stringifyFormData({
      'name': newLabelbase.name,
      'fingerprint': newLabelbase.fingerprint,
      'about': newLabelbase.about,
    });

    final response = await _httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      log(
        '[RemoteLabelbaseDatasourceImpl] successfully created labelbase: $json',
      );
      final labelbase = newLabelbase.existingWith(json['id'] as String);
      return labelbase;
    } else {
      final msg =
          'Labelbase response: ${response.statusCode} - ${response.body}';
      log(msg);
      throw Exception(msg);
    }
  }

  @override
  Future<LabelbaseLabelModel> createLabel(
    LabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  }) async {
    final url = connection.baseUrl.replace(
      pathSegments: [
        ...connection.baseUrl.pathSegments,
        'labelbase',
        connection.labelbaseId,
        'label',
      ],
    );
    final headers = {
      ...connection.headers,
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // The api expects only string values in the body since it uses application/x-www-form-urlencoded
    final body = _stringifyFormData(label.toJson());

    final response = await _httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      log('[RemoteLabelbaseDatasourceImpl] successfully created label: $json');
      final labelbaseLabel = LabelbaseLabelModel.fromLabelModel(
        label,
        labelbaseLabelId: json['id'] as String,
      );
      return labelbaseLabel;
    } else {
      final msg =
          'Labelbase response: ${response.statusCode} - ${response.body}';
      log(msg);
      throw Exception(msg);
    }
  }

  @override
  Future<List<LabelbaseLabelModel>> getLabels({
    required ScopedLabelbaseConnectionModel connection,
  }) async {
    final url = connection.baseUrl.replace(
      pathSegments: [
        ...connection.baseUrl.pathSegments,
        'labelbase',
        connection.labelbaseId,
        'label',
      ],
    );

    final response = await _httpClient.get(url, headers: connection.headers);

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((json) {
        final map = json as Map<String, dynamic>;
        return LabelbaseLabelModel(
          id: map['id'] as String,
          label: LabelModel.fromJson(map),
        );
      }).toList();
    } else {
      final msg =
          'Labelbase response: ${response.statusCode} - ${response.body}';
      log(msg);
      throw Exception(msg);
    }
  }

  @override
  Future<LabelbaseLabelModel> updateLabel(
    LabelbaseLabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  }) async {
    final url = connection.baseUrl.replace(
      pathSegments: [
        ...connection.baseUrl.pathSegments,
        'labelbase',
        connection.labelbaseId,
        'label',
        label.id,
      ],
    );

    // The api expects only string values in the body since it uses application/x-www-form-urlencoded
    final body = _stringifyFormData(label.label.toJson());

    final response = await _httpClient.put(
      url,
      headers: {
        ...connection.headers,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return LabelbaseLabelModel(
        id: json['id'] as String,
        label: LabelModel.fromJson(json),
      );
    } else {
      final msg =
          'Labelbase response: ${response.statusCode} - ${response.body}';
      log(msg);
      throw Exception(msg);
    }
  }

  @override
  Future<void> deleteLabel(
    LabelbaseLabelModel label, {
    required ScopedLabelbaseConnectionModel connection,
  }) async {
    final url = connection.baseUrl.replace(
      pathSegments: [
        ...connection.baseUrl.pathSegments,
        'labelbase',
        connection.labelbaseId,
        'label',
        label.id,
      ],
    );

    final response = await _httpClient.delete(url, headers: connection.headers);

    if (response.statusCode != 200 && response.statusCode != 204) {
      final msg =
          'Labelbase response: ${response.statusCode} - ${response.body}';
      log(msg);
      throw Exception(msg);
    }
  }

  Map<String, String> _stringifyFormData(Map<String, dynamic> data) {
    return data.map((key, value) => MapEntry(key, value?.toString() ?? ''));
  }
}
