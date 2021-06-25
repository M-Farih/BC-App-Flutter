class Comment{
  final int idcomment, idtopic, iduser, idrole;
  final String comment, created_at, Name, image;


  Comment({this.idcomment, this.idtopic, this.iduser, this.comment, this.created_at, this.Name, this.image, this.idrole});

  dynamic toJson() => {'idcomment': idcomment, 'idtopic': idtopic, 'iduser': iduser, 'comment': comment, 'created_at': created_at, 'Name': Name, 'profileImage': image, 'idrole': idrole};

  Comment.fromJson(Map<String, dynamic> json)
      : idcomment = json['idcomment'],
        idtopic = json['idtopic'],
        iduser = json['iduser'],
        comment = json['comment'],
        created_at = json['created_at'],
        image = json['profileImage'],
        idrole = json['idrole'],
        Name = json['Name'];

}