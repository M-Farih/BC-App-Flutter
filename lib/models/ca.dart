class CA {
  final int total_ca_184;
  final int total_ca_365;
  final int payment_deadline;
  final String lastpurchasedate;
  CA(this.total_ca_184, this.total_ca_365, this.payment_deadline,
      this.lastpurchasedate);

  dynamic toJson() => {
        'total_ca_184': total_ca_184,
        'total_ca_365': total_ca_365,
        'payment_deadline': payment_deadline,
        'lastpurchasedate': lastpurchasedate,
      };

  CA.fromJson(Map<String, dynamic> json)
      : total_ca_184 = json['total_ca_184'],
        total_ca_365 = json['total_ca_365'],
        payment_deadline = json['payment_deadline'],
        lastpurchasedate = json['lastpurchasedate'];
}
