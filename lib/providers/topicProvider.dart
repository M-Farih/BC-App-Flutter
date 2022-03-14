import 'dart:convert';

import 'package:bc_app/models/topic.dart';
import 'package:bc_app/services/topicService.dart';
import 'package:flutter/cupertino.dart';

class TopicProvider extends ChangeNotifier{
  bool isBusy = true;
  int reclamationRecue = 0, reclamationEnCours = 0, reclamationTraitee = 0, suggestionRecue = 0, suggestionEnCours = 0, suggestionTraitee = 0;
  TopicService _topicService = TopicService();
  List<Topic> _topics =List();
  List<Topic> get topics  => _topics;

  List<Topic> _suggestions =List();
  List<Topic> get suggestions  => _suggestions;

  List<Topic> _reclamations =List();
  List<Topic> get reclamations  => _reclamations;

  Future<List<Topic>> getTopics(int iduser, int idtype_reason) async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopics(iduser, idtype_reason);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _topics.clear();
      data['data'].forEach((t)=>_topics.add(Topic.fromJson(t)));
      isBusy = false;
      notifyListeners();
    }
    return _topics;
  }

  Future<List<Topic>> getSuggestions(int iduser, int idtype_reason) async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopics(iduser, idtype_reason);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _suggestions.clear();
      data['data'].forEach((t)=>_suggestions.add(Topic.fromJson(t)));
      isBusy = false;
      notifyListeners();
    }
    return _topics;
  }

  Future<List<Topic>> getReclamations(int iduser, int idtype_reason) async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopics(iduser, idtype_reason);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _reclamations.clear();
      data['data'].forEach((t)=>_reclamations.add(Topic.fromJson(t)));
      isBusy = false;
      notifyListeners();
    }
    return _topics;
  }

  Future<List<Topic>> getReclamationByFiltres(int idtype_reason, int indicator) async{
    isBusy = true;
    var response = await _topicService.getTopicsByFiltres(idtype_reason, indicator);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _topics.clear();
      data['data'].forEach((t)=>_topics.add(Topic.fromJson(t)));
      isBusy = false;
      notifyListeners();
    }
    return _topics;
  }

  Future<void> updateTopic(int topicId, int indicator) async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.updateTopic(topicId, indicator);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = response.body;
    }
  }

  Future<int> getTopicCount(int idtype_reason, int indicator) async{
    int count = 0;
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(idtype_reason, indicator);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = response.body;
    }
  }



/// ----------- get reclamations counts
  Future<void> getReclamationsRecuesCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(2, 0);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      reclamationRecue = data['count'];
    }
  }

  Future<void> getReclamationsEnCoursCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(2, 1);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      reclamationEnCours = data['count'];
    }
  }

  Future<void> getReclamationsTraiteesCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(2, 2);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      reclamationTraitee = data['count'];
    }
  }

/// ----------- get suggestions counts
  Future<void> getSuggestionsRecuesCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(1, 0);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      suggestionRecue = data['count'];
    }
  }

  Future<void> getSuggestionsEnCoursCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(1, 1);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      suggestionEnCours = data['count'];
    }
  }

  Future<void> getSuggestionsTraiteesCount() async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.getTopicCount(1, 2);
    isBusy = false;
    notifyListeners();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      suggestionTraitee = data['count'];
    }
  }
}