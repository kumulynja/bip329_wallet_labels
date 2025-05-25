import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';
import 'package:get_it/get_it.dart';

import 'locator.dart';

Future<void> main() async {
  Locator.setup();

  final baseConnection = LabelbaseConnection.base(
    apiKey: 'your_labelbase_api_key',
    baseUrl: Uri.parse('https://labelbase.space/api/v0/'),
  );

  final labelbase = await GetIt.instance<SetupLabelbaseUsecase>().execute(
    name: 'My Example Labelbase',
    fingerprint: 'your_fingerprint',
    about: 'This is an example labelbase',
    connection: baseConnection as LabelbaseConnectionBase,
  );
  print('Created labelbase with id: ${labelbase.id}');
}
