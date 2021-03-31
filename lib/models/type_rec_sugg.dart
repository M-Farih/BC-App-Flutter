class Type_rec_sugg{
  final int id;
  final String type;

  Type_rec_sugg(this.id, this.type);

  dynamic toJson() => {'id': id, 'type': type};

  Type_rec_sugg.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'];

}