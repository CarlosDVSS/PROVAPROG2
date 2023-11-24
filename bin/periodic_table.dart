import 'dart:convert';
import 'dart:io';
import 'element.dart';

class PeriodicTable {
  static final PeriodicTable _instance = PeriodicTable._internal();

  factory PeriodicTable() => _instance;

  PeriodicTable._internal();

  static Map<String, Element> elements = {};

  static void loadElements(String jsonFilePath) {
    final jsonFile = File(jsonFilePath);
    final jsonString = jsonFile.readAsStringSync();
    final List<dynamic> dataList = json.decode(jsonString);

    for (final elementData in dataList) {
      final symbol = elementData['symbol'];
      final name = elementData['name'];
      final latinName = elementData['latinName'];
      final weight = int.parse(elementData['weight']);

      elements[symbol] = Element(
        symbol: symbol,
        name: name,
        latinName: latinName,
        weight: weight,
      );
    }
  }
}
