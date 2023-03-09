import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/ReclamationDetails.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListReclamationAdmin extends StatefulWidget {
  final int idtype_reason, indicator;

  const ListReclamationAdmin({Key key, this.idtype_reason, this.indicator})
      : super(key: key);

  @override
  _ListReclamationAdminState createState() => _ListReclamationAdminState();
}

class _ListReclamationAdminState extends State<ListReclamationAdmin> {
  int statusColor = 0xFF2C7DBF;
  String statusName;

  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      Provider.of<TopicProvider>(context, listen: false)
          .getReclamationByFiltres(widget.idtype_reason, widget.indicator);
    });

    switch (widget.indicator) {
      case 0:
        setState(() {
          statusColor = 0xFF2C7DBF;
          statusName = "reçue";
        });
        break;
      case 1:
        setState(() {
          statusColor = 0xFFFC8F6E;
          statusName = "En cours";
        });
        break;
      case 2:
        setState(() {
          statusColor = 0xFF1DC1C3;
          statusName = "Traitée";
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var topicProvider = Provider.of<TopicProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F7),
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false, roleId: authProvider.currentUsr.idrole,),
      body: topicProvider.isBusy
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [

          /// back btn & icon-title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('home');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 100,
                          height: 40,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.arrow_back),
                              Text(
                                'Retour',
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(widget.idtype_reason == 2 ?'Réclamations' : 'Suggestion',
                        style: TextStyle(
                            color: Color(widget.idtype_reason == 2 ? 0xFFF67B97 :0xFFFC8F6E), fontSize: 20)),
                  )
                ],
              )
            ],
          ),

          /// Reclamation Container
          Expanded(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              height: MediaQuery.of(context).size.height * 0.90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
              ),
              child: topicProvider.topics.length != 0
                  ?ListView.builder(
                shrinkWrap: true,
                itemCount: topicProvider.topics.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: Color(
                                0xFFCBCBCB)),
                          ),
                        ),
                        child: ListTile(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('${topicProvider.topics[index].usersName}', overflow: TextOverflow.ellipsis,),
                                      width: MediaQuery.of(context).size.width * 0.3,
                                    ),
                                    Text('$statusName',
                                        style: TextStyle(color: Color(statusColor))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(topicProvider.topics[index].code, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: Colors.blue.withOpacity(0.8)),),
                                      width: MediaQuery.of(context).size.width * 0.3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      '${topicProvider.topics[index].description}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Text(
                                    '${topicProvider.topics[index].created_at.substring(0, 16)}'),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                topicProvider.topics[index].userImg != ""
                                    ?NetworkImage('${topicProvider.topics[index].userImg.toString().replaceAll('"','').trim()}')
                                    :NetworkImage("https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${topicProvider.topics[index].usersName}")
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>ReclamationDetails(
                                        img: topicProvider.topics[index].userImg.toString().replaceAll('"','').trim(),
                                        status: topicProvider.topics[index].indicator,
                                        reason: topicProvider.topics[index].idtype_reason.toString(),
                                        Message: topicProvider.topics[index].description,
                                        rec_id: topicProvider.topics[index].idtopic,
                                        date: topicProvider.topics[index].created_at,
                                        phone: topicProvider.topics[index].telephone,
                                        sellerName: topicProvider.topics[index].usersName,
                                        record: topicProvider.topics[index].record,
                                        topic: topicProvider.topics[index].reason,
                                        code: topicProvider.topics[index].code,
                                        agentName: topicProvider.topics[index].agentName
                                      ))
                              );
                            }

                        )),
                  );
                },
              )
                  :Center(child: Text('Aucune donnée à afficher'),)

            ),
          )
        ],
      ),
    );
  }
}
