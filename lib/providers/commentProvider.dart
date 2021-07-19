import 'dart:convert';
import 'package:bc_app/models/message.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/services/commentService.dart';
import 'package:bc_app/services/topicService.dart';
import 'package:flutter/cupertino.dart';

class CommentProvider extends ChangeNotifier{

  bool isBusy = false;
  List<Comment> _comments = List();
  List<Comment> get comments => _comments;
  CommentService _commentService = CommentService();
  TopicService _topicService = TopicService();

  Future<List<Comment>> getComments(int id) async{
    isBusy = true;
    var response =  await _commentService.getComments(id);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      comments.clear();
      data['data'].forEach((c)=> _comments.add(Comment.fromJson(c)));
      isBusy = false;
      notifyListeners();
    }
    return _comments;
  }

  Future<void> sendComment(int iduser, idtopic, String comment, String username, String userImg) async{
    isBusy = true;
    notifyListeners();
    addCommentToCommentsList(iduser, idtopic, comment, username, userImg);
    var response = await _commentService.addComments(iduser, idtopic, comment);
    if(response.statusCode == 200 || response.statusCode == 201){
      var data = jsonDecode(response.body);
      print('comment added-> ${data['data']}');
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> addCommentToCommentsList(int iduser, idtopic, String comment, String username, String userImg){
    var now = DateTime.now();
    _comments.add(new Comment(iduser: iduser, idtopic: idtopic, comment: comment, created_at: now.toString(), Name: username, image: userImg));
  }

  Future<void> updateIndicator(topicId, indicator) async{
    isBusy = true;
    notifyListeners();
    var response = await _topicService.updateTopic(topicId, indicator);
    if(response.statusCode == 200){
      isBusy = false;
      notifyListeners();
    }
  }

}