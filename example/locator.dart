import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class Locator {
  static void setup() {
    _registerDatasources();
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerDatasources() {
    GetIt.instance.registerLazySingleton<RemoteLabelbaseDatasource>(
      () => RemoteLabelbaseDatasourceImpl(httpClient: http.Client()),
    );
    GetIt.instance.registerLazySingleton<LocalBip329FileDatasource>(
      () => LocalBip329FileDatasourceImpl(),
    );
  }

  static void _registerRepositories() {
    GetIt.instance.registerLazySingleton<LabelRepository>(
      () => LabelRepositoryImpl(
        remoteDatasource: GetIt.instance<RemoteLabelbaseDatasource>(),
        localDatasource: GetIt.instance<LocalBip329FileDatasource>(),
      ),
    );
    GetIt.instance.registerLazySingleton<LabelbaseRepository>(
      () => LabelbaseRepositoryImpl(
        remoteLabelbaseDatasource: GetIt.instance<RemoteLabelbaseDatasource>(),
      ),
    );
  }

  static void _registerUseCases() {
    GetIt.instance.registerFactory<AddLabelUsecase>(
      () => AddLabelUsecase(labelRepository: GetIt.instance<LabelRepository>()),
    );
    GetIt.instance.registerFactory<GetLabelsUsecase>(
      () =>
          GetLabelsUsecase(labelRepository: GetIt.instance<LabelRepository>()),
    );
    GetIt.instance.registerFactory<RemoveLabelUsecase>(
      () => RemoveLabelUsecase(
        labelRepository: GetIt.instance<LabelRepository>(),
      ),
    );
    GetIt.instance.registerFactory<SetupLabelbaseUsecase>(
      () => SetupLabelbaseUsecase(
        labelbaseRepository: GetIt.instance<LabelbaseRepository>(),
      ),
    );
    GetIt.instance.registerFactory<UpdateLabelUsecase>(
      () => UpdateLabelUsecase(
        labelRepository: GetIt.instance<LabelRepository>(),
      ),
    );
  }
}
