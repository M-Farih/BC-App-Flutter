import 'dart:convert';

import 'package:bc_app/models/ristourne.dart';
import 'package:bc_app/services/ristourneService.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RistourneProvider extends ChangeNotifier{

  bool isBusy = false;
  List<Ristourne> _ristournes = List();
  List<Ristourne> get ristournes => _ristournes;
  String _image;
  String get image => _image;
  RistourneService _ristourneService = RistourneService();


  Future<List<Ristourne>> getRistournes() async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.getRistournes();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _ristournes.clear();
      data['data'].forEach((c)=> _ristournes.add(Ristourne.fromJson(c)));
      isBusy = false;
      notifyListeners();
    }
    return _ristournes;
  }

  Future<void> addRistourne(String min, String max, String percent) async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.addRistourne(min, max, percent);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('ristourne added :::>  ${response.body}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> updateRistourne(String id, String min, String max, String percent) async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.updateRistourne(id, min, max, percent);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('ristourne updated :::>  ${response.body}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> deleteRistourne(String id) async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.deleteRistourne(id);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('ristourne deleted :::>  ${response.body}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> getRistourneImage() async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.getRistourneImage();
    print('ristourne image 1 :::>  ${response.body}');
    if(response.statusCode == 200 || response.statusCode == 201){
      print('ristourne image :::>  ${response.body}');
      isBusy = false;
      notifyListeners();
      var data = jsonDecode(response.body);
      _image = data['data'][0]['promo'].toString().replaceAll('"', '');

    }
  }

  Future<void> uploadRistournePicture(String filePath) async{
    isBusy = true;
    notifyListeners();
    var response =  await _ristourneService.uploadRistournePicture(filePath).whenComplete((){
      isBusy = false;
      notifyListeners();
    });
  }
}