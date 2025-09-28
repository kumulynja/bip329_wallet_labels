// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labels_database.dart';

// ignore_for_file: type=lint
class $EncryptedLabelsTable extends EncryptedLabels
    with TableInfo<$EncryptedLabelsTable, EncryptedLabel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EncryptedLabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nonceMeta = const VerificationMeta('nonce');
  @override
  late final GeneratedColumn<Uint8List> nonce = GeneratedColumn<Uint8List>(
    'nonce',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ciphertextMeta = const VerificationMeta(
    'ciphertext',
  );
  @override
  late final GeneratedColumn<Uint8List> ciphertext = GeneratedColumn<Uint8List>(
    'ciphertext',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _macMeta = const VerificationMeta('mac');
  @override
  late final GeneratedColumn<Uint8List> mac = GeneratedColumn<Uint8List>(
    'mac',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idxOriginMeta = const VerificationMeta(
    'idxOrigin',
  );
  @override
  late final GeneratedColumn<Uint8List> idxOrigin = GeneratedColumn<Uint8List>(
    'idx_origin',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idxTypeMeta = const VerificationMeta(
    'idxType',
  );
  @override
  late final GeneratedColumn<Uint8List> idxType = GeneratedColumn<Uint8List>(
    'idx_type',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idxRefMeta = const VerificationMeta('idxRef');
  @override
  late final GeneratedColumn<Uint8List> idxRef = GeneratedColumn<Uint8List>(
    'idx_ref',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idxLabelFullMeta = const VerificationMeta(
    'idxLabelFull',
  );
  @override
  late final GeneratedColumn<Uint8List> idxLabelFull =
      GeneratedColumn<Uint8List>(
        'idx_label_full',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _keyVersionMeta = const VerificationMeta(
    'keyVersion',
  );
  @override
  late final GeneratedColumn<int> keyVersion = GeneratedColumn<int>(
    'key_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _algoMeta = const VerificationMeta('algo');
  @override
  late final GeneratedColumn<String> algo = GeneratedColumn<String>(
    'algo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('xchacha20poly1305'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nonce,
    ciphertext,
    mac,
    idxOrigin,
    idxType,
    idxRef,
    idxLabelFull,
    version,
    keyVersion,
    algo,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'encrypted_labels';
  @override
  VerificationContext validateIntegrity(
    Insertable<EncryptedLabel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nonce')) {
      context.handle(
        _nonceMeta,
        nonce.isAcceptableOrUnknown(data['nonce']!, _nonceMeta),
      );
    } else if (isInserting) {
      context.missing(_nonceMeta);
    }
    if (data.containsKey('ciphertext')) {
      context.handle(
        _ciphertextMeta,
        ciphertext.isAcceptableOrUnknown(data['ciphertext']!, _ciphertextMeta),
      );
    } else if (isInserting) {
      context.missing(_ciphertextMeta);
    }
    if (data.containsKey('mac')) {
      context.handle(
        _macMeta,
        mac.isAcceptableOrUnknown(data['mac']!, _macMeta),
      );
    } else if (isInserting) {
      context.missing(_macMeta);
    }
    if (data.containsKey('idx_origin')) {
      context.handle(
        _idxOriginMeta,
        idxOrigin.isAcceptableOrUnknown(data['idx_origin']!, _idxOriginMeta),
      );
    }
    if (data.containsKey('idx_type')) {
      context.handle(
        _idxTypeMeta,
        idxType.isAcceptableOrUnknown(data['idx_type']!, _idxTypeMeta),
      );
    }
    if (data.containsKey('idx_ref')) {
      context.handle(
        _idxRefMeta,
        idxRef.isAcceptableOrUnknown(data['idx_ref']!, _idxRefMeta),
      );
    }
    if (data.containsKey('idx_label_full')) {
      context.handle(
        _idxLabelFullMeta,
        idxLabelFull.isAcceptableOrUnknown(
          data['idx_label_full']!,
          _idxLabelFullMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('key_version')) {
      context.handle(
        _keyVersionMeta,
        keyVersion.isAcceptableOrUnknown(data['key_version']!, _keyVersionMeta),
      );
    }
    if (data.containsKey('algo')) {
      context.handle(
        _algoMeta,
        algo.isAcceptableOrUnknown(data['algo']!, _algoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EncryptedLabel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EncryptedLabel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      nonce:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}nonce'],
          )!,
      ciphertext:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}ciphertext'],
          )!,
      mac:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}mac'],
          )!,
      idxOrigin: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}idx_origin'],
      ),
      idxType: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}idx_type'],
      ),
      idxRef: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}idx_ref'],
      ),
      idxLabelFull: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}idx_label_full'],
      ),
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}version'],
          )!,
      keyVersion:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}key_version'],
          )!,
      algo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}algo'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $EncryptedLabelsTable createAlias(String alias) {
    return $EncryptedLabelsTable(attachedDatabase, alias);
  }
}

class EncryptedLabel extends DataClass implements Insertable<EncryptedLabel> {
  final String id;
  final Uint8List nonce;
  final Uint8List ciphertext;
  final Uint8List mac;
  final Uint8List? idxOrigin;
  final Uint8List? idxType;
  final Uint8List? idxRef;
  final Uint8List? idxLabelFull;
  final int version;
  final int keyVersion;
  final String algo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EncryptedLabel({
    required this.id,
    required this.nonce,
    required this.ciphertext,
    required this.mac,
    this.idxOrigin,
    this.idxType,
    this.idxRef,
    this.idxLabelFull,
    required this.version,
    required this.keyVersion,
    required this.algo,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nonce'] = Variable<Uint8List>(nonce);
    map['ciphertext'] = Variable<Uint8List>(ciphertext);
    map['mac'] = Variable<Uint8List>(mac);
    if (!nullToAbsent || idxOrigin != null) {
      map['idx_origin'] = Variable<Uint8List>(idxOrigin);
    }
    if (!nullToAbsent || idxType != null) {
      map['idx_type'] = Variable<Uint8List>(idxType);
    }
    if (!nullToAbsent || idxRef != null) {
      map['idx_ref'] = Variable<Uint8List>(idxRef);
    }
    if (!nullToAbsent || idxLabelFull != null) {
      map['idx_label_full'] = Variable<Uint8List>(idxLabelFull);
    }
    map['version'] = Variable<int>(version);
    map['key_version'] = Variable<int>(keyVersion);
    map['algo'] = Variable<String>(algo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EncryptedLabelsCompanion toCompanion(bool nullToAbsent) {
    return EncryptedLabelsCompanion(
      id: Value(id),
      nonce: Value(nonce),
      ciphertext: Value(ciphertext),
      mac: Value(mac),
      idxOrigin:
          idxOrigin == null && nullToAbsent
              ? const Value.absent()
              : Value(idxOrigin),
      idxType:
          idxType == null && nullToAbsent
              ? const Value.absent()
              : Value(idxType),
      idxRef:
          idxRef == null && nullToAbsent ? const Value.absent() : Value(idxRef),
      idxLabelFull:
          idxLabelFull == null && nullToAbsent
              ? const Value.absent()
              : Value(idxLabelFull),
      version: Value(version),
      keyVersion: Value(keyVersion),
      algo: Value(algo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EncryptedLabel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EncryptedLabel(
      id: serializer.fromJson<String>(json['id']),
      nonce: serializer.fromJson<Uint8List>(json['nonce']),
      ciphertext: serializer.fromJson<Uint8List>(json['ciphertext']),
      mac: serializer.fromJson<Uint8List>(json['mac']),
      idxOrigin: serializer.fromJson<Uint8List?>(json['idxOrigin']),
      idxType: serializer.fromJson<Uint8List?>(json['idxType']),
      idxRef: serializer.fromJson<Uint8List?>(json['idxRef']),
      idxLabelFull: serializer.fromJson<Uint8List?>(json['idxLabelFull']),
      version: serializer.fromJson<int>(json['version']),
      keyVersion: serializer.fromJson<int>(json['keyVersion']),
      algo: serializer.fromJson<String>(json['algo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nonce': serializer.toJson<Uint8List>(nonce),
      'ciphertext': serializer.toJson<Uint8List>(ciphertext),
      'mac': serializer.toJson<Uint8List>(mac),
      'idxOrigin': serializer.toJson<Uint8List?>(idxOrigin),
      'idxType': serializer.toJson<Uint8List?>(idxType),
      'idxRef': serializer.toJson<Uint8List?>(idxRef),
      'idxLabelFull': serializer.toJson<Uint8List?>(idxLabelFull),
      'version': serializer.toJson<int>(version),
      'keyVersion': serializer.toJson<int>(keyVersion),
      'algo': serializer.toJson<String>(algo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EncryptedLabel copyWith({
    String? id,
    Uint8List? nonce,
    Uint8List? ciphertext,
    Uint8List? mac,
    Value<Uint8List?> idxOrigin = const Value.absent(),
    Value<Uint8List?> idxType = const Value.absent(),
    Value<Uint8List?> idxRef = const Value.absent(),
    Value<Uint8List?> idxLabelFull = const Value.absent(),
    int? version,
    int? keyVersion,
    String? algo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EncryptedLabel(
    id: id ?? this.id,
    nonce: nonce ?? this.nonce,
    ciphertext: ciphertext ?? this.ciphertext,
    mac: mac ?? this.mac,
    idxOrigin: idxOrigin.present ? idxOrigin.value : this.idxOrigin,
    idxType: idxType.present ? idxType.value : this.idxType,
    idxRef: idxRef.present ? idxRef.value : this.idxRef,
    idxLabelFull: idxLabelFull.present ? idxLabelFull.value : this.idxLabelFull,
    version: version ?? this.version,
    keyVersion: keyVersion ?? this.keyVersion,
    algo: algo ?? this.algo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EncryptedLabel copyWithCompanion(EncryptedLabelsCompanion data) {
    return EncryptedLabel(
      id: data.id.present ? data.id.value : this.id,
      nonce: data.nonce.present ? data.nonce.value : this.nonce,
      ciphertext:
          data.ciphertext.present ? data.ciphertext.value : this.ciphertext,
      mac: data.mac.present ? data.mac.value : this.mac,
      idxOrigin: data.idxOrigin.present ? data.idxOrigin.value : this.idxOrigin,
      idxType: data.idxType.present ? data.idxType.value : this.idxType,
      idxRef: data.idxRef.present ? data.idxRef.value : this.idxRef,
      idxLabelFull:
          data.idxLabelFull.present
              ? data.idxLabelFull.value
              : this.idxLabelFull,
      version: data.version.present ? data.version.value : this.version,
      keyVersion:
          data.keyVersion.present ? data.keyVersion.value : this.keyVersion,
      algo: data.algo.present ? data.algo.value : this.algo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EncryptedLabel(')
          ..write('id: $id, ')
          ..write('nonce: $nonce, ')
          ..write('ciphertext: $ciphertext, ')
          ..write('mac: $mac, ')
          ..write('idxOrigin: $idxOrigin, ')
          ..write('idxType: $idxType, ')
          ..write('idxRef: $idxRef, ')
          ..write('idxLabelFull: $idxLabelFull, ')
          ..write('version: $version, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('algo: $algo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    $driftBlobEquality.hash(nonce),
    $driftBlobEquality.hash(ciphertext),
    $driftBlobEquality.hash(mac),
    $driftBlobEquality.hash(idxOrigin),
    $driftBlobEquality.hash(idxType),
    $driftBlobEquality.hash(idxRef),
    $driftBlobEquality.hash(idxLabelFull),
    version,
    keyVersion,
    algo,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EncryptedLabel &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.nonce, this.nonce) &&
          $driftBlobEquality.equals(other.ciphertext, this.ciphertext) &&
          $driftBlobEquality.equals(other.mac, this.mac) &&
          $driftBlobEquality.equals(other.idxOrigin, this.idxOrigin) &&
          $driftBlobEquality.equals(other.idxType, this.idxType) &&
          $driftBlobEquality.equals(other.idxRef, this.idxRef) &&
          $driftBlobEquality.equals(other.idxLabelFull, this.idxLabelFull) &&
          other.version == this.version &&
          other.keyVersion == this.keyVersion &&
          other.algo == this.algo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EncryptedLabelsCompanion extends UpdateCompanion<EncryptedLabel> {
  final Value<String> id;
  final Value<Uint8List> nonce;
  final Value<Uint8List> ciphertext;
  final Value<Uint8List> mac;
  final Value<Uint8List?> idxOrigin;
  final Value<Uint8List?> idxType;
  final Value<Uint8List?> idxRef;
  final Value<Uint8List?> idxLabelFull;
  final Value<int> version;
  final Value<int> keyVersion;
  final Value<String> algo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EncryptedLabelsCompanion({
    this.id = const Value.absent(),
    this.nonce = const Value.absent(),
    this.ciphertext = const Value.absent(),
    this.mac = const Value.absent(),
    this.idxOrigin = const Value.absent(),
    this.idxType = const Value.absent(),
    this.idxRef = const Value.absent(),
    this.idxLabelFull = const Value.absent(),
    this.version = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.algo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EncryptedLabelsCompanion.insert({
    required String id,
    required Uint8List nonce,
    required Uint8List ciphertext,
    required Uint8List mac,
    this.idxOrigin = const Value.absent(),
    this.idxType = const Value.absent(),
    this.idxRef = const Value.absent(),
    this.idxLabelFull = const Value.absent(),
    this.version = const Value.absent(),
    this.keyVersion = const Value.absent(),
    this.algo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nonce = Value(nonce),
       ciphertext = Value(ciphertext),
       mac = Value(mac);
  static Insertable<EncryptedLabel> custom({
    Expression<String>? id,
    Expression<Uint8List>? nonce,
    Expression<Uint8List>? ciphertext,
    Expression<Uint8List>? mac,
    Expression<Uint8List>? idxOrigin,
    Expression<Uint8List>? idxType,
    Expression<Uint8List>? idxRef,
    Expression<Uint8List>? idxLabelFull,
    Expression<int>? version,
    Expression<int>? keyVersion,
    Expression<String>? algo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nonce != null) 'nonce': nonce,
      if (ciphertext != null) 'ciphertext': ciphertext,
      if (mac != null) 'mac': mac,
      if (idxOrigin != null) 'idx_origin': idxOrigin,
      if (idxType != null) 'idx_type': idxType,
      if (idxRef != null) 'idx_ref': idxRef,
      if (idxLabelFull != null) 'idx_label_full': idxLabelFull,
      if (version != null) 'version': version,
      if (keyVersion != null) 'key_version': keyVersion,
      if (algo != null) 'algo': algo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EncryptedLabelsCompanion copyWith({
    Value<String>? id,
    Value<Uint8List>? nonce,
    Value<Uint8List>? ciphertext,
    Value<Uint8List>? mac,
    Value<Uint8List?>? idxOrigin,
    Value<Uint8List?>? idxType,
    Value<Uint8List?>? idxRef,
    Value<Uint8List?>? idxLabelFull,
    Value<int>? version,
    Value<int>? keyVersion,
    Value<String>? algo,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EncryptedLabelsCompanion(
      id: id ?? this.id,
      nonce: nonce ?? this.nonce,
      ciphertext: ciphertext ?? this.ciphertext,
      mac: mac ?? this.mac,
      idxOrigin: idxOrigin ?? this.idxOrigin,
      idxType: idxType ?? this.idxType,
      idxRef: idxRef ?? this.idxRef,
      idxLabelFull: idxLabelFull ?? this.idxLabelFull,
      version: version ?? this.version,
      keyVersion: keyVersion ?? this.keyVersion,
      algo: algo ?? this.algo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nonce.present) {
      map['nonce'] = Variable<Uint8List>(nonce.value);
    }
    if (ciphertext.present) {
      map['ciphertext'] = Variable<Uint8List>(ciphertext.value);
    }
    if (mac.present) {
      map['mac'] = Variable<Uint8List>(mac.value);
    }
    if (idxOrigin.present) {
      map['idx_origin'] = Variable<Uint8List>(idxOrigin.value);
    }
    if (idxType.present) {
      map['idx_type'] = Variable<Uint8List>(idxType.value);
    }
    if (idxRef.present) {
      map['idx_ref'] = Variable<Uint8List>(idxRef.value);
    }
    if (idxLabelFull.present) {
      map['idx_label_full'] = Variable<Uint8List>(idxLabelFull.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (keyVersion.present) {
      map['key_version'] = Variable<int>(keyVersion.value);
    }
    if (algo.present) {
      map['algo'] = Variable<String>(algo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EncryptedLabelsCompanion(')
          ..write('id: $id, ')
          ..write('nonce: $nonce, ')
          ..write('ciphertext: $ciphertext, ')
          ..write('mac: $mac, ')
          ..write('idxOrigin: $idxOrigin, ')
          ..write('idxType: $idxType, ')
          ..write('idxRef: $idxRef, ')
          ..write('idxLabelFull: $idxLabelFull, ')
          ..write('version: $version, ')
          ..write('keyVersion: $keyVersion, ')
          ..write('algo: $algo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LabelTokensTable extends LabelTokens
    with TableInfo<$LabelTokensTable, LabelToken> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabelTokensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenHashMeta = const VerificationMeta(
    'tokenHash',
  );
  @override
  late final GeneratedColumn<Uint8List> tokenHash = GeneratedColumn<Uint8List>(
    'token_hash',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [labelId, tokenHash];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'label_tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabelToken> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('token_hash')) {
      context.handle(
        _tokenHashMeta,
        tokenHash.isAcceptableOrUnknown(data['token_hash']!, _tokenHashMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenHashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {labelId, tokenHash};
  @override
  LabelToken map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabelToken(
      labelId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label_id'],
          )!,
      tokenHash:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}token_hash'],
          )!,
    );
  }

  @override
  $LabelTokensTable createAlias(String alias) {
    return $LabelTokensTable(attachedDatabase, alias);
  }
}

class LabelToken extends DataClass implements Insertable<LabelToken> {
  final String labelId;
  final Uint8List tokenHash;
  const LabelToken({required this.labelId, required this.tokenHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['label_id'] = Variable<String>(labelId);
    map['token_hash'] = Variable<Uint8List>(tokenHash);
    return map;
  }

  LabelTokensCompanion toCompanion(bool nullToAbsent) {
    return LabelTokensCompanion(
      labelId: Value(labelId),
      tokenHash: Value(tokenHash),
    );
  }

  factory LabelToken.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabelToken(
      labelId: serializer.fromJson<String>(json['labelId']),
      tokenHash: serializer.fromJson<Uint8List>(json['tokenHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'labelId': serializer.toJson<String>(labelId),
      'tokenHash': serializer.toJson<Uint8List>(tokenHash),
    };
  }

  LabelToken copyWith({String? labelId, Uint8List? tokenHash}) => LabelToken(
    labelId: labelId ?? this.labelId,
    tokenHash: tokenHash ?? this.tokenHash,
  );
  LabelToken copyWithCompanion(LabelTokensCompanion data) {
    return LabelToken(
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      tokenHash: data.tokenHash.present ? data.tokenHash.value : this.tokenHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabelToken(')
          ..write('labelId: $labelId, ')
          ..write('tokenHash: $tokenHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(labelId, $driftBlobEquality.hash(tokenHash));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabelToken &&
          other.labelId == this.labelId &&
          $driftBlobEquality.equals(other.tokenHash, this.tokenHash));
}

class LabelTokensCompanion extends UpdateCompanion<LabelToken> {
  final Value<String> labelId;
  final Value<Uint8List> tokenHash;
  final Value<int> rowid;
  const LabelTokensCompanion({
    this.labelId = const Value.absent(),
    this.tokenHash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabelTokensCompanion.insert({
    required String labelId,
    required Uint8List tokenHash,
    this.rowid = const Value.absent(),
  }) : labelId = Value(labelId),
       tokenHash = Value(tokenHash);
  static Insertable<LabelToken> custom({
    Expression<String>? labelId,
    Expression<Uint8List>? tokenHash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (labelId != null) 'label_id': labelId,
      if (tokenHash != null) 'token_hash': tokenHash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabelTokensCompanion copyWith({
    Value<String>? labelId,
    Value<Uint8List>? tokenHash,
    Value<int>? rowid,
  }) {
    return LabelTokensCompanion(
      labelId: labelId ?? this.labelId,
      tokenHash: tokenHash ?? this.tokenHash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (tokenHash.present) {
      map['token_hash'] = Variable<Uint8List>(tokenHash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelTokensCompanion(')
          ..write('labelId: $labelId, ')
          ..write('tokenHash: $tokenHash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KeyringTable extends Keyring with TableInfo<$KeyringTable, KeyringData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyringTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kdfMeta = const VerificationMeta('kdf');
  @override
  late final GeneratedColumn<String> kdf = GeneratedColumn<String>(
    'kdf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pbkdf2-hmac-sha256'),
  );
  static const VerificationMeta _kdfSaltMeta = const VerificationMeta(
    'kdfSalt',
  );
  @override
  late final GeneratedColumn<Uint8List> kdfSalt = GeneratedColumn<Uint8List>(
    'kdf_salt',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kdfIterationsMeta = const VerificationMeta(
    'kdfIterations',
  );
  @override
  late final GeneratedColumn<int> kdfIterations = GeneratedColumn<int>(
    'kdf_iterations',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mekNonceMeta = const VerificationMeta(
    'mekNonce',
  );
  @override
  late final GeneratedColumn<Uint8List> mekNonce = GeneratedColumn<Uint8List>(
    'mek_nonce',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mekCiphertextMeta = const VerificationMeta(
    'mekCiphertext',
  );
  @override
  late final GeneratedColumn<Uint8List> mekCiphertext =
      GeneratedColumn<Uint8List>(
        'mek_ciphertext',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _mekMacMeta = const VerificationMeta('mekMac');
  @override
  late final GeneratedColumn<Uint8List> mekMac = GeneratedColumn<Uint8List>(
    'mek_mac',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kdf,
    kdfSalt,
    kdfIterations,
    mekNonce,
    mekCiphertext,
    mekMac,
    version,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'keyring';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyringData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kdf')) {
      context.handle(
        _kdfMeta,
        kdf.isAcceptableOrUnknown(data['kdf']!, _kdfMeta),
      );
    }
    if (data.containsKey('kdf_salt')) {
      context.handle(
        _kdfSaltMeta,
        kdfSalt.isAcceptableOrUnknown(data['kdf_salt']!, _kdfSaltMeta),
      );
    } else if (isInserting) {
      context.missing(_kdfSaltMeta);
    }
    if (data.containsKey('kdf_iterations')) {
      context.handle(
        _kdfIterationsMeta,
        kdfIterations.isAcceptableOrUnknown(
          data['kdf_iterations']!,
          _kdfIterationsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kdfIterationsMeta);
    }
    if (data.containsKey('mek_nonce')) {
      context.handle(
        _mekNonceMeta,
        mekNonce.isAcceptableOrUnknown(data['mek_nonce']!, _mekNonceMeta),
      );
    } else if (isInserting) {
      context.missing(_mekNonceMeta);
    }
    if (data.containsKey('mek_ciphertext')) {
      context.handle(
        _mekCiphertextMeta,
        mekCiphertext.isAcceptableOrUnknown(
          data['mek_ciphertext']!,
          _mekCiphertextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mekCiphertextMeta);
    }
    if (data.containsKey('mek_mac')) {
      context.handle(
        _mekMacMeta,
        mekMac.isAcceptableOrUnknown(data['mek_mac']!, _mekMacMeta),
      );
    } else if (isInserting) {
      context.missing(_mekMacMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KeyringData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyringData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      kdf:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}kdf'],
          )!,
      kdfSalt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}kdf_salt'],
          )!,
      kdfIterations:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}kdf_iterations'],
          )!,
      mekNonce:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}mek_nonce'],
          )!,
      mekCiphertext:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}mek_ciphertext'],
          )!,
      mekMac:
          attachedDatabase.typeMapping.read(
            DriftSqlType.blob,
            data['${effectivePrefix}mek_mac'],
          )!,
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}version'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $KeyringTable createAlias(String alias) {
    return $KeyringTable(attachedDatabase, alias);
  }
}

class KeyringData extends DataClass implements Insertable<KeyringData> {
  final String id;
  final String kdf;
  final Uint8List kdfSalt;
  final int kdfIterations;
  final Uint8List mekNonce;
  final Uint8List mekCiphertext;
  final Uint8List mekMac;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;
  const KeyringData({
    required this.id,
    required this.kdf,
    required this.kdfSalt,
    required this.kdfIterations,
    required this.mekNonce,
    required this.mekCiphertext,
    required this.mekMac,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kdf'] = Variable<String>(kdf);
    map['kdf_salt'] = Variable<Uint8List>(kdfSalt);
    map['kdf_iterations'] = Variable<int>(kdfIterations);
    map['mek_nonce'] = Variable<Uint8List>(mekNonce);
    map['mek_ciphertext'] = Variable<Uint8List>(mekCiphertext);
    map['mek_mac'] = Variable<Uint8List>(mekMac);
    map['version'] = Variable<int>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  KeyringCompanion toCompanion(bool nullToAbsent) {
    return KeyringCompanion(
      id: Value(id),
      kdf: Value(kdf),
      kdfSalt: Value(kdfSalt),
      kdfIterations: Value(kdfIterations),
      mekNonce: Value(mekNonce),
      mekCiphertext: Value(mekCiphertext),
      mekMac: Value(mekMac),
      version: Value(version),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KeyringData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyringData(
      id: serializer.fromJson<String>(json['id']),
      kdf: serializer.fromJson<String>(json['kdf']),
      kdfSalt: serializer.fromJson<Uint8List>(json['kdfSalt']),
      kdfIterations: serializer.fromJson<int>(json['kdfIterations']),
      mekNonce: serializer.fromJson<Uint8List>(json['mekNonce']),
      mekCiphertext: serializer.fromJson<Uint8List>(json['mekCiphertext']),
      mekMac: serializer.fromJson<Uint8List>(json['mekMac']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kdf': serializer.toJson<String>(kdf),
      'kdfSalt': serializer.toJson<Uint8List>(kdfSalt),
      'kdfIterations': serializer.toJson<int>(kdfIterations),
      'mekNonce': serializer.toJson<Uint8List>(mekNonce),
      'mekCiphertext': serializer.toJson<Uint8List>(mekCiphertext),
      'mekMac': serializer.toJson<Uint8List>(mekMac),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  KeyringData copyWith({
    String? id,
    String? kdf,
    Uint8List? kdfSalt,
    int? kdfIterations,
    Uint8List? mekNonce,
    Uint8List? mekCiphertext,
    Uint8List? mekMac,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => KeyringData(
    id: id ?? this.id,
    kdf: kdf ?? this.kdf,
    kdfSalt: kdfSalt ?? this.kdfSalt,
    kdfIterations: kdfIterations ?? this.kdfIterations,
    mekNonce: mekNonce ?? this.mekNonce,
    mekCiphertext: mekCiphertext ?? this.mekCiphertext,
    mekMac: mekMac ?? this.mekMac,
    version: version ?? this.version,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  KeyringData copyWithCompanion(KeyringCompanion data) {
    return KeyringData(
      id: data.id.present ? data.id.value : this.id,
      kdf: data.kdf.present ? data.kdf.value : this.kdf,
      kdfSalt: data.kdfSalt.present ? data.kdfSalt.value : this.kdfSalt,
      kdfIterations:
          data.kdfIterations.present
              ? data.kdfIterations.value
              : this.kdfIterations,
      mekNonce: data.mekNonce.present ? data.mekNonce.value : this.mekNonce,
      mekCiphertext:
          data.mekCiphertext.present
              ? data.mekCiphertext.value
              : this.mekCiphertext,
      mekMac: data.mekMac.present ? data.mekMac.value : this.mekMac,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyringData(')
          ..write('id: $id, ')
          ..write('kdf: $kdf, ')
          ..write('kdfSalt: $kdfSalt, ')
          ..write('kdfIterations: $kdfIterations, ')
          ..write('mekNonce: $mekNonce, ')
          ..write('mekCiphertext: $mekCiphertext, ')
          ..write('mekMac: $mekMac, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kdf,
    $driftBlobEquality.hash(kdfSalt),
    kdfIterations,
    $driftBlobEquality.hash(mekNonce),
    $driftBlobEquality.hash(mekCiphertext),
    $driftBlobEquality.hash(mekMac),
    version,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyringData &&
          other.id == this.id &&
          other.kdf == this.kdf &&
          $driftBlobEquality.equals(other.kdfSalt, this.kdfSalt) &&
          other.kdfIterations == this.kdfIterations &&
          $driftBlobEquality.equals(other.mekNonce, this.mekNonce) &&
          $driftBlobEquality.equals(other.mekCiphertext, this.mekCiphertext) &&
          $driftBlobEquality.equals(other.mekMac, this.mekMac) &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KeyringCompanion extends UpdateCompanion<KeyringData> {
  final Value<String> id;
  final Value<String> kdf;
  final Value<Uint8List> kdfSalt;
  final Value<int> kdfIterations;
  final Value<Uint8List> mekNonce;
  final Value<Uint8List> mekCiphertext;
  final Value<Uint8List> mekMac;
  final Value<int> version;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const KeyringCompanion({
    this.id = const Value.absent(),
    this.kdf = const Value.absent(),
    this.kdfSalt = const Value.absent(),
    this.kdfIterations = const Value.absent(),
    this.mekNonce = const Value.absent(),
    this.mekCiphertext = const Value.absent(),
    this.mekMac = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyringCompanion.insert({
    required String id,
    this.kdf = const Value.absent(),
    required Uint8List kdfSalt,
    required int kdfIterations,
    required Uint8List mekNonce,
    required Uint8List mekCiphertext,
    required Uint8List mekMac,
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kdfSalt = Value(kdfSalt),
       kdfIterations = Value(kdfIterations),
       mekNonce = Value(mekNonce),
       mekCiphertext = Value(mekCiphertext),
       mekMac = Value(mekMac);
  static Insertable<KeyringData> custom({
    Expression<String>? id,
    Expression<String>? kdf,
    Expression<Uint8List>? kdfSalt,
    Expression<int>? kdfIterations,
    Expression<Uint8List>? mekNonce,
    Expression<Uint8List>? mekCiphertext,
    Expression<Uint8List>? mekMac,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kdf != null) 'kdf': kdf,
      if (kdfSalt != null) 'kdf_salt': kdfSalt,
      if (kdfIterations != null) 'kdf_iterations': kdfIterations,
      if (mekNonce != null) 'mek_nonce': mekNonce,
      if (mekCiphertext != null) 'mek_ciphertext': mekCiphertext,
      if (mekMac != null) 'mek_mac': mekMac,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyringCompanion copyWith({
    Value<String>? id,
    Value<String>? kdf,
    Value<Uint8List>? kdfSalt,
    Value<int>? kdfIterations,
    Value<Uint8List>? mekNonce,
    Value<Uint8List>? mekCiphertext,
    Value<Uint8List>? mekMac,
    Value<int>? version,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return KeyringCompanion(
      id: id ?? this.id,
      kdf: kdf ?? this.kdf,
      kdfSalt: kdfSalt ?? this.kdfSalt,
      kdfIterations: kdfIterations ?? this.kdfIterations,
      mekNonce: mekNonce ?? this.mekNonce,
      mekCiphertext: mekCiphertext ?? this.mekCiphertext,
      mekMac: mekMac ?? this.mekMac,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kdf.present) {
      map['kdf'] = Variable<String>(kdf.value);
    }
    if (kdfSalt.present) {
      map['kdf_salt'] = Variable<Uint8List>(kdfSalt.value);
    }
    if (kdfIterations.present) {
      map['kdf_iterations'] = Variable<int>(kdfIterations.value);
    }
    if (mekNonce.present) {
      map['mek_nonce'] = Variable<Uint8List>(mekNonce.value);
    }
    if (mekCiphertext.present) {
      map['mek_ciphertext'] = Variable<Uint8List>(mekCiphertext.value);
    }
    if (mekMac.present) {
      map['mek_mac'] = Variable<Uint8List>(mekMac.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyringCompanion(')
          ..write('id: $id, ')
          ..write('kdf: $kdf, ')
          ..write('kdfSalt: $kdfSalt, ')
          ..write('kdfIterations: $kdfIterations, ')
          ..write('mekNonce: $mekNonce, ')
          ..write('mekCiphertext: $mekCiphertext, ')
          ..write('mekMac: $mekMac, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LabelsDatabase extends GeneratedDatabase {
  _$LabelsDatabase(QueryExecutor e) : super(e);
  $LabelsDatabaseManager get managers => $LabelsDatabaseManager(this);
  late final $EncryptedLabelsTable encryptedLabels = $EncryptedLabelsTable(
    this,
  );
  late final $LabelTokensTable labelTokens = $LabelTokensTable(this);
  late final $KeyringTable keyring = $KeyringTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    encryptedLabels,
    labelTokens,
    keyring,
  ];
}

typedef $$EncryptedLabelsTableCreateCompanionBuilder =
    EncryptedLabelsCompanion Function({
      required String id,
      required Uint8List nonce,
      required Uint8List ciphertext,
      required Uint8List mac,
      Value<Uint8List?> idxOrigin,
      Value<Uint8List?> idxType,
      Value<Uint8List?> idxRef,
      Value<Uint8List?> idxLabelFull,
      Value<int> version,
      Value<int> keyVersion,
      Value<String> algo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$EncryptedLabelsTableUpdateCompanionBuilder =
    EncryptedLabelsCompanion Function({
      Value<String> id,
      Value<Uint8List> nonce,
      Value<Uint8List> ciphertext,
      Value<Uint8List> mac,
      Value<Uint8List?> idxOrigin,
      Value<Uint8List?> idxType,
      Value<Uint8List?> idxRef,
      Value<Uint8List?> idxLabelFull,
      Value<int> version,
      Value<int> keyVersion,
      Value<String> algo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EncryptedLabelsTableFilterComposer
    extends Composer<_$LabelsDatabase, $EncryptedLabelsTable> {
  $$EncryptedLabelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get ciphertext => $composableBuilder(
    column: $table.ciphertext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get mac => $composableBuilder(
    column: $table.mac,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get idxOrigin => $composableBuilder(
    column: $table.idxOrigin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get idxType => $composableBuilder(
    column: $table.idxType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get idxRef => $composableBuilder(
    column: $table.idxRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get idxLabelFull => $composableBuilder(
    column: $table.idxLabelFull,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algo => $composableBuilder(
    column: $table.algo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EncryptedLabelsTableOrderingComposer
    extends Composer<_$LabelsDatabase, $EncryptedLabelsTable> {
  $$EncryptedLabelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get ciphertext => $composableBuilder(
    column: $table.ciphertext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get mac => $composableBuilder(
    column: $table.mac,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get idxOrigin => $composableBuilder(
    column: $table.idxOrigin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get idxType => $composableBuilder(
    column: $table.idxType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get idxRef => $composableBuilder(
    column: $table.idxRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get idxLabelFull => $composableBuilder(
    column: $table.idxLabelFull,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algo => $composableBuilder(
    column: $table.algo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EncryptedLabelsTableAnnotationComposer
    extends Composer<_$LabelsDatabase, $EncryptedLabelsTable> {
  $$EncryptedLabelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get nonce =>
      $composableBuilder(column: $table.nonce, builder: (column) => column);

  GeneratedColumn<Uint8List> get ciphertext => $composableBuilder(
    column: $table.ciphertext,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get mac =>
      $composableBuilder(column: $table.mac, builder: (column) => column);

  GeneratedColumn<Uint8List> get idxOrigin =>
      $composableBuilder(column: $table.idxOrigin, builder: (column) => column);

  GeneratedColumn<Uint8List> get idxType =>
      $composableBuilder(column: $table.idxType, builder: (column) => column);

  GeneratedColumn<Uint8List> get idxRef =>
      $composableBuilder(column: $table.idxRef, builder: (column) => column);

  GeneratedColumn<Uint8List> get idxLabelFull => $composableBuilder(
    column: $table.idxLabelFull,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<int> get keyVersion => $composableBuilder(
    column: $table.keyVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get algo =>
      $composableBuilder(column: $table.algo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EncryptedLabelsTableTableManager
    extends
        RootTableManager<
          _$LabelsDatabase,
          $EncryptedLabelsTable,
          EncryptedLabel,
          $$EncryptedLabelsTableFilterComposer,
          $$EncryptedLabelsTableOrderingComposer,
          $$EncryptedLabelsTableAnnotationComposer,
          $$EncryptedLabelsTableCreateCompanionBuilder,
          $$EncryptedLabelsTableUpdateCompanionBuilder,
          (
            EncryptedLabel,
            BaseReferences<
              _$LabelsDatabase,
              $EncryptedLabelsTable,
              EncryptedLabel
            >,
          ),
          EncryptedLabel,
          PrefetchHooks Function()
        > {
  $$EncryptedLabelsTableTableManager(
    _$LabelsDatabase db,
    $EncryptedLabelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$EncryptedLabelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EncryptedLabelsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EncryptedLabelsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Uint8List> nonce = const Value.absent(),
                Value<Uint8List> ciphertext = const Value.absent(),
                Value<Uint8List> mac = const Value.absent(),
                Value<Uint8List?> idxOrigin = const Value.absent(),
                Value<Uint8List?> idxType = const Value.absent(),
                Value<Uint8List?> idxRef = const Value.absent(),
                Value<Uint8List?> idxLabelFull = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> algo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EncryptedLabelsCompanion(
                id: id,
                nonce: nonce,
                ciphertext: ciphertext,
                mac: mac,
                idxOrigin: idxOrigin,
                idxType: idxType,
                idxRef: idxRef,
                idxLabelFull: idxLabelFull,
                version: version,
                keyVersion: keyVersion,
                algo: algo,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Uint8List nonce,
                required Uint8List ciphertext,
                required Uint8List mac,
                Value<Uint8List?> idxOrigin = const Value.absent(),
                Value<Uint8List?> idxType = const Value.absent(),
                Value<Uint8List?> idxRef = const Value.absent(),
                Value<Uint8List?> idxLabelFull = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> keyVersion = const Value.absent(),
                Value<String> algo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EncryptedLabelsCompanion.insert(
                id: id,
                nonce: nonce,
                ciphertext: ciphertext,
                mac: mac,
                idxOrigin: idxOrigin,
                idxType: idxType,
                idxRef: idxRef,
                idxLabelFull: idxLabelFull,
                version: version,
                keyVersion: keyVersion,
                algo: algo,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EncryptedLabelsTableProcessedTableManager =
    ProcessedTableManager<
      _$LabelsDatabase,
      $EncryptedLabelsTable,
      EncryptedLabel,
      $$EncryptedLabelsTableFilterComposer,
      $$EncryptedLabelsTableOrderingComposer,
      $$EncryptedLabelsTableAnnotationComposer,
      $$EncryptedLabelsTableCreateCompanionBuilder,
      $$EncryptedLabelsTableUpdateCompanionBuilder,
      (
        EncryptedLabel,
        BaseReferences<_$LabelsDatabase, $EncryptedLabelsTable, EncryptedLabel>,
      ),
      EncryptedLabel,
      PrefetchHooks Function()
    >;
typedef $$LabelTokensTableCreateCompanionBuilder =
    LabelTokensCompanion Function({
      required String labelId,
      required Uint8List tokenHash,
      Value<int> rowid,
    });
typedef $$LabelTokensTableUpdateCompanionBuilder =
    LabelTokensCompanion Function({
      Value<String> labelId,
      Value<Uint8List> tokenHash,
      Value<int> rowid,
    });

class $$LabelTokensTableFilterComposer
    extends Composer<_$LabelsDatabase, $LabelTokensTable> {
  $$LabelTokensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get tokenHash => $composableBuilder(
    column: $table.tokenHash,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LabelTokensTableOrderingComposer
    extends Composer<_$LabelsDatabase, $LabelTokensTable> {
  $$LabelTokensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get tokenHash => $composableBuilder(
    column: $table.tokenHash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabelTokensTableAnnotationComposer
    extends Composer<_$LabelsDatabase, $LabelTokensTable> {
  $$LabelTokensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<Uint8List> get tokenHash =>
      $composableBuilder(column: $table.tokenHash, builder: (column) => column);
}

class $$LabelTokensTableTableManager
    extends
        RootTableManager<
          _$LabelsDatabase,
          $LabelTokensTable,
          LabelToken,
          $$LabelTokensTableFilterComposer,
          $$LabelTokensTableOrderingComposer,
          $$LabelTokensTableAnnotationComposer,
          $$LabelTokensTableCreateCompanionBuilder,
          $$LabelTokensTableUpdateCompanionBuilder,
          (
            LabelToken,
            BaseReferences<_$LabelsDatabase, $LabelTokensTable, LabelToken>,
          ),
          LabelToken,
          PrefetchHooks Function()
        > {
  $$LabelTokensTableTableManager(_$LabelsDatabase db, $LabelTokensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LabelTokensTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LabelTokensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$LabelTokensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> labelId = const Value.absent(),
                Value<Uint8List> tokenHash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelTokensCompanion(
                labelId: labelId,
                tokenHash: tokenHash,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String labelId,
                required Uint8List tokenHash,
                Value<int> rowid = const Value.absent(),
              }) => LabelTokensCompanion.insert(
                labelId: labelId,
                tokenHash: tokenHash,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LabelTokensTableProcessedTableManager =
    ProcessedTableManager<
      _$LabelsDatabase,
      $LabelTokensTable,
      LabelToken,
      $$LabelTokensTableFilterComposer,
      $$LabelTokensTableOrderingComposer,
      $$LabelTokensTableAnnotationComposer,
      $$LabelTokensTableCreateCompanionBuilder,
      $$LabelTokensTableUpdateCompanionBuilder,
      (
        LabelToken,
        BaseReferences<_$LabelsDatabase, $LabelTokensTable, LabelToken>,
      ),
      LabelToken,
      PrefetchHooks Function()
    >;
typedef $$KeyringTableCreateCompanionBuilder =
    KeyringCompanion Function({
      required String id,
      Value<String> kdf,
      required Uint8List kdfSalt,
      required int kdfIterations,
      required Uint8List mekNonce,
      required Uint8List mekCiphertext,
      required Uint8List mekMac,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$KeyringTableUpdateCompanionBuilder =
    KeyringCompanion Function({
      Value<String> id,
      Value<String> kdf,
      Value<Uint8List> kdfSalt,
      Value<int> kdfIterations,
      Value<Uint8List> mekNonce,
      Value<Uint8List> mekCiphertext,
      Value<Uint8List> mekMac,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$KeyringTableFilterComposer
    extends Composer<_$LabelsDatabase, $KeyringTable> {
  $$KeyringTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kdf => $composableBuilder(
    column: $table.kdf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get kdfSalt => $composableBuilder(
    column: $table.kdfSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kdfIterations => $composableBuilder(
    column: $table.kdfIterations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get mekNonce => $composableBuilder(
    column: $table.mekNonce,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get mekCiphertext => $composableBuilder(
    column: $table.mekCiphertext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get mekMac => $composableBuilder(
    column: $table.mekMac,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyringTableOrderingComposer
    extends Composer<_$LabelsDatabase, $KeyringTable> {
  $$KeyringTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kdf => $composableBuilder(
    column: $table.kdf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get kdfSalt => $composableBuilder(
    column: $table.kdfSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kdfIterations => $composableBuilder(
    column: $table.kdfIterations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get mekNonce => $composableBuilder(
    column: $table.mekNonce,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get mekCiphertext => $composableBuilder(
    column: $table.mekCiphertext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get mekMac => $composableBuilder(
    column: $table.mekMac,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyringTableAnnotationComposer
    extends Composer<_$LabelsDatabase, $KeyringTable> {
  $$KeyringTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kdf =>
      $composableBuilder(column: $table.kdf, builder: (column) => column);

  GeneratedColumn<Uint8List> get kdfSalt =>
      $composableBuilder(column: $table.kdfSalt, builder: (column) => column);

  GeneratedColumn<int> get kdfIterations => $composableBuilder(
    column: $table.kdfIterations,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get mekNonce =>
      $composableBuilder(column: $table.mekNonce, builder: (column) => column);

  GeneratedColumn<Uint8List> get mekCiphertext => $composableBuilder(
    column: $table.mekCiphertext,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get mekMac =>
      $composableBuilder(column: $table.mekMac, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$KeyringTableTableManager
    extends
        RootTableManager<
          _$LabelsDatabase,
          $KeyringTable,
          KeyringData,
          $$KeyringTableFilterComposer,
          $$KeyringTableOrderingComposer,
          $$KeyringTableAnnotationComposer,
          $$KeyringTableCreateCompanionBuilder,
          $$KeyringTableUpdateCompanionBuilder,
          (
            KeyringData,
            BaseReferences<_$LabelsDatabase, $KeyringTable, KeyringData>,
          ),
          KeyringData,
          PrefetchHooks Function()
        > {
  $$KeyringTableTableManager(_$LabelsDatabase db, $KeyringTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$KeyringTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$KeyringTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$KeyringTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> kdf = const Value.absent(),
                Value<Uint8List> kdfSalt = const Value.absent(),
                Value<int> kdfIterations = const Value.absent(),
                Value<Uint8List> mekNonce = const Value.absent(),
                Value<Uint8List> mekCiphertext = const Value.absent(),
                Value<Uint8List> mekMac = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyringCompanion(
                id: id,
                kdf: kdf,
                kdfSalt: kdfSalt,
                kdfIterations: kdfIterations,
                mekNonce: mekNonce,
                mekCiphertext: mekCiphertext,
                mekMac: mekMac,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> kdf = const Value.absent(),
                required Uint8List kdfSalt,
                required int kdfIterations,
                required Uint8List mekNonce,
                required Uint8List mekCiphertext,
                required Uint8List mekMac,
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyringCompanion.insert(
                id: id,
                kdf: kdf,
                kdfSalt: kdfSalt,
                kdfIterations: kdfIterations,
                mekNonce: mekNonce,
                mekCiphertext: mekCiphertext,
                mekMac: mekMac,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyringTableProcessedTableManager =
    ProcessedTableManager<
      _$LabelsDatabase,
      $KeyringTable,
      KeyringData,
      $$KeyringTableFilterComposer,
      $$KeyringTableOrderingComposer,
      $$KeyringTableAnnotationComposer,
      $$KeyringTableCreateCompanionBuilder,
      $$KeyringTableUpdateCompanionBuilder,
      (
        KeyringData,
        BaseReferences<_$LabelsDatabase, $KeyringTable, KeyringData>,
      ),
      KeyringData,
      PrefetchHooks Function()
    >;

class $LabelsDatabaseManager {
  final _$LabelsDatabase _db;
  $LabelsDatabaseManager(this._db);
  $$EncryptedLabelsTableTableManager get encryptedLabels =>
      $$EncryptedLabelsTableTableManager(_db, _db.encryptedLabels);
  $$LabelTokensTableTableManager get labelTokens =>
      $$LabelTokensTableTableManager(_db, _db.labelTokens);
  $$KeyringTableTableManager get keyring =>
      $$KeyringTableTableManager(_db, _db.keyring);
}
