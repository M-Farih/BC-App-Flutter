import 'dart:convert';

import 'package:bc_app/models/user.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier{
  bool busy = true;
  User _currentUser;
  User _userById;
  List<User> _sellers = List();
  List<User> _tempSellersList = List();

  User get currentUser => _currentUser;
  User get userById => _userById;
  List<User> get sellers => _sellers;
  List<User> get tempSellersList => _tempSellersList;
  int myIndex = 0;

  UserService _userService = UserService();
  AuthProvider authProvider = AuthProvider();

  Future<void> add(String fname, String lname, String username, String password, String email, String telephone) async{
    busy = true;
    notifyListeners();
    var response = await _userService.add(fname, lname, username, password, email, telephone);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('user added ::::> ${response.body}');
      busy = false;
      notifyListeners();
    }
  }

  Future<void> update(int id, clientNumber, firstName, lastName, entrepriseName, ice, city, address, telephone, int role_id, profileImage) async{
    busy = true;
    notifyListeners();
    var response = await _userService.update(id, clientNumber,firstName, lastName, entrepriseName, ice,
        city, address, telephone, role_id, profileImage, "");
    busy = false;
    notifyListeners();
  }

  Future<void> updateUsernameAndPassword(id, username, password) async{
    busy = true;
    notifyListeners();

    var response = await _userService.updateUsernameAndPassword(id, username, password);
    if(response.statusCode == 200){
      busy = false;
      notifyListeners();
    }
  }

  Future<void> getSellers(int idRole) async{
    busy = true;
    notifyListeners();
    await authProvider.getUserFromSP();
    if(idRole == 0){
      var response = await _userService.getSellers();
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        tempSellersList.clear();
        data['data'].forEach((u) => tempSellersList.add(User.fromJson(u)));
        _sellers = tempSellersList;
        _sellers.removeWhere((element) => element.iduser == authProvider.iduser);
        if(_sellers.length > 150){
          myIndex = 80;
        }
        else{
          myIndex = _sellers.length;
        }
        busy = false;
        notifyListeners();
      }
    }
    else if(idRole == 1){
      List<User> _sellersList = List();
      List<User> _commercialsList = List();
      var response = await _userService.getSellersByidRole("3");
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        _sellersList.clear();
        data['data'].forEach((u) => tempSellersList.add(User.fromJson(u)));
        _sellersList = tempSellersList;
      }
      response = await _userService.getSellersByidRole("2");
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        _commercialsList.clear();
        data['data'].forEach((u) => tempSellersList.add(User.fromJson(u)));
        _commercialsList = tempSellersList;
      }
      _sellers = new List.from(_commercialsList)..addAll(_sellersList);
      _sellers.removeWhere((element) => element.iduser == authProvider.iduser);
      print('////// ${_sellers[0].userName}');
      if(_sellers.length > 150){
        myIndex = 80;
      }
      else{
        myIndex = _sellers.length;
      }
      busy = false;
      notifyListeners();
    }
  }

  Future<void> getSellersByAgent(int id) async{
    busy = true;
    notifyListeners();
    var response = await _userService.getSellersByAgent(id);
    if(response.statusCode == 200){
      print(' */*/*/* ${response.body}');
      var data = jsonDecode(response.body);
      tempSellersList.clear();
      data['data'].forEach((u) => tempSellersList.add(User.fromJson(u)));
      _sellers = tempSellersList;
      busy = false;
      notifyListeners();
    }
  }

  Future<void> getSellerById(int id) async{
    busy = true;
    notifyListeners();
    var data;
    var response = await _userService.getSellerById(id);
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      data['data'].forEach((u) => _userById = User.fromJson(u));
      busy = false;
      notifyListeners();
      print('name === ${_userById.firstName}');
    }
  }

  filterUsersList(String text) {
    if(text.isEmpty){
      _sellers = tempSellersList;
      notifyListeners();
    }
    else{
      final List<User> filteredUsers = List();
      _tempSellersList.forEach((element) {
        if(element.firstName.toLowerCase().contains(text.toLowerCase()) ||
            element.lastName.toLowerCase().contains(text.toLowerCase()) ||
            element.clientNumber.toLowerCase().contains(text.toLowerCase())
        ){
          filteredUsers.add(element);
          _sellers = filteredUsers;
          if(_sellers.length > 10){
            myIndex = (_sellers.length / 4).toInt();
          }
          else{
            myIndex = _sellers.length;
          }
          notifyListeners();
        }
      });
      _sellers = filteredUsers;
      notifyListeners();
    }
  }

  Future<void> uploadCsv(String filePath) async{
    busy = true;
    notifyListeners();
    var response =  await _userService.uploadCsv(filePath).whenComplete((){
      busy = false;
      notifyListeners();
    });
  }

}