class UpdateLabelRequest {
  final String type;
  final String currentRef;
  final String? currentLabel;
  final String? currentOrigin;
  final int? currentBlockHeight;
  final DateTime? currentBlockTime;
  final int? currentValueSat;
  final int? currentMinerFeeSat;
  final Map<String, double>? currentExchangeRates;
  final String? currentKeyPath;
  final List<int>? currentHeights;
  final Map<String, double>? currentFairMarketValue;
  final bool? currentSpendable;
  final int? currentIndex;

  // New values
  final String? newLabel;
  final String? newOrigin;
  final int? newBlockHeight;
  final DateTime? newBlockTime;
  final int? newValueSat;
  final int? newMinerFeeSat;
  final Map<String, double>? newExchangeRates;
  final String? newKeyPath;
  final List<int>? newHeights;
  final Map<String, double>? newFairMarketValue;
  final bool? newSpendable;

  const UpdateLabelRequest({
    required this.type,
    required this.currentRef,
    this.currentLabel,
    this.currentOrigin,
    this.currentBlockHeight,
    this.currentBlockTime,
    this.currentValueSat,
    this.currentMinerFeeSat,
    this.currentExchangeRates,
    this.currentKeyPath,
    this.currentHeights,
    this.currentFairMarketValue,
    this.currentSpendable,
    this.currentIndex,
    this.newLabel,
    this.newOrigin,
    this.newBlockHeight,
    this.newBlockTime,
    this.newValueSat,
    this.newMinerFeeSat,
    this.newExchangeRates,
    this.newKeyPath,
    this.newHeights,
    this.newFairMarketValue,
    this.newSpendable,
  });
}
