import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  List<String> _selectedTypes = ["image"];
  List<String> get selectedTypes => _selectedTypes;

  void addSelectedType(String type) {
    _selectedTypes.add(type);
    notifyListeners();
  }

  void removeSelectedType(String type) {
    _selectedTypes.remove(type);
    notifyListeners();
  }
}
