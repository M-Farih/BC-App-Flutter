import 'dart:convert';

import 'package:bc_app/models/ca.dart';
import 'package:bc_app/services/caService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CaProvider extends ChangeNotifier {
  bool isBusy = true;
  CAService _caService = CAService();
  List<CA> _ca = List();
  List<CA> get ca => _ca;

  Future<void> getCA(int idvendor) async {
    isBusy = true;
    var response = await _caService.caByDate(idvendor);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _ca.clear();
      data['data'].forEach((u) => _ca.add(CA.fromJson(u)));
      isBusy = false;
      notifyListeners();
      print(response.body);
    }
    print(
        "------------------------------------------LLLLLLLLLLLLLLLLLLLLLL----------------------------");
    print(_ca.first.total_ca_184);
    print(_ca.first.total_ca_365);
    print(_ca.first.payment_deadline);
    return _ca;
  }
}
