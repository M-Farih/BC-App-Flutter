import 'dart:convert';

import 'package:bc_app/models/note.dart';
import 'package:bc_app/services/myNoteService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyNoteProvider extends ChangeNotifier {
  bool isBusy = true;
  MyNoteService _myNoteService = MyNoteService();
  List<MyNote> _myNote = List();
  List<MyNote> get myNote => _myNote;

  Future<void> getMyNote(int idvendor, int caAn, int caM, int del) async {
    isBusy = true;
    var response = await _myNoteService.note(idvendor, caAn, caM, del);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _myNote.clear();
      data['data'].forEach((u) => _myNote.add(MyNote.fromJson(u)));
      isBusy = false;
      notifyListeners();
    }
    print("gggggggggggggggggggggggggggggggggggggggggggggg ===============");
    print(response.statusCode);
    return _myNote;
  }
}
