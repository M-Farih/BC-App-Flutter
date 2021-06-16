import 'dart:convert';
import 'dart:io';
import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class PromotionService extends BaseApi{

  Future<http.Response> getPromos() async{
    return await api.httpGet('/promo', '?type=2');
  }

  Future<http.Response> getPdfLink() async{
    return await api.httpGet('/promo', '?type=1');
  }

  Future<http.Response> addPromo(String image) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;
    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    String filePath = image.toString();

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
            return http.post(
              Uri.parse('${api.baseUrl}/promo/'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "promo": "$fileLink",
                "type": 2
              }),
            ).then((response){
              print('product added:: ${response.body}');
            });
          }
        });
      });
    }
  }

  Future<http.Response> addPdf(String pdf) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;
    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    String filePath = pdf.toString();

    if(filePath != ""){
      print('00');
      request.files.add(
          http.MultipartFile(
              'file',
              File(filePath).readAsBytes().asStream(),
              File(filePath).lengthSync(),
              filename: filePath.split("/").last
          )
      );
      print('01');

      response = await request.send().then((result) async{
        print("111111  ${result}");
        http.Response.fromStream(result).then((response) async {
          print("222222  ${response.body}");
          if (true)
          {
            var pdfChecker = await api.httpGet('promo', '?type=1');
            var data = jsonDecode(pdfChecker.body);
            print('fff --> ${data['data'].toString().length}');
            if(data['data'].toString().length == 2){
              //no pdf found
              print('no pdf found');
              fileLink = response.body;
              fileLink = fileLink.replaceAll("\\", "");
              return http.post(
                Uri.parse('${api.baseUrl}/promo/'),
                headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
                body: json.encode({
                  "promo": "$fileLink",
                  "type": 1
                }),
              ).then((response){
                print('pdf added:: ${response.body}');
              });
            }
            else{
              //pdf found
              print('pdf found :)');
              fileLink = response.body;
              fileLink = fileLink.replaceAll("\\", "");
              Map<String, dynamic> body = {
                "promo": "${data['data'][0]['promo']}",
                "type" : "1"
              };
              return api.httpPut('/promo', '/${data['data'][0]['idpromo']}', jsonEncode(body)).then((value){
                print('pdf modified:: ${value.body}');
              });
            }
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
  
  Future<http.Response> deletePromo(String id)  async {
    return await api.httpDelete('promo', '$id');
  }

}