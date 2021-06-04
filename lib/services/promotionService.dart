import 'dart:convert';
import 'dart:io';

import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class PromotionService extends BaseApi{

  Future<http.Response> getPromos() async{
    return await api.httpGet('/promo', '');
  }


  Future<http.Response> addPromo(String image) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;


    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    String filePath = image.toString();

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
            return http.post(
              Uri.parse('${api.baseUrl}/promo/'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "promo": "$fileLink"
              }),
            ).then((response){
              print('promo added:: ${response.body}');
            });
          }
        });
      });
    }
  }

  Future<http.Response> updatePromo(String image, String idpromo) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    String filePath = image.toString();

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
            return http.put(
              Uri.parse('${api.baseUrl}/promo/$idpromo'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "promo": "$fileLink"
              }),
            ).then((response){
              print('promo updated:: ${response.body}');
            });
          }
        });
      });
    }
  }

}