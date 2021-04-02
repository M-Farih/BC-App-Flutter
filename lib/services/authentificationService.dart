import 'dart:convert';
import 'package:bc_app/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationService {
  User user;
  String baseUrl = 'https://bc.meks.ma/BC/v1/';
  var error;
  bool isLogged = false;

  /// Login method
  Future<User> login(String userN, String userP) async {
    String myUrl = '${baseUrl}revendeur/?firstName=$userN&password=$userP';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password =
        '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Response response = await get(
      Uri.parse(myUrl),
      headers: {'Accept': 'Application/json', 'authorization': basicAuth},
    );
    if (response.body != null) {
      var data = jsonDecode(response.body);
      print("sss => ${data["data"].length}");

      if(data["data"].length > 0){
        print('success');
        isLogged = true;
        final prefs = await SharedPreferences.getInstance();
        final key = 'isLogged';
        final value = isLogged;
        prefs.setBool(key, value);

        error = true;
        ///fill user model
        user = User(
            data["data"][0]["revendeur_id"],
            data["data"][0]["firstName"],
            data["data"][0]["lastName"],
            data["data"][0]["userName"],
            data["data"][0]["password"],
            data["data"][0]["entrepriseName"],
            data["data"][0]["ice"],
            data["data"][0]["city"],
            data["data"][0]["address"],
            data["data"][0]["telephone"],
            data["data"][0]["clientNumber"]);

        _storeUserData(data);
      }else{
        print('account not found!');
        error = false;
      }

    }

    return user;
  }

  ///disconnecting method
  Future disconnect() async {
    var key = 'isLogged';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// check if user logged in
  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLogged';
    final value = prefs.get(key) ?? false;

    isLogged = value;

    return value;
  }

  /**
   * ******************************* User Information *******************************
   */

  /// store user information in shared preferences
  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    var user = responseData['data'];
    print('----------  $user');
    prefs.setString('user', json.encode(user));
  }

  /// get user from shared preferences
  void getUserinfo() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print(json.decode(storedUser));
    var user = json.decode(storedUser);
    return user;
  }
}
