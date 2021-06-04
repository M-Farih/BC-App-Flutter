import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class NombreTotalRevendeurService extends BaseApi{
  
  Future<http.Response> getSellersCount() async{
    return await api.httpGet('users', '?id=count');
  }

  Future<http.Response> getStatisticsByCity() async{
    return await api.httpGet('/cityStatistic', '');
  }

}