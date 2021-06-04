import 'dart:convert';

import 'package:bc_app/services/baseApi.dart';
import 'package:http/http.dart' as http;

class TopicService extends BaseApi{

  Future<http.Response> getTopics(int iduser, idtype_reason) async{
    return await api.httpGet('topics', '?iduser=$iduser&idtype_reason=$idtype_reason');
  }

  Future<http.Response> getTopicsByFiltres(int idtype_reason, int indicator) async{
    return await api.httpGet('topics', '?idtype_reason=$idtype_reason&indicator=$indicator');
  }

  Future<http.Response> updateTopic(int topicId, int indicator) async{
    return await api.httpPut('topics', '$topicId', jsonEncode({"indicator": indicator}));
  }

  Future<http.Response> getTopicCount(int idtype_reason, int indicator) async{
    return await api.httpGet('topics', 'count?indicator=$indicator&idtype_reason=$idtype_reason');
  }
}