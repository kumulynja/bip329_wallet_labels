class LabelbaseLabelDataModel {
  LabelbaseLabelDataModel({
    required String type,
    required String ref,
    String? label,
    String? origin,
    bool? spendable,
  }) : _type = type,
       _ref = ref,
       _label = label == null || label.isEmpty ? null : label,
       _origin = origin == null || origin.isEmpty ? null : origin,
       _spendable = spendable;

  final String _type;
  final String _ref;
  final String? _label;
  final String? _origin;
  final bool? _spendable;

  String get type => _type;
  String get ref => _ref;
  String? get label => _label;
  String? get origin => _origin;
  bool? get spendable => _spendable;

  Map<String, dynamic> toJson() {
    return {
      'type': _type,
      'ref': _ref,
      if (_label != null) 'label': _label,
      if (_origin != null) 'origin': _origin,
      if (_spendable != null) 'spendable': _spendable,
    };
  }
}

class LabelbaseLabelModel {
  const LabelbaseLabelModel({
    required int id,
    required LabelbaseLabelDataModel data,
  }) : _id = id,
       _data = data;

  final int _id;
  final LabelbaseLabelDataModel _data;

  int get id => _id;
  LabelbaseLabelDataModel get data => _data;
  String get type => _data._type;
  String get ref => _data._ref;
  String? get label => _data._label;
  String? get origin => _data._origin;
  bool? get spendable => _data._spendable;

  factory LabelbaseLabelModel.fromJson(Map<String, dynamic> json) {
    return LabelbaseLabelModel(
      id: json['id'] as int,
      data: LabelbaseLabelDataModel(
        type: json['type'] as String,
        ref: json['ref'] as String,
        label: json['label'] as String?,
        origin: json['origin'] as String?,
        spendable: json['spendable'] as bool?,
      ),
    );
  }
}
