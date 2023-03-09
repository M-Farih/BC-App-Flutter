class CA {
  final int total_ca_184;
  final int total_ca_365;
  final int payment_deadline;
  CA(this.total_ca_184, this.total_ca_365, this.payment_deadline);

  dynamic toJson() => {
        'total_ca_184': total_ca_184,
        'total_ca_365': total_ca_365,
        'payment_deadline': payment_deadline
      };

  CA.fromJson(Map<String, dynamic> json)
      : total_ca_184 = json['total_ca_184'],
        total_ca_365 = json['total_ca_365'],
        payment_deadline = json['payment_deadline'];
}
