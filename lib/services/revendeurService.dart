import 'package:bc_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class RevendeurService{

  /// add a new seller
  Future<http.Response> add(fname, lname, company, ice, city, address, telephone, clientNumber) {

    String myUrl = 'https://bc.meks.ma/BC/v1/revendeur/';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.post(Uri.parse(myUrl),
      headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
      body: json.encode({
        "firstName": fname,
        "lastName": lname,
        "userName": fname[0].toString()+lname,
        "password": ice,
        "entrepriseName": company,
        "ice": ice,
        "city": city,
        "address": address,
        "telephone": telephone,
        "clientNumber" : clientNumber
      }),
    ).then((response) => {
      print('Posted data:: ${response.body.toString()}')
    });
  }


  /// fetch all users
  Future<List<User>>getAllUsers() async{

    String myUrl = 'https://bc.meks.ma/BC/v1/revendeur/';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Response response = await http.get(
        Uri.parse(myUrl),
        headers: { 'Accept': 'Application/json', 'authorization': basicAuth}
    );

    List<User> users2 = [];
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);

      for(var i=0; i<data['data'].length; i++){
        User u = User(data["data"][i]["revendeur_id"], data["data"][i]["firstName"], data["data"][i]["lastName"],
            data["data"][i]["userName"], data["data"][i]["password"], data["data"][i]["entrepriseName"],
            data["data"][i]["ice"], data["data"][i]["city"], data["data"][i]["address"], data["data"][i]["telephone"], data["data"][i]["clientNumber"] );
        print('user ---*--*-**-*--  ${u.fname}');
        users2.add(u);
      }
    }

    List<User> users = [];
    User u1 = User(1, 'fname', 'lname', 'username', 'password', 'company', 'ice', 'city', 'address', 'telephone', 'cNumber');
    User u2 = User(2, 'fname2', 'lname2', 'username2', 'password2', 'company2', 'ice2', 'city2', 'address2', 'telephone2', 'cNumber2');
    users.add(u1);
    users.add(u2);
    return users2;
  }
  

  /// update user
  Future<http.Response> update(id, fname, lname, company, ice, city, address, telephone, clientNumber) {

    String myUrl = 'https://bc.meks.ma/BC/v1/revendeur/$id';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.put(Uri.parse(myUrl),
      headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
      body: json.encode({
        "firstName": fname,
        "lastName": lname,
        "userName": fname[0].toString()+lname,
        "password": ice,
        "entrepriseName": company,
        "ice": ice,
        "city": city,
        "address": address,
        "telephone": telephone,
        "clientNumber" : clientNumber
      }),
    ).then((response) => {
      print('Posted data:: ${response.body.toString()}')
    });
  }


  /// delete user
  Future<http.Response> delete(id) {

    String myUrl = 'https://bc.meks.ma/BC/v1/revendeur/$id';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.delete(Uri.parse(myUrl),
      headers: { 'Accept': 'Application/json', 'authorization': basicAuth})
        .then((response) => {
      print('deleted user:: ${response.body.toString()}')
    });
  }
}