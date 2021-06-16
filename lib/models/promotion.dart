class Promotion{
  final int idpromo, type;
  final String promo;

  Promotion(this.idpromo, this.promo, this.type);

  dynamic toJson() => {'idpromo': idpromo, 'promo': promo, 'type': type};

  Promotion.fromJson(Map<String, dynamic> json)
      : idpromo = json['idpromo'],
        type = json['type'],
        promo = json['promo'];
}