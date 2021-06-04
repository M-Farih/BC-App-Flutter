import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class AuthService extends BaseApi{
  Future<http.Response>login(String username, String password) async{
    return await api.httpGet("/users", "?userName=$username&password=$password");
  }

  Future<http.Response>getAllUsers() async{
    return await api.httpGet("/users", "");
  }

  Future<http.Response> getUserById(int id) async{
    return await api.httpGet('users', '?id=$id');
  }
}