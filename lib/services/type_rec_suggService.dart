import 'package:bc_app/models/type_rec_sugg.dart';

class Type_rec_suggService{

  static List<Type_rec_sugg> trsList = List<Type_rec_sugg>();

  static Future <List<Type_rec_sugg>> fillTypes() async{

    Type_rec_sugg t1 = new Type_rec_sugg(1, "Suggestion");
    trsList.add(t1);

    Type_rec_sugg t2 = new Type_rec_sugg(2, "Reclamation");
    trsList.add(t2);

    return trsList;
  }


}