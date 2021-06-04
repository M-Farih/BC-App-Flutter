import 'dart:convert';

import 'package:bc_app/models/promotion.dart';
import 'package:bc_app/services/promotionService.dart';
import 'package:flutter/cupertino.dart';

class PromotionProvider extends ChangeNotifier{

  bool isBusy = false;
  PromotionService _promotionService = PromotionService();
  List<Promotion> _promotions = List();
  List<Promotion> get promotions => _promotions;

  Future <void> getPromotions() async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.getPromos();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print('promos ---> ${data}');
      _promotions.clear();
      data['data'].forEach((p)=> _promotions.add(Promotion.fromJson(p)));
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> addPromo(String image) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.addPromo(image).whenComplete(() {
      isBusy = false;
      notifyListeners();
    });
  }

  Future<void> updatePromo(String image, String idpromo) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.updatePromo(image, idpromo).whenComplete(() {
      isBusy = false;
      notifyListeners();
    });
  }

}


