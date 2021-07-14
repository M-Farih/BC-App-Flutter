import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/nombre_total_revendeur_provider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/views/_admin/sugg_recc/ListReclamationsAdmin.dart';
import 'package:bc_app/views/product/productAdd.dart';
import 'package:bc_app/views/widgets/NombreRevendeurWidget.dart';
import 'package:bc_app/views/widgets/reclamationStatistiquesCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard_admin extends StatefulWidget {
  @override
  _Dashboard_adminState createState() => _Dashboard_adminState();
}

class _Dashboard_adminState extends State<Dashboard_admin> {
  final int colorRecus = 0xFF2C7DBF;
  final int colorEnCours = 0xFFFC8F6E;
  final int colorTraitees = 0xFF1DC1C3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('dashboard admin');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NombreTotalRevendeurProvider>(context, listen: false)
          .getStatisticsByCity();
      Provider.of<NombreTotalRevendeurProvider>(context, listen: false)
          .getSellersCount();

      Provider.of<TopicProvider>(context, listen: false)
          .getReclamationsRecuesCount();
      Provider.of<TopicProvider>(context, listen: false)
          .getReclamationsEnCoursCount();
      Provider.of<TopicProvider>(context, listen: false)
          .getReclamationsTraiteesCount();

      Provider.of<TopicProvider>(context, listen: false)
          .getSuggestionsRecuesCount();
      Provider.of<TopicProvider>(context, listen: false)
          .getSuggestionsEnCoursCount();
      Provider.of<TopicProvider>(context, listen: false)
          .getSuggestionsTraiteesCount();
      Provider.of<RistourneProvider>(context, listen: false).getRistourneImage();

    });
  }

  @override
  Widget build(BuildContext context) {
    var nbrRevendeur = Provider.of<NombreTotalRevendeurProvider>(context, listen: true);
    var topicProvider = Provider.of<TopicProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F7),
      body: nbrRevendeur.isBusy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Center(
                child: Column(
                  children: [
                    /// Statistiques
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30),
                          child: GestureDetector(
                            child: Text(
                              'Statistiques',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            onTap: (){
                              Navigator.of(context).pushNamed('add-user');
                            },
                          ),
                        ),
                      ],
                    ),
                    NombreRevendeurWidget(nbrRevendeur: nbrRevendeur),
                    SizedBox(height: 40,),

                    /// acces rapide
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF2C7DBF)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Text('Modifier une promotion', style: TextStyle(color: Colors.white, fontSize: 12),)
                                    authProvider.currentUsr.idrole == 0
                                        ?Text('Promotion  et Annonce', style: TextStyle(color: Colors.white, fontSize: 12),)
                                        :Text('Modifier une promotion', style: TextStyle(color: Colors.white, fontSize: 12),)

                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).pushNamed('add-promotion');
                              }
                          ),
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C7DBF)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ajouter un produit', style: TextStyle(color: Colors.white, fontSize: 13),)
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductAdd(isAdd: true)));
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C7DBF)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Modifier la ristourne', style: TextStyle(color: Colors.white, fontSize: 13),)
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).pushNamed('ristourne-page');
                              print('modifier restourne');
                            },
                          ),
                          authProvider.currentUsr.idrole == 0
                              ?GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C7DBF)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ajouter un admin', style: TextStyle(color: Colors.white, fontSize: 13),)
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).pushNamed('add-user');
                              print('add user');
                            },
                          )
                              :SizedBox()
                        ],
                      ),
                    ),

                    /// Reclamations
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Réclamations',
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              reclamationStatistiques(
                                  onClick: ()=> test(2, 0),
                                  wIcon: Icons.move_to_inbox,
                                  wColor: colorRecus,
                                  wCount: '${topicProvider.reclamationRecue}',
                                  wStatus: 'reçues'),
                              reclamationStatistiques(
                                  onClick: ()=> test(2, 1),
                                  wIcon: Icons.cached_sharp,
                                  wColor: colorEnCours,
                                  wCount: '${topicProvider.reclamationEnCours}',
                                  wStatus: 'En cours'),
                              reclamationStatistiques(
                                  onClick: ()=> test(2, 2),
                                  wIcon: Icons.check_circle_outline,
                                  wColor: colorTraitees,
                                  wCount: '${topicProvider.reclamationTraitee}',
                                  wStatus: 'Traitées'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    /// Suggestions
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suggestions',
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              reclamationStatistiques(
                                  onClick: ()=> test(1, 0),
                                  wIcon: Icons.move_to_inbox,
                                  wColor: colorRecus,
                                  wCount: '${topicProvider.suggestionRecue}',
                                  wStatus: 'reçues'),
                              reclamationStatistiques(
                                  onClick: ()=> test(1, 1),
                                  wIcon: Icons.cached_sharp,
                                  wColor: colorEnCours,
                                  wCount: '${topicProvider.suggestionEnCours}',
                                  wStatus: 'En cours'),
                              reclamationStatistiques(
                                  onClick: ()=> test(1, 2),
                                  wIcon: Icons.check_circle_outline,
                                  wColor: colorTraitees,
                                  wCount: '${topicProvider.suggestionTraitee}',
                                  wStatus: 'Traitées'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
  void test(int idtype_reason, int indicator){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListReclamationAdmin(idtype_reason: idtype_reason, indicator: indicator,)
        ));
  }
}


