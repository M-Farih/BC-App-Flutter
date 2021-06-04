class Promotion{
  final int idpromo;
  final String promo;

  Promotion(this.idpromo, this.promo);

  dynamic toJson() => {'idpromo': idpromo, 'promo': promo};

  Promotion.fromJson(Map<String, dynamic> json)
      : idpromo = json['idpromo'],
        promo = json['promo'];
}