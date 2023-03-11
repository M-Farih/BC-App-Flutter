import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class CAFamilleService extends BaseApi {
  Future<http.Response> getCAFamille(int id) async {
    return await api.httpGet('/ca_famille', '?idvendor=$id');
  }
}
