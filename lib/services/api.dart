import 'dart:convert';
import 'dart:io';
import 'package:bc_app/models/user.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Api {
  static final _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  /// https://bc.meks.ma/BC/v1   /users   ?userName=MFarih&password=j4574287

  String username = 'TelcoBill_Api_User_V2|1|6';
  String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
  String baseUrl = "https://bc.meks.ma/BC/v1";


  Future<http.Response> httpGet(String path, String endPoint) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await http.get(
        Uri.parse('$baseUrl/$path/$endPoint'),
        headers: {'Accept': 'Application/json', 'authorization': basicAuth},
    );
    //print('get data => ${response.statusCode}');
    return response;
  }

  Future<http.Response> httpPost(String path, String endPoint, Object body) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await http.post(
      Uri.parse('$baseUrl/$path/$endPoint'),
      headers: {'Accept': 'Application/json', 'authorization': basicAuth},
      body: body
    );
    print('post data => ${response.statusCode}');
    return response;
  }

  Future<http.Response> httpPostWithFile(String path, Object body) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    String fileLink;
    var response;

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    var object = jsonDecode(body);
    String filePath = object['record'];
    String description = object['description'];
    int idreason = object['idreason'];
    int iduser = object['iduser'];

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
        http.Response.fromStream(result).then((response){
          if (true)
          {
            fileLink = response.body;
            fileLink = fileLink.replaceAll("\\", "");
            http.post(
              Uri.parse('$baseUrl/$path/'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "description": object['description'],
                "record": '$fileLink',
                "idreason": object['idreason'],
                "iduser": object['iduser']
              }),
            ).then((response){
              print('reclamation added:: ${response.body}');
            });
          }
        });
      });
    }
    else{
      http.post(
        Uri.parse('$baseUrl/$path/'),
        headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
        body: json.encode({
          "description": object['description'],
          "record": '$fileLink',
          "idreason": object['idreason'],
          "iduser": object['iduser']
        }),
      ).then((response){
        print('updated user:: ${response.body}');
      });
    }
    return response;
  }

  Future<http.Response> httpPut(String path, String endPoint, Object body) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var response = await http.put(
        Uri.parse('$baseUrl/$path/$endPoint'),
        headers: {'Accept': 'Application/json', 'authorization': basicAuth},
        body: body
    );
    print('api / put data => ${response.statusCode}');

    return response;
  }

  Future<http.Response> httpPutWithFile(String path, String endPoint, Object body) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var response;

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    var object = jsonDecode(body);
    String imagePath = object['profileImage'];
    print('------ $imagePath');

    if(imagePath != ""){
      request.files.add(
          http.MultipartFile(
              'file',
              File(imagePath).readAsBytes().asStream(),
              File(imagePath).lengthSync(),
              filename: imagePath.split("/").last
          )
      );

      response = await request.send().then((result) async{
        http.Response.fromStream(result).then((response){
          if (true)
          {
            print("Uploaded! ");
            print('response.body '+response.body);

            String fileLink = response.body;
            fileLink = fileLink.replaceAll("\\", "");

            print('final link -> $fileLink');

            http.put(
              Uri.parse('$baseUrl/$path/$endPoint'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "iduser": 39,
                "idvendor": 0,
                "idagent": 0,
                "firstName": object['firstName'],
                "lastName": object['lastName'],
                "password": object['password'],
                "entrepriseName": object['entrepriseName'],
                "ice": object['ice'],
                "city": object['city'],
                "address": object['address'],
                "telephone": object['telephone'],
                "code": "ce45455",
                "clientNumber": object['clientNumber'],
                "agentIduser": 1,
                "idrole": 3,
                "profileImage": fileLink,
              }),
            ).then((response) async {

              if(response.statusCode == 200){
                var data = jsonDecode(response.body);
                print('updated user:: ${response.body}');
                print("1");
                AuthProvider ap = new AuthProvider();
                await ap.saveUserInSP(data).then((value) async {
                  await ap.getUserFromSP();
                });
                print("2");
              }
            });
          }
        });
      });
    }
    else{
      print('update without image...');
      http.put(
        Uri.parse('$baseUrl/$path/$endPoint'),
        headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
        body: json.encode({
          "iduser": 39,
          "idvendor": 0,
          "idagent": 0,
          "firstName": object['firstName'],
          "lastName": object['lastName'],
          "password": object['password'],
          "entrepriseName": object['entrepriseName'],
          "ice": object['ice'],
          "city": object['city'],
          "address": object['address'],
          "telephone": object['telephone'],
          "code": "ce45455",
          "clientNumber": object['clientNumber'],
          "agentIduser": 1,
          "idrole": 3,
          "profileImage": ""
        }),
      ).then((response) async {
        print('update without image... 222');
        print('status code---> ${response.statusCode}');
        print('status body---> ${response.body}');
        if(response.statusCode == 200){
          var data = jsonDecode(response.body);
          print('updated user:: ${response.body}');
          print("1");
          AuthProvider ap = new AuthProvider();
          await ap.saveUserInSP(data).then((value) async{
            await ap.getUserFromSP();
          });
          print("2");
        }
      });
    }
    return response;
  }

  Future<http.Response> httpDelete(String path, String endPoint) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await http.delete(
        Uri.parse('$baseUrl/$path/$endPoint'),
        headers: {'Accept': 'Application/json', 'authorization': basicAuth},
    );
    print('delete data => ${response.statusCode}');
    return response;
  }

}