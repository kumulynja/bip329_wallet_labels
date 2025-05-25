import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:bip329_wallet_labels/src/data/models/label_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_connection_model.dart';
import 'package:bip329_wallet_labels/src/data/models/labelbase_label_model.dart';
import 'package:bip329_wallet_labels/src/data/datasources/remote_labelbase_datasource.dart';
import 'package:test/test.dart';

void main() {
  late MockClient mockClient;
  late RemoteLabelbaseDatasourceImpl datasource;

  final baseUrl = Uri.parse('https://example.com');
  final unscopedConnection = UnscopedLabelbaseConnectionModel(
    baseUrl: baseUrl,
    apiKey: 'test-key',
  );
  final scopedConnection = ScopedLabelbaseConnectionModel(
    baseUrl: baseUrl,
    apiKey: 'test-key',
    labelbaseId: 'labelbase123',
  );

  final labelModel = LabelModel(type: 'address', ref: 'some-ref');
  final labelbaseLabelModel = LabelbaseLabelModel(
    id: 'label123',
    label: labelModel,
  );
  final newLabelbase = NewLabelbaseModel(
    name: 'Test',
    fingerprint: 'abc123',
    about: 'description',
  );

  group('createNewLabelbase', () {
    test('successfully creates and returns a labelbase', () async {
      mockClient = MockClient((request) async {
        expect(request.url.toString(), '${baseUrl.toString()}/labelbase');
        expect(request.headers['Authorization'], 'Token test-key');
        expect(
          request.headers['Content-Type'],
          startsWith('application/x-www-form-urlencoded'),
        );

        final body = Uri.splitQueryString(request.body);
        expect(body['name'], newLabelbase.name);
        expect(body['fingerprint'], newLabelbase.fingerprint);
        expect(body['about'], newLabelbase.about);

        return http.Response(jsonEncode({'id': 'new-id'}), 201);
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      final result = await datasource.createNewLabelbase(
        newLabelbase,
        connection: unscopedConnection,
      );
      expect(result.id, 'new-id');
      expect(result.name, newLabelbase.name);
      expect(result.fingerprint, newLabelbase.fingerprint);
      expect(result.about, newLabelbase.about);
    });
  });

  group('createLabel', () {
    test('createLabel sends properly encoded form data', () async {
      mockClient = MockClient((request) async {
        expect(
          request.headers['Content-Type'],
          startsWith('application/x-www-form-urlencoded'),
        );

        // Ensure body is properly URL encoded
        expect(request.body.contains('type=address'), isTrue);
        expect(request.body.contains('ref=some-ref'), isTrue);

        return http.Response(jsonEncode({'id': 'created-id'}), 201);
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      await datasource.createLabel(labelModel, connection: scopedConnection);
    });

    test('successfully creates and returns a label', () async {
      mockClient = MockClient((request) async {
        expect(
          request.url.toString(),
          '${baseUrl.toString()}/labelbase/labelbase123/label',
        );
        expect(request.headers['Authorization'], 'Token test-key');
        expect(
          request.headers['Content-Type'],
          startsWith('application/x-www-form-urlencoded'),
        );

        final body = Uri.splitQueryString(request.body);
        expect(body['type'], labelModel.type);
        expect(body['ref'], labelModel.ref);

        return http.Response(jsonEncode({'id': 'created-id'}), 201);
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      final result = await datasource.createLabel(
        labelModel,
        connection: scopedConnection,
      );
      expect(result.id, 'created-id');
    });
  });

  group('getLabels', () {
    test('returns a list of LabelbaseLabelModel on success', () async {
      mockClient = MockClient((request) async {
        expect(
          request.url.toString(),
          '${baseUrl.toString()}/labelbase/labelbase123/label',
        );
        expect(request.headers['Authorization'], 'Token test-key');

        final jsonList = [
          {'id': '1', 'type': 'address', 'ref': 'ref1'},
          {'id': '2', 'type': 'address', 'ref': 'ref2'},
        ];
        return http.Response(jsonEncode(jsonList), 200);
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      final result = await datasource.getLabels(connection: scopedConnection);
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].label.ref, 'ref2');
    });
  });

  group('updateLabel', () {
    test('updateLabel sends properly encoded form data', () async {
      mockClient = MockClient((request) async {
        expect(
          request.headers['Content-Type'],
          startsWith('application/x-www-form-urlencoded'),
        );
        expect(request.url.toString(), contains('/label/label123'));

        expect(request.body.contains('ref=some-ref'), isTrue);
        expect(request.body.contains('type=address'), isTrue);

        return http.Response(
          jsonEncode({'id': 'label123', 'type': 'address', 'ref': 'some-ref'}),
          200,
        );
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      await datasource.updateLabel(
        labelbaseLabelModel,
        connection: scopedConnection,
      );
    });

    test('returns updated label on success', () async {
      mockClient = MockClient((request) async {
        expect(
          request.url.toString(),
          '${baseUrl.toString()}/labelbase/labelbase123/label/label123',
        );
        expect(request.method, 'PUT');
        expect(request.headers['Authorization'], 'Token test-key');
        expect(
          request.headers['Content-Type'],
          startsWith('application/x-www-form-urlencoded'),
        );

        final body = Uri.splitQueryString(request.body);
        expect(body['type'], labelModel.type);
        expect(body['ref'], labelModel.ref);

        return http.Response(
          jsonEncode({
            'id': 'label123',
            'type': 'address',
            'ref': 'updated-ref',
          }),
          200,
        );
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      final result = await datasource.updateLabel(
        labelbaseLabelModel,
        connection: scopedConnection,
      );
      expect(result.id, 'label123');
      expect(result.label.ref, 'updated-ref');
    });
  });

  group('deleteLabel', () {
    test('sends DELETE to correct URL and succeeds on 204', () async {
      mockClient = MockClient((request) async {
        expect(
          request.url.toString(),
          '${baseUrl.toString()}/labelbase/labelbase123/label/label123',
        );
        expect(request.method, 'DELETE');
        expect(request.headers['Authorization'], 'Token test-key');
        return http.Response('', 204);
      });

      datasource = RemoteLabelbaseDatasourceImpl(httpClient: mockClient);
      await datasource.deleteLabel(
        labelbaseLabelModel,
        connection: scopedConnection,
      );
    });
  });
}
