class Reason {
  final int idreason, idtype_reason;
  final String reason;
  Reason(this.idreason, this.idtype_reason, this.reason);

  dynamic toJson() =>
      {'idreason': idreason, 'idtype_reason': idtype_reason, 'reason': reason};

  Reason.fromJson(Map<String, dynamic> json)
      : idreason = json['idreason'],
        idtype_reason = json['idtype_reason'],
        reason = json['reason'];
}
