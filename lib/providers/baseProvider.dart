import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier{
  bool _busy = true;

  bool get busy => _busy;
  setBusy(bool val){
    _busy = val;
    notifyListeners();
  }

}