class MyNote {
  int note, solde;
  String notation, cat, total_nbrimp;
  MyNote(this.note, this.notation, this.solde, this.total_nbrimp, this.cat);

  dynamic toJson() => {
        'note': note,
        'notation': notation,
        'cat': cat,
        'solde': solde,
        'total_nbrimp': total_nbrimp
      };

  MyNote.fromJson(Map<String, dynamic> json)
      : note = json['note'],
        notation = json['notation'],
        solde = json['solde'],
        cat = json['cat'],
        total_nbrimp = json['total_nbrimp'];
}
