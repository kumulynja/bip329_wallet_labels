class SimpleLabelEntity {
  final LabelType type;
  final String ref;
  final String? label;
  final String? origin;
  final bool? spendable;

  const SimpleLabelEntity({
    required this.type,
    required this.ref,
    this.label,
    this.origin,
    this.spendable,
  });

  factory SimpleLabelEntity.fromMap(Map<String, dynamic> data) {
    return SimpleLabelEntity(
      type: _parseLabelType(data['type']),
      ref: data['ref'],
      label: data['label'],
      origin: data['origin'],
      spendable: data['spendable'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.bip329Type,
      'ref': ref,
      if (label != null) 'label': label,
      if (origin != null) 'origin': origin,
      if (spendable != null) 'spendable': spendable,
    };
  }

  static LabelType _parseLabelType(String type) {
    switch (type) {
      case 'tx':
        return LabelType.tx;
      case 'addr':
        return LabelType.address;
      case 'pubkey':
        return LabelType.pubkey;
      case 'input':
        return LabelType.input;
      case 'output':
        return LabelType.output;
      case 'xpub':
        return LabelType.xpub;
      default:
        throw Exception('Unknown label type: $type');
    }
  }

  bool isExactMatch(SimpleLabelEntity other) {
    return type == other.type &&
        ref == other.ref &&
        label == other.label &&
        origin == other.origin &&
        spendable == other.spendable;
  }
}

enum LabelType {
  tx('tx'),
  address('addr'),
  pubkey('pubkey'),
  input('input'),
  output('output'),
  xpub('xpub');

  final String bip329Type;
  const LabelType(this.bip329Type);
}