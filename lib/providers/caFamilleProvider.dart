import 'dart:convert';

import 'package:bc_app/models/caFamille.dart';
import 'package:bc_app/services/CaFamilleService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CaFamilleProvider extends ChangeNotifier {
  bool isBusy = true;
  CAFamilleService _caFamilleService = CAFamilleService();
  // ignore: deprecated_member_use
  List<CAFamille> _caFamille = List();
  List<CAFamille> get caFamille => _caFamille;

  Future<void> getCAFamille(int idvendor) async {
    isBusy = true;
    var response = await _caFamilleService.getCAFamille(idvendor);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _caFamille.clear();
      data['data'].forEach((u) => _caFamille.add(CAFamille.fromJson(u)));
      isBusy = false;
      notifyListeners();
    }
    return _caFamille;
  }
}
