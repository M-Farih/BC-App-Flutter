import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class MyNoteService extends BaseApi {
  Future<http.Response> note(int id, int caAn, int caM, int del) async {
    return await api.httpGet('/note', '?idvendor=$id&caAn=$caAn&caM=$caM&del=$del');
  }
}
