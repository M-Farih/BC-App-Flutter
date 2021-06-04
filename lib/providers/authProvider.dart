import 'dart:convert';
import 'package:bc_app/models/user.dart';
import 'package:bc_app/providers/baseProvider.dart';
import 'file:///C:/_myproject/flutter/BC-App-Flutter/lib/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider{

  bool busy = true;

  AuthService _authService = AuthService();
  List<User> _users = List();
  User _currentUsr;
  int iduser;

  List<User> get users => _users;
  User get currentUsr => _currentUsr;
  bool canPass = false;

  Future<bool> login(String username, String password) async {
    print("login called");
    busy = true;
    var response = await _authService.login(username.trim(), password.trim());
    if (response.statusCode == 200) {
      //fill user model
      var data = jsonDecode(response.body);
      if(data["data"].length > 0){
        canPass = true;
        saveUserInSP(data);
        data['data'].forEach((u) => _users.add(User.fromJson(u)));
        setLogin();
        notifyListeners();
        busy = false;

      }
      else{
        canPass = false;
      }
    }
    return canPass;
  }

  Future<void> getAllUsers() async {
    busy = true;
    var response = await _authService.getAllUsers();
    if (response.statusCode == 200) {
      ///fill user model
      var data = jsonDecode(response.body);
      data['data'].forEach((u) => _users.add(User.fromJson(u)));
      notifyListeners();
      busy = false;
    }
    return _users;
  }

  bool loggedIn = false;
  Future<int> checkLoginAndRole() async{
    busy = true;
    int role_id = 0;
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLogged';
    loggedIn = prefs.get(key) ?? false;

    if(loggedIn){
      await getUserFromSP();
      role_id = _currentUsr.idrole;
      busy = false;
      return role_id;

    }else
      busy = false;
      return role_id;

  }

  Future<void> setLogin() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLogged';
    prefs.setBool(key, true);
  }

  Future<void> logout() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> saveUserInSP(user) async {
    spbusy = true;
    notifyListeners();
    print('setting user in SP');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    var currentUser = user['data'];
    prefs.setString('user', json.encode(currentUser));
    print('user saved -> ${json.encode(currentUser)}');

    spbusy = false;
    notifyListeners();
  }

  bool spbusy = true;
  Future<void> getUserFromSP() async{
    print('getting saved user form SP...');
    spbusy = true;
    final prefs = await SharedPreferences.getInstance();
    var user = jsonDecode(prefs.getString('user'));
    print('user from Sp ==> ${user[0]['iduser']}');
    _currentUsr = null;
    _currentUsr = User.fromJson(user[0]);
    //await Future.delayed(Duration(seconds: 5));
    print('====username==== ${_currentUsr.iduser}');
    iduser = _currentUsr.iduser;
    spbusy = false;
    notifyListeners();
  }

  Future<void> updateCurrentUser(String firstName, lastName, entrepriseName, ice, city, address, telephone, profileImage) async{
    print('updating current user');
    User _tempUser = _currentUsr;
    _currentUsr = null;
    _currentUsr = new User(_tempUser.idrole, _tempUser.idagent, firstName, lastName, _tempUser.userName, _tempUser.email, _tempUser.password, entrepriseName, ice, city, address, telephone, _tempUser.clientNumber, _tempUser.agentIduser, _tempUser.agentName, _tempUser.idrole, profileImage, _tempUser.solde, _tempUser.ristourne);
  }

}
