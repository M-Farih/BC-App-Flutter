class CAFamille {
  final String total_ca,
      total_ca_Banquette,
      total_ca_Mousse,
      total_ca_Matelas,
      total_ca_Divers,
      ristourne;
  CAFamille(this.total_ca, this.total_ca_Banquette, this.total_ca_Mousse,
      this.total_ca_Matelas, this.total_ca_Divers, this.ristourne);

  dynamic toJson() => {
        'total_ca': total_ca,
        'total_ca_Banquette': total_ca_Banquette,
        'total_ca_Mousse': total_ca_Mousse,
        'total_ca_Matelas': total_ca_Matelas,
        'total_ca_Divers': total_ca_Divers,
        'ristourne': ristourne,
      };

  CAFamille.fromJson(Map<String, dynamic> json)
      : total_ca = json['total_ca'],
        total_ca_Banquette = json['total_ca_Banquette'],
        total_ca_Mousse = json['total_ca_Mousse'],
        total_ca_Matelas = json['total_ca_Matelas'],
        total_ca_Divers = json['total_ca_Divers'],
        ristourne = json['ristourne'];
}
