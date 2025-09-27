enum LabelTypeValueObject {
  transaction('tx'),
  address('addr'),
  pubkey('pubkey'),
  input('input'),
  output('output'),
  xpub('xpub');

  final String bip329Type;
  const LabelTypeValueObject(this.bip329Type);

  static LabelTypeValueObject fromBip329Type(String type) {
    return LabelTypeValueObject.values.firstWhere(
      (lt) => lt.bip329Type == type,
      orElse: () => throw ArgumentError('Unknown BIP329 type: $type'),
    );
  }
}
