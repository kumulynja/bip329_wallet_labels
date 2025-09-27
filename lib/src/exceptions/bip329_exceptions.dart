abstract class Bip329Exception implements Exception {
  final String message;
  const Bip329Exception(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class LabelNotFoundException extends Bip329Exception {
  const LabelNotFoundException(super.message);
}

class LabelAlreadyExistsException extends Bip329Exception {
  const LabelAlreadyExistsException(super.message);
}

class LabelbaseConnectionException extends Bip329Exception {
  const LabelbaseConnectionException(super.message);
}

class InvalidLabelFormatException extends Bip329Exception {
  const InvalidLabelFormatException(super.message);
}
