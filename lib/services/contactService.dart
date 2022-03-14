import 'dart:convert';

import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class ContactService extends BaseApi{

  Future<http.Response> mail(String username, telephone, email) async{
    Map<String, String> mail ={
      "username" : username,
      "tel" : telephone,
      "email" : email
    };
    return await api.httpPost("mail", "", jsonEncode(mail));
  }

  Future<http.Response> rec_sugg(int iduser, int idreason, String description, String record) async{

    Map<String, dynamic> content = {
      "description": description,
      "record": record,
      "idreason": idreason,
      "iduser": iduser
    };
    return await api.httpPostWithFile('topics', jsonEncode(content));
  }
}