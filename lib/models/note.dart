class MyNote {
  final int note;
  final String notation;
  final int solde;
  final String total_nbrimp;
  MyNote(this.note, this.notation, this.solde, this.total_nbrimp);

  dynamic toJson() => {
        'note': note,
        'notation': notation,
        'solde': solde,
        'total_nbrimp': total_nbrimp
      };

  MyNote.fromJson(Map<String, dynamic> json)
      : note = json['note'],
        notation = json['notation'],
        solde = json['solde'],
        total_nbrimp = json['total_nbrimp'];
}
