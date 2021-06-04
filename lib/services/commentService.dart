import 'dart:convert';
import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class CommentService extends BaseApi{
  Future<http.Response> getComments(int id) async{
    return await api.httpGet('/comments', '?idtopic=$id');
  }
  Future<http.Response> addComments(int iduser, idtopic, String comment) async{
    Map<String, dynamic> body = {
      "comment": comment,
      "idtopic": idtopic,
      "iduser": iduser
    };
    return await api.httpPost('/comments', '', jsonEncode(body));
  }
}