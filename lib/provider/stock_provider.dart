import 'package:fitpage_assignment/repository/api_repo.dart';
import 'package:flutter/material.dart';

class StockProvider extends ChangeNotifier {
  final _apiRepository = ApiRepository();
  bool isLoading = false;
  List _data = [];
  List get data => _data;

  Future<void> getData() async {
    isLoading = true;
    notifyListeners();
    final response = await _apiRepository.fetchData();

    _data = response;
    isLoading = false;
    notifyListeners();
  }
}
