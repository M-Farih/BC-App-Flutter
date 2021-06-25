import 'dart:convert';

import 'package:bc_app/models/user.dart';
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

  int index = 15 , i = 15, usersLength = 0;

  UserService _userService = UserService();

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
        city, address, telephone, role_id, profileImage);
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

  Future<void> getSellers() async{
    busy = true;
    notifyListeners();
    var response = await _userService.getSellers();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      tempSellersList.clear();
      data['data'].forEach((u) => tempSellersList.add(User.fromJson(u)));
      _sellers = tempSellersList;
      busy = false;
      notifyListeners();
    }
  }

  Future<void> getSellersByAgent(int id) async{
    busy = true;
    notifyListeners();
    var response = await _userService.getSellersByAgent(id);
    if(response.statusCode == 200){
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

  onBegin(){
    usersLength = _sellers.length;
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
          index = filteredUsers.length + 1;
          filteredUsers.add(element);
          _sellers = filteredUsers;
          notifyListeners();
        }
      });

      _sellers = filteredUsers;
      notifyListeners();

    }
  }

  onEndScroll() {
    print("Scroll End");
    print("table length --> $usersLength");
    print("i  --> $i");

     if(usersLength >= 200){
       if(usersLength >= i){
         print("table length --> $usersLength");

         index = i;
         i = i + 20;
         print("table length 1 --> $i");
         notifyListeners();
       }
       else{
         i = i - 21;
         print("table length 2 --> $i");
         index = usersLength - i;
         notifyListeners();
       }
     }

  }
}