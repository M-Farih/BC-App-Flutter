import 'dart:convert';

import 'package:bc_app/models/promotion.dart';
import 'package:bc_app/services/promotionService.dart';
import 'package:flutter/cupertino.dart';

class PromotionProvider extends ChangeNotifier{

  bool isBusy = false;
  PromotionService _promotionService = PromotionService();
  List<Promotion> _promotions = List();
  List<Promotion> get promotions => _promotions;

  List<Promotion> _annonces = List();
  List<Promotion> get annonces => _annonces;

  String _pdfLink;
  String get pdfLink => _pdfLink;


  Future <void> getPromotions() async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.getPromos();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _promotions.clear();
      data['data'].forEach((p)=> _promotions.add(Promotion.fromJson(p)));
      isBusy = false;
      notifyListeners();
    }
  }

  Future <void> getAnnonces() async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.getAnnonces();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _annonces.clear();
      data['data'].forEach((p)=> _annonces.add(Promotion.fromJson(p)));
      print('*******   ${_annonces.length}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> addPromo(String image, String type) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.addPromo(image).whenComplete(() {
      isBusy = false;
      notifyListeners();
    });
  }

  Future<void> addPdf(String image) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.addPdf(image).whenComplete(() {
      isBusy = false;
      notifyListeners();
    });
  }

  Future<void> addAnnonce(String image) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.addAnnonce(image).whenComplete(() {
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

  Future<void> deletePromo(String id) async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.deletePromo(id);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('${response.body}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future <void> getPdfLink() async{
    isBusy = true;
    notifyListeners();
    var response = await _promotionService.getPdfLink();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _pdfLink = data['data'][0]['promo'].toString().replaceAll('"', '');
      isBusy = false;
      notifyListeners();
    }
  }

}


