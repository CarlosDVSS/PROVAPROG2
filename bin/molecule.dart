import 'periodic_table.dart';

class Atom {
  final String symbol;

  Atom(this.symbol) {
    if (!isValidSymbol(symbol)) {
      throw Exception('Invalid atom symbol: $symbol');
    }
  }

  bool isValidSymbol(String symbol) {
    return symbol.isNotEmpty;
  }
}

class Molecule implements Comparable<Molecule> {
  final String formula;
  final String name;

  Molecule({required this.formula, required this.name}) {
    if (!isValidFormula(formula)) {
      throw Exception('Invalid formula: $formula');
    }
  }

  bool isValidFormula(String formula) {
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(formula)) {
      return false;
    }

    RegExp elementPattern = RegExp(r'([A-Z][a-z]*)(\d*)');
    Iterable<RegExpMatch> matches = elementPattern.allMatches(formula);

    for (RegExpMatch match in matches) {
      final symbol = match.group(1)!;
      if (!PeriodicTable.elements.containsKey(symbol)) {
        return false;
      }
    }

    return true;
  }

  int get weight {
    int totalWeight = 0;

    RegExp elementPattern = RegExp(r'([A-Z][a-z]*)(\d*)');
    Iterable<RegExpMatch> matches = elementPattern.allMatches(formula);

    for (RegExpMatch match in matches) {
      final symbol = match.group(1)!;
      final countStr = match.group(2);
      final count =
          countStr != null && countStr.isNotEmpty ? int.parse(countStr) : 1;

      final atom = Atom(symbol);
      final element = PeriodicTable.elements[atom.symbol];

      if (element != null) {
        totalWeight += element.weight * count;
      }
    }

    return totalWeight;
  }

  @override
  int compareTo(Molecule other) {
    final weightComparison = weight.compareTo(other.weight);
    return weightComparison != 0
        ? weightComparison
        : name.compareTo(other.name);
  }
}
