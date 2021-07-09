import 'dart:convert';
import 'dart:io';

import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseApi {

  AuthProvider authProvider = AuthProvider();

  Future<http.Response> add(String fname, String lname, String username, String password, String email, String telephone) async{
    Map<String, dynamic> body = {
      "firstName": "$fname",
      "lastName": "$lname",
      "userName": "$username",
      "email": "$email",
      "password": "$password",
      "telephone": "$telephone",
      "idrole": 1,
      "profileImage": "https://bc.meks.ma/BC/uploaded_files/dd8db778908ec77a6220bd3188ce0b81.png"
    };
    return await api.httpPost('users', '', jsonEncode(body));
  }

  Future<http.Response> update
      (int id, clientNumber, firstName, lastName, entrepriseName, ice,
      city, address, telephone, int role_id, profileImage, firstConnection) async {


    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;
    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    String filePath = profileImage.toString();

    if(filePath != ""){
      print('0');
      request.files.add(
          http.MultipartFile(
              'file',
              File(filePath).readAsBytes().asStream(),
              File(filePath).lengthSync(),
              filename: filePath.split("/").last
          )
      );
      print('1');

      response = await request.send().then((result) async{
        http.Response.fromStream(result).then((response){
          if (true)
          {
            fileLink = response.body;
            fileLink = fileLink.replaceAll("\\", "");
            return http.put(
              Uri.parse('${api.baseUrl}/users/$id'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "firstName": firstName,
                "lastName": lastName,
                "entrepriseName": entrepriseName,
                "ice": ice,
                "city": city,
                "code": clientNumber,
                "address": address,
                "telephone": telephone,
                "idrole": role_id,
                "iduser": id,
                "profileImage": fileLink
              }),
            ).then((response) async {
              print('user modified:: ${response.body}');
              authProvider.saveUserInSP(jsonDecode(response.body));
            });
          }
        });
      });
    }
    else{
      print('without imahe ++');
      response = await request.send().then((result) async{
        return http.put(
          Uri.parse('${api.baseUrl}/users/$id'),
          headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
          body: json.encode({
            "firstName": firstName,
            "lastName": lastName,
            "entrepriseName": entrepriseName,
            "ice": ice,
            "city": city,
            "code": clientNumber,
            "address": address,
            "telephone": telephone,
            "idrole": role_id,
            "iduser": id
          }),
        ).then((response) async {
          print('user modified:: ${response.body}');
          authProvider.saveUserInSP(jsonDecode(response.body));
        });
      });
    }
  }

  Future<http.Response> getSellersByAgent(int id) async{
    return await api.httpGet('users', '?agentIduser=$id');
  }

  Future<http.Response> getSellers() async{
    return await api.httpGet('users', '');
  }

  Future<http.Response> getSellersByidRole(String idrole) async{
    return await api.httpGet('users', '?idrole=$idrole');
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

  Future<http.Response> uploadCsv (String filePath) async{
    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String baseUrl = "https://bc.meks.ma/BC/v1";

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    String fileLink;
    var response;

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});



    if(filePath != ""){
      request.files.add(
          http.MultipartFile(
              'file',
              File(filePath).readAsBytes().asStream(),
              File(filePath).lengthSync(),
              filename: filePath.split("/").last
          )
      );

      response = await request.send().then((result) async{
        http.Response.fromStream(result).then((response) async {
          if (true)
          {
            fileLink = response.body;
            fileLink = fileLink.replaceAll("\\", "");
            print('file link ---> $fileLink}');

            fileLink = response.body;
            fileLink = fileLink.replaceAll("\\", "");

            return api.httpGet('/import_ca', '/?csv_file_path=$fileLink').then((value){
              print('Csv Uploaded:: ${value.body}');
            });

          }
        });
      });
    }
  }
}