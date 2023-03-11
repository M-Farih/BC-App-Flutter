import 'dart:convert';
import 'dart:math';
import 'package:bc_app/models/user.dart';
import 'package:bc_app/providers/baseProvider.dart';
import 'package:bc_app/services/api.dart';
import 'package:bc_app/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  bool busy = true;
  bool userChekcerIsBusy = true;

  AuthService _authService = AuthService();
  Api api = Api();
  List<User> _users = List();
  User _currentUsr;
  int iduser;
  String solde, ristourne, from, to;
  double banquette, divers, matelas, mousse, max;
  List<double> famillesSold;

  List<User> get users => _users;
  User get currentUsr => _currentUsr;
  bool canPass = false;

  Future<bool> login(String username, String password) async {
    busy = true;
    var response = await _authService.login(username.trim(), password.trim());
    if (response.statusCode == 200) {
      //fill user model
      var data = jsonDecode(response.body);
      if (data["data"].length > 0) {
        canPass = true;
        saveUserInSP(data);
        _users.clear();
        data['data'].forEach((u) => _users.add(User.fromJson(u)));

        if (_users[0].firstConnection == "0") {
          Map<String, dynamic> body = {"firstConnection": 1};
          var upUser = await api.httpPut(
              'users', '${_users[0].iduser}', jsonEncode(body));
        }

        setLogin();
        notifyListeners();
        busy = false;
      } else {
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
  Future<int> checkLoginAndRole() async {
    userChekcerIsBusy = true;
    notifyListeners();
    int role_id;
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLogged';
    loggedIn = prefs.get(key) ?? false;
    if (loggedIn) {
      await getUserFromSP();
      role_id = _currentUsr.idrole;
      userChekcerIsBusy = false;
      notifyListeners();
      return role_id;
    } else {
      userChekcerIsBusy = false;
      notifyListeners();
      return role_id;
    }
  }

  Future<void> setLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLogged';
    prefs.setBool(key, true);
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> saveUserInSP(user) async {
    spbusy = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    var currentUser = user['data'];
    prefs.setString('user', json.encode(currentUser));

    spbusy = false;
    notifyListeners();
  }

  bool spbusy = true;
  Future<void> getUserFromSP() async {
    spbusy = true;
    final prefs = await SharedPreferences.getInstance();
    var user = jsonDecode(prefs.getString('user'));
    _currentUsr = null;
    _currentUsr = User.fromJson(user[0]);
    //await Future.delayed(Duration(seconds: 5));
    iduser = _currentUsr.iduser;
    spbusy = false;
    notifyListeners();
  }

  Future<void> updateCurrentUser(String firstName, lastName, entrepriseName,
      ice, city, address, telephone, profileImage) async {
    User _tempUser = _currentUsr;
    _currentUsr = null;
    _currentUsr = new User(
      _tempUser.idrole,
      _tempUser.idagent,
      firstName,
      lastName,
      _tempUser.userName,
      _tempUser.email,
      _tempUser.password,
      entrepriseName,
      ice,
      city,
      address,
      telephone,
      _tempUser.idvendor,
      _tempUser.agentIduser,
      _tempUser.agentName,
      _tempUser.idrole,
      profileImage,
      _tempUser.agentPhone,
      _tempUser.firstConnection,
    );
  }

  // Future<void> getUserSolde(int id) async {
  //   busy = true;
  //   notifyListeners();
  //   var response = await _authService.getUserSolde(id);
  //   if (response.statusCode == 200) {
  //     ///fill user model banquette, divers, matelas, mousse;
  //     var data = jsonDecode(response.body);
  //     solde = data['data'][0]['solde'];
  //     from = data['data'][0]['from_date_ca'];
  //     to = data['data'][0]['to_date_ca'];
  //     banquette = double.parse(data['data'][0]['banquette']);
  //     divers = double.parse(data['data'][0]['divers']);
  //     matelas = double.parse(data['data'][0]['matelas']);
  //     mousse = double.parse(data['data'][0]['mousse']);
  //     ristourne = data['data'][0]['ristourne'];

  //     famillesSold = [banquette, divers, matelas, mousse];
  //     max = famillesSold[0];
  //     for (int i = 1; i < famillesSold.length; i++) {
  //       if (famillesSold[i] > max) {
  //         max = famillesSold[i];
  //       }
  //     }
  //     max = max * 1.5;
  //     busy = false;
  //     notifyListeners();
  //   }
  // }
  // later 1
}
