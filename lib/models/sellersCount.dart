class SellersCount{

  final String city, count;

  SellersCount(this.count, this.city);

  dynamic toJson() => {'count(*)': count, 'city': city};

  SellersCount.fromJson(Map<String, dynamic> json)
      : count = json['count(*)'],
        city = json['city'];

}