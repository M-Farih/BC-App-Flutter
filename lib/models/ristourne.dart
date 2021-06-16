class Ristourne {
  int idristourne;
  String min, max, percent;

  Ristourne(this.idristourne, this.min, this.max, this.percent);

  dynamic toJson() => {'idristourne': idristourne, 'min': min, 'max': max, 'percent': percent};

  Ristourne.fromJson(Map<String, dynamic> json)
      : idristourne = json['idristourne'],
        min = json['min'],
        max = json['max'],
        percent = json['percent'];

}