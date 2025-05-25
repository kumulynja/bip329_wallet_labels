/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/bip329_wallet_labels_base.dart';

// Export datasources for users to instantiate and inject into the repositories.
export 'src/data/datasources/datasources.dart';
// Export repositories for users to instantiate and inject into the use cases.
export 'src/data/repositories/repositories.dart';
// Export domain entities for users to instantiate and pass them in the use cases.
export 'src/domain/entities/entities.dart';
// Export domain repositories so users can use abstract classes where no concrete
// implementation is needed.
export 'src/domain/repositories/repositories.dart';
// Export use cases for users to instantiate and inject into the presentation layer.
export 'src/domain/usecases/usecases.dart';
