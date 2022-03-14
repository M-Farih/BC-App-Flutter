import 'dart:convert';
import 'dart:io';

import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RistourneService extends BaseApi{

  Future<http.Response> getRistournes() async{
    return await api.httpGet('/ristourne', '');
  }

  Future<http.Response> addRistourne(String min, String max, String percent) async{
    Map<String, dynamic> body;
    if(max == ""){
      body = {
        "min": double.parse(min),
        // "max": double.parse(max),
        "max": -1,
        "percent": "${percent + '%'}"
      };
    }
    else{
      body = {
        "min": double.parse(min),
        "max": double.parse(max),
        "percent": "${percent + '%'}"
      };
    }

    return await api.httpPost('/ristourne', '',jsonEncode(body));
  }

  Future<http.Response> updateRistourne(String id, String min, String max, String percent) async{
    Map<String, dynamic> body;
    if(max == ""){
      body = {
        "min": double.parse(min),
        // "max": double.parse(max),
        "max": -1,
        "percent": "${percent + '%'}"
      };
    }
    else{
      body = {
        "min": double.parse(min),
        "max": double.parse(max),
        "percent": "${percent + '%'}"
      };
    }
    return await api.httpPut('/ristourne', '$id',jsonEncode(body));
  }

  Future<http.Response> deleteRistourne(String id) async{
    return await api.httpDelete('/ristourne', '$id');
  }

  Future<http.Response> getRistourneImage() async{
    return await api.httpGet('/promo', '?type=3');
  }

  Future<http.Response> uploadRistournePicture(String filePath) async{

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String baseUrl = "https://bc.meks.ma/BC/v1";

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    String fileLink;
    var response;

    var request = http.MultipartRequest('POST', Uri.parse('${api.baseUrl}/common/'));
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

            var ristourneChecker = await api.httpGet('promo', '?type=3');
            var data = jsonDecode(ristourneChecker.body);
            if(data['data'].toString().length == 2){
              //no pdf found
              fileLink = response.body;
              fileLink = fileLink.replaceAll("\\", "");
              return http.post(
                Uri.parse('${api.baseUrl}/promo/'),
                headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
                body: json.encode({
                  "promo": "$fileLink",
                  "type": 3
                }),
              );
            }
            else{
              //pdf found
              fileLink = response.body;
              fileLink = fileLink.replaceAll("\\", "");
              Map<String, dynamic> body = {
                "promo": "$fileLink",
                "type" : "3"
              };
              return api.httpPut('/promo', '/${data['data'][0]['idpromo']}', jsonEncode(body));
            }
          }
        });
      });
    }
  }
}