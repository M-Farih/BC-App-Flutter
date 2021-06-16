import 'dart:convert';

import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseApi {


  Future<http.Response> add(String fname, String lname, String username, String password, String email, String telephone) async{
    Map<String, dynamic> body = {
      "firstName": "$fname",
      "lastName": "$lname",
      "userName": "$username",
      "email": "$email",
      "password": "$password",
      "telephone": "$telephone",
      "idrole": 1
    };
    return await api.httpPost('users', '', jsonEncode(body));
  }
  

  Future<http.Response> update
      (String id, firstName, lastName, entrepriseName, ice,
      city, address, telephone, role_id, profileImage) async {
    Map<String, dynamic> user = {
      "firstName": firstName,
      "lastName": lastName,
      "entrepriseName": entrepriseName,
      "ice": ice,
      "city": city,
      "address": address,
      "telephone": telephone,
      "idrole": role_id,
      "profileImage": profileImage,
      "iduser": id,
      "userName": "revendeur",
    };

    return await api.httpPutWithFile("/users", "$id", jsonEncode(user));
  }

  Future<http.Response> getSellersByAgent(int id) async{
    return await api.httpGet('users', '?agentIduser=$id');
  }

  Future<http.Response> getSellers() async{
    return await api.httpGet('users', '');
  }

  Future<http.Response> getSellerById(int id) async{
    return await api.httpGet('users', '?id=$id');
  }

  Future<http.Response> updateUsernameAndPassword (id, username, password) async{
    Map<String, dynamic> user = {
      "userName": "$username",
      "password": "$password"
    };
    return await api.httpPut("/users", "$id", jsonEncode(user));
  }
}