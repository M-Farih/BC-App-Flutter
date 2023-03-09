import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class CAService extends BaseApi {
  Future<http.Response> caByDate(int id) async {
    return await api.httpGet('/caByDate', '?idvendor=$id');
  }
}
