import 'dart:convert';

import 'package:bc_app/models/sellersCount.dart';
import 'package:bc_app/services/NombreTotalRevendeurService.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NombreTotalRevendeurProvider extends ChangeNotifier{

  bool isBusy = false;
  List<SellersCount> _sellersCount = List();
  String count = '0';
  int selectedCity = 0;
  int sellersTotalCount = 0;

  List<SellersCount> get sellersCount => _sellersCount;

  NombreTotalRevendeurService _nombreTotalRevendeurService = NombreTotalRevendeurService();


  Future<List<SellersCount>> getStatisticsByCity() async{
    isBusy = true;
    notifyListeners();
    var response = await _nombreTotalRevendeurService.getStatisticsByCity();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _sellersCount.clear();
      data['data'].forEach((s) => _sellersCount.add(SellersCount.fromJson(s)));
      count = _sellersCount[0].count;
      isBusy = false;
      notifyListeners();
    }
    return _sellersCount;
  }

  Future<int> getSellersCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _nombreTotalRevendeurService.getSellersCount();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);

      sellersTotalCount = data['count'];
      isBusy = false;
      notifyListeners();
    }
    return sellersTotalCount;
  }

  getCitycount(int index){
    count = _sellersCount[index].count;
    selectedCity = index;
    print('city ${_sellersCount[index]}');
    notifyListeners();
  }

}