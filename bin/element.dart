class Element {
  final String symbol;
  final String name;
  final String latinName;
  final int weight;

  Element({
    required this.symbol,
    required this.name,
    required this.latinName,
    required this.weight,
  }) {
    if (!isValidSymbol(symbol)) {
      throw Exception('Invalid symbol: $symbol');
    }
  }

  bool isValidSymbol(String symbol) {
    return symbol.isNotEmpty;
  }
}
