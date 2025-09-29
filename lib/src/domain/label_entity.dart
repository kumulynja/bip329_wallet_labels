import 'label_type_value_object.dart';

sealed class LabelEntity {
  String? _label;
  String? _origin;

  LabelEntity({String? label, String? origin})
    : _label = label,
      _origin = origin;

  // Abstract getters
  LabelTypeValueObject get type;
  String get ref;

  // Common properties
  String? get label => _label;
  String? get origin => _origin;

  // Business methods with validation
  void updateLabel(String? newLabel) {
    if (newLabel != null && newLabel.trim().isEmpty) {
      throw ArgumentError('LabelEntity cannot be empty');
    }
    _label = newLabel;
  }

  void updateOrigin(String? newOrigin) {
    if (newOrigin != null && !_isValidOrigin(newOrigin)) {
      throw ArgumentError(
        'Invalid origin format. Must be a valid BIP380 descriptor.',
      );
    }
    _origin = newOrigin;
  }

  bool _isValidOrigin(String origin) {
    // Basic validation for BIP380 descriptor format
    // Should contain key origin info with fingerprint and derivation path
    return origin.contains('[') && origin.contains(']');
  }

  // Abstract update methods
  void updateSpecificFields(Map<String, dynamic> updates);

  // Equality for exact matching
  bool isExactMatch(LabelEntity other);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabelEntity &&
          runtimeType == other.runtimeType &&
          ref == other.ref &&
          type == other.type &&
          label == other.label &&
          origin == other.origin;

  @override
  int get hashCode => Object.hash(runtimeType, ref, type, label, origin);
}

class TransactionLabelEntity extends LabelEntity {
  final String txId;
  int? _blockHeight;
  DateTime? _blockTime;
  int? _valueSat;
  int? _minerFeeSat;
  Map<String, double>? _exchangeRates;

  TransactionLabelEntity({
    required this.txId,
    super.label,
    super.origin,
    int? blockHeight,
    DateTime? blockTime,
    int? valueSat,
    int? minerFeeSat,
    Map<String, double>? exchangeRates,
  }) : _blockHeight = blockHeight,
       _blockTime = blockTime,
       _valueSat = valueSat,
       _minerFeeSat = minerFeeSat,
       _exchangeRates = exchangeRates;

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.transaction;

  @override
  String get ref => txId;

  // Getters
  int? get blockHeight => _blockHeight;
  DateTime? get blockTime => _blockTime;
  int? get valueSat => _valueSat;
  int? get minerFeeSat => _minerFeeSat;
  Map<String, double>? get exchangeRates => _exchangeRates;

  // Business methods
  void updateBlockInfo(int? height, DateTime? time) {
    if (height != null && height < 0) {
      throw ArgumentError('Block height cannot be negative');
    }
    _blockHeight = height;
    _blockTime = time;
  }

  void updateValue(int? valueSat, int? minerFeeSat) {
    if (valueSat != null && valueSat < 0) {
      throw ArgumentError('Value cannot be negative');
    }
    if (minerFeeSat != null && minerFeeSat < 0) {
      throw ArgumentError('Miner fee cannot be negative');
    }
    _valueSat = valueSat;
    _minerFeeSat = minerFeeSat;
  }

  void updateExchangeRates(Map<String, double>? rates) {
    _exchangeRates = rates;
  }

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    if (updates.containsKey('blockHeight') ||
        updates.containsKey('blockTime')) {
      updateBlockInfo(updates['blockHeight'], updates['blockTime']);
    }
    if (updates.containsKey('valueSat') || updates.containsKey('minerFeeSat')) {
      updateValue(
        updates['valueSat'] ?? _valueSat,
        updates['minerFeeSat'] ?? _minerFeeSat,
      );
    }
    if (updates['exchangeRates'] != null) {
      updateExchangeRates(updates['exchangeRates']);
    }
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is TransactionLabelEntity &&
        super == other;
        // TODO: Add type-specific field checks when BIP329 type-specific fields are implemented
        // blockHeight == other.blockHeight &&
        // blockTime == other.blockTime &&
        // valueSat == other.valueSat &&
        // minerFeeSat == other.minerFeeSat &&
        // _mapEquals(exchangeRates, other.exchangeRates);
  }
}

class AddressLabelEntity extends LabelEntity {
  final String address;
  String? _keyPath;
  List<int> _heights;

  AddressLabelEntity({
    required this.address,
    super.label,
    super.origin,
    String? keyPath,
    List<int>? heights,
  }) : _keyPath = keyPath,
       _heights = heights ?? [];

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.address;

  @override
  String get ref => address;

  // Getters
  String? get keyPath => _keyPath;
  List<int> get heights => List.unmodifiable(_heights);

  // Business methods
  void updateKeyPath(String? newKeyPath) {
    if (newKeyPath != null && !_isValidKeyPath(newKeyPath)) {
      throw ArgumentError('Invalid key path format');
    }
    _keyPath = newKeyPath;
  }

  void addHeight(int height) {
    if (height < 0) {
      throw ArgumentError('Height cannot be negative');
    }
    if (!_heights.contains(height)) {
      _heights.add(height);
      _heights.sort();
    }
  }

  void removeHeight(int height) {
    _heights.remove(height);
  }

  void updateHeights(List<int> newHeights) {
    if (newHeights.any((h) => h < 0)) {
      throw ArgumentError('Heights cannot be negative');
    }
    _heights = List.from(newHeights)..sort();
  }

  bool _isValidKeyPath(String keyPath) {
    // Basic validation for BIP32 key path
    return keyPath.contains('/') || keyPath == 'm';
  }

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    if (updates['keyPath'] != null) {
      updateKeyPath(updates['keyPath']);
    }
    if (updates['heights'] != null) {
      updateHeights(List<int>.from(updates['heights']));
    }
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is AddressLabelEntity &&
        super == other;
        // TODO: Add type-specific field checks when BIP329 type-specific fields are implemented
        // keyPath == other.keyPath &&
        // _listEquals(heights, other.heights);
  }
}

class PubkeyLabelEntity extends LabelEntity {
  final String publicKey;

  PubkeyLabelEntity({required this.publicKey, super.label, super.origin});

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.pubkey;

  @override
  String get ref => publicKey;

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    // No specific fields for pubkey labels
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is PubkeyLabelEntity && super == other;
  }
}

class InputLabelEntity extends LabelEntity {
  final String txId;
  final int index;
  String? _keyPath;
  int? _valueSat;
  Map<String, double>? _fairMarketValue;
  int? _blockHeight;
  DateTime? _blockTime;

  InputLabelEntity({
    required this.txId,
    required this.index,
    super.label,
    super.origin,
    String? keyPath,
    int? valueSat,
    Map<String, double>? fairMarketValue,
    int? blockHeight,
    DateTime? blockTime,
  }) : _keyPath = keyPath,
       _valueSat = valueSat,
       _fairMarketValue = fairMarketValue,
       _blockHeight = blockHeight,
       _blockTime = blockTime {
    if (index < 0) {
      throw ArgumentError('Input index cannot be negative');
    }
  }

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.input;

  @override
  String get ref => '$txId:$index';

  // Getters
  String? get keyPath => _keyPath;
  int? get valueSat => _valueSat;
  Map<String, double>? get fairMarketValue => _fairMarketValue;
  int? get blockHeight => _blockHeight;
  DateTime? get blockTime => _blockTime;

  // Business methods
  void updateKeyPath(String? newKeyPath) {
    if (newKeyPath != null && !_isValidKeyPath(newKeyPath)) {
      throw ArgumentError('Invalid key path format');
    }
    _keyPath = newKeyPath;
  }

  void updateValue(int? valueSat) {
    if (valueSat != null && valueSat < 0) {
      throw ArgumentError('Value cannot be negative');
    }
    _valueSat = valueSat;
  }

  void updateFairMarketValue(Map<String, double>? fmv) {
    _fairMarketValue = fmv;
  }

  void updateBlockInfo(int? height, DateTime? time) {
    if (height != null && height < 0) {
      throw ArgumentError('Block height cannot be negative');
    }
    _blockHeight = height;
    _blockTime = time;
  }

  bool _isValidKeyPath(String keyPath) {
    return keyPath.contains('/') || keyPath == 'm';
  }

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    if (updates['keyPath'] != null) {
      updateKeyPath(updates['keyPath']);
    }
    if (updates['valueSat'] != null) {
      updateValue(updates['valueSat']);
    }
    if (updates['fairMarketValue'] != null) {
      updateFairMarketValue(updates['fairMarketValue']);
    }
    if (updates.containsKey('blockHeight') ||
        updates.containsKey('blockTime')) {
      updateBlockInfo(updates['blockHeight'], updates['blockTime']);
    }
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is InputLabelEntity &&
        super == other;
        // TODO: Add type-specific field checks when BIP329 type-specific fields are implemented
        // keyPath == other.keyPath &&
        // valueSat == other.valueSat &&
        // _mapEquals(fairMarketValue, other.fairMarketValue) &&
        // blockHeight == other.blockHeight &&
        // blockTime == other.blockTime;
  }
}

class OutputLabelEntity extends LabelEntity {
  final String txId;
  final int index;
  String? _keyPath;
  bool? _spendable;
  int? _valueSat;
  Map<String, double>? _fairMarketValue;
  int? _blockHeight;
  DateTime? _blockTime;

  OutputLabelEntity({
    required this.txId,
    required this.index,
    super.label,
    super.origin,
    String? keyPath,
    bool? spendable,
    int? valueSat,
    Map<String, double>? fairMarketValue,
    int? blockHeight,
    DateTime? blockTime,
  }) : _keyPath = keyPath,
       _spendable = spendable,
       _valueSat = valueSat,
       _fairMarketValue = fairMarketValue,
       _blockHeight = blockHeight,
       _blockTime = blockTime {
    if (index < 0) {
      throw ArgumentError('Output index cannot be negative');
    }
  }

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.output;

  @override
  String get ref => '$txId:$index';

  // Getters
  String? get keyPath => _keyPath;
  bool? get spendable => _spendable;
  int? get valueSat => _valueSat;
  Map<String, double>? get fairMarketValue => _fairMarketValue;
  int? get blockHeight => _blockHeight;
  DateTime? get blockTime => _blockTime;

  // Business methods
  void updateKeyPath(String? newKeyPath) {
    if (newKeyPath != null && !_isValidKeyPath(newKeyPath)) {
      throw ArgumentError('Invalid key path format');
    }
    _keyPath = newKeyPath;
  }

  void updateSpendable(bool? spendable) {
    _spendable = spendable;
  }

  void updateValue(int? valueSat) {
    if (valueSat != null && valueSat < 0) {
      throw ArgumentError('Value cannot be negative');
    }
    _valueSat = valueSat;
  }

  void updateFairMarketValue(Map<String, double>? fmv) {
    _fairMarketValue = fmv;
  }

  void updateBlockInfo(int? height, DateTime? time) {
    if (height != null && height < 0) {
      throw ArgumentError('Block height cannot be negative');
    }
    _blockHeight = height;
    _blockTime = time;
  }

  bool _isValidKeyPath(String keyPath) {
    return keyPath.contains('/') || keyPath == 'm';
  }

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    if (updates['keyPath'] != null) {
      updateKeyPath(updates['keyPath']);
    }
    if (updates['spendable'] != null) {
      updateSpendable(updates['spendable']);
    }
    if (updates['valueSat'] != null) {
      updateValue(updates['valueSat']);
    }
    if (updates['fairMarketValue'] != null) {
      updateFairMarketValue(updates['fairMarketValue']);
    }
    if (updates.containsKey('blockHeight') ||
        updates.containsKey('blockTime')) {
      updateBlockInfo(updates['blockHeight'], updates['blockTime']);
    }
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is OutputLabelEntity &&
        super == other &&
        spendable == other.spendable; // spendable is a base BIP329 field for outputs
        // TODO: Add type-specific field checks when BIP329 type-specific fields are implemented
        // keyPath == other.keyPath &&
        // valueSat == other.valueSat &&
        // _mapEquals(fairMarketValue, other.fairMarketValue) &&
        // blockHeight == other.blockHeight &&
        // blockTime == other.blockTime;
  }
}

class XpubLabelEntity extends LabelEntity {
  final String xpub;
  String? _keyPath;

  XpubLabelEntity({
    required this.xpub,
    super.label,
    super.origin,
    String? keyPath,
  }) : _keyPath = keyPath;

  @override
  LabelTypeValueObject get type => LabelTypeValueObject.xpub;

  @override
  String get ref => xpub;

  // Getters
  String? get keyPath => _keyPath;

  // Business methods
  void updateKeyPath(String? newKeyPath) {
    if (newKeyPath != null && !_isValidKeyPath(newKeyPath)) {
      throw ArgumentError('Invalid key path format');
    }
    _keyPath = newKeyPath;
  }

  bool _isValidKeyPath(String keyPath) {
    return keyPath.contains('/') || keyPath == 'm';
  }

  @override
  void updateSpecificFields(Map<String, dynamic> updates) {
    if (updates['keyPath'] != null) {
      updateKeyPath(updates['keyPath']);
    }
  }

  @override
  bool isExactMatch(LabelEntity other) {
    return other is XpubLabelEntity &&
        super == other;
        // TODO: Add type-specific field checks when BIP329 type-specific fields are implemented
        // keyPath == other.keyPath;
  }
}

