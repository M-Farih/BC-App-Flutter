import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class ReasonService extends BaseApi{
  Future<http.Response> getReasons(int id) async{
    return await api.httpGet('/reasons', '?idtype_reason=$id');
  }
}