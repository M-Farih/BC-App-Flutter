import 'dart:convert';

import 'package:bc_app/models/reason.dart';
import 'package:bc_app/services/reasonService.dart';
import 'package:flutter/cupertino.dart';

class ReasonProvider extends ChangeNotifier{
  bool isBusy = true;
  ReasonService _reasonService = ReasonService();
  List<Reason> _reasons = List();
  List<Reason> get reasons => _reasons;

  Future<void> getReasons(int id) async{
    isBusy = true;
    var response = await _reasonService.getReasons(id);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _reasons.clear();
      data['data'].forEach((u) => _reasons.add(Reason.fromJson(u)));
      isBusy = false;
      notifyListeners();
    }
    return _reasons;
  }
}