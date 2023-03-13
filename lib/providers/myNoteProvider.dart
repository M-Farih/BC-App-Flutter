import 'dart:convert';

import 'package:bc_app/models/note.dart';
import 'package:bc_app/services/myNoteService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyNoteProvider extends ChangeNotifier {
  bool isBusy = false;
  List<MyNote> _myNote = List();
  List<MyNote> get myNote => _myNote;
  MyNoteService _myNoteService = MyNoteService();
  // ignore: deprecated_member_use

  Future<void> getMyNote(
      int idvendor, int caAn, int caM, int del) async {
    isBusy = true;
    notifyListeners();
    var response = await _myNoteService.note(idvendor, caAn, caM, del);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _myNote.clear();
      data['data'].forEach((n) => _myNote.add(MyNote.fromJson(n)));
      isBusy = false;
      notifyListeners();
    }
    return _myNote;
  }
}
