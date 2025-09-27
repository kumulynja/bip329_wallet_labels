class AddLabelRequest {
  final String type;
  final String ref;
  final String? label;
  final String? origin;
  final int? blockHeight;
  final DateTime? blockTime;
  final int? valueSat;
  final int? minerFeeSat;
  final Map<String, double>? exchangeRates;
  final String? keyPath;
  final List<int>? heights;
  final Map<String, double>? fairMarketValue;
  final bool? spendable;
  final int? index;

  const AddLabelRequest({
    required this.type,
    required this.ref,
    this.label,
    this.origin,
    this.blockHeight,
    this.blockTime,
    this.valueSat,
    this.minerFeeSat,
    this.exchangeRates,
    this.keyPath,
    this.heights,
    this.fairMarketValue,
    this.spendable,
    this.index,
  });
}
