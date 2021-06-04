class Topic{
  final int idtopic, idtype_reason, idreason, indicator, iduser;
  final String description, record, type, reason, created_at, usersName, userImg, telephone;

  Topic(this.idtopic, this.idtype_reason, this.idreason, this.indicator, this.iduser, this.description, this.record, this.type, this.reason, this.created_at, this.usersName, this.userImg, this.telephone);

  dynamic toJson() => {
    'idtopic': idtopic, 'idtype_reason': idtype_reason,
    'idreason': idreason, 'indicator': indicator,
    'iduser': iduser, 'description': description,
    'record': record, 'type': type,
    'reason': reason, 'created_at': created_at,
    'usersName': usersName,
    'userImg' : userImg,
    'telephone': telephone
  };

  Topic.fromJson(Map<String, dynamic> json)
      : idtopic = json['idtopic'],
        idtype_reason = json['idtype_reason'],
        idreason = json['idreason'],
        indicator = json['indicator'],
        iduser = json['iduser'],
        description = json['description'],
        record = json['record'],
        type = json['type'],
        reason = json['reason'],
        created_at = json['created_at'],
        usersName = json['usersName'],
        userImg = json['profileImage'],
        telephone = json['telephone'];
}