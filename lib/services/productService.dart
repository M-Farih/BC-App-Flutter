import 'dart:convert';
import 'dart:io';
import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class ProductService extends BaseApi{

  Future<http.Response> getProducts(String id) async{
    return await api.httpGet('/products', '?famille=1');
  }

  Future<http.Response> getProductById(String id) async{
    return await api.httpGet('/products', '?id=$id');
  }

  Future<http.Response> addProduct(String name, String description, String image, String famille) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;

    Map<String, dynamic> body = {
      "name": "$name",
      "description": "$description",
      "image": "$image",
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    var _list = body.values.toList();
    String filePath = _list[2].toString();
    print('verif ---> ${_list[0].toString()}');
    print('verif ---> ${_list[1].toString()}');
    print('verif ---> ${_list[2].toString()}');

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
              Uri.parse('${api.baseUrl}/products/'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "name":  _list[0].toString(),
                "description":  _list[1].toString(),
                "image": '$fileLink',
                "famille": '$famille'
              }),
            ).then((response){
              print('product added:: ${response.body}');
            });
          }
        });
      });
    }
  }

  Future<http.Response> updateProduct(String name, String description, String image, String famille, String id) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${api.username}:${api.password}'));

    String fileLink;
    var response;

    Map<String, dynamic> body = {
      "name": "$name",
      "description": "$description",
      "image": "$image",
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://bc.meks.ma/BC/v1/common/'));
    request.headers.addAll({'Accept': 'Application/json', 'authorization': basicAuth});

    var _list = body.values.toList();
    String filePath = _list[2].toString();
    print('verif ---> ${_list[0].toString()}');
    print('verif ---> ${_list[1].toString()}');
    print('verif ---> ${_list[2].toString()}');

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
              Uri.parse('${api.baseUrl}/products/$id'),
              headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
              body: json.encode({
                "name":  _list[0].toString(),
                "description":  _list[1].toString(),
                "image": '$fileLink',
              }),
            ).then((response){
              print('product updated:: ${response.body}');
            });
          }
        });
      });
    }
  }

  Future<http.Response> deleteProduct(String id) async{
    return await api.httpDelete('/products', '$id');
  }
}