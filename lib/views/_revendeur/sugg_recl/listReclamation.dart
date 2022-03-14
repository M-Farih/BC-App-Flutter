import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/reclamationCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListReclamation extends StatefulWidget {
  final int idreason;

  const ListReclamation({Key key, this.idreason}) : super(key: key);
  @override
  _ListReclamationState createState() => _ListReclamationState();
}

class _ListReclamationState extends State<ListReclamation> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      var authProvider = Provider.of<AuthProvider>(context, listen: false).currentUsr;
      Provider.of<TopicProvider>(context, listen: false).getTopics(authProvider.iduser, widget.idreason);// iduser , idtype_reason
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var topicProvider = Provider.of<TopicProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false, roleId: authProvider.currentUsr.idrole),
        body: topicProvider.isBusy
            ?Center(child: CircularProgressIndicator())
            :SingleChildScrollView(
          child: Column(
            children: [
              ///back btn & icon-title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                authProvider.currentUsr.idrole == 3
                                    ?HomePage_Revendeur(index: 2)
                                    :authProvider.currentUsr.idrole == 2
                                    ?HomePage_Commercial(index: 2)
                                    :HomePage_admin(index: 2)
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: 80,
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_back, size: 17.0,),
                                  Text(
                                    'رجوع',
                                    style: TextStyle(fontSize: 17.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(
                            widget.idreason == 2 ?'شكاياتي' :'اقتراحاتي',
                            style: TextStyle(
                                color: widget.idreason == 2 ?Color(0xFFF67B97) :Color(0xFFFC8F6E), fontSize: 20.0),
                          ),
                          SizedBox(width: 15.0),
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: widget.idreason == 2 ?Color(0xFFF67B97) :Color(0xFFFC8F6E),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child:
                            Icon(widget.idreason == 2 ?Icons.feedback :Icons.thumb_up, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              ///list reclamation
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: topicProvider.topics.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, int index) {
                  return ReclamationCard(
                    image: topicProvider.topics[index].userImg,
                    phone: topicProvider.topics[index].telephone,
                    reason: topicProvider.topics[index].idtype_reason.toString(),
                    rec_id: topicProvider.topics[index].idtopic,
                    status: topicProvider.topics[index].indicator,
                    date: topicProvider.topics[index].created_at,
                    dateToShow: topicProvider.topics[index].created_at,
                    topic: topicProvider.topics[index].reason,
                    message: topicProvider.topics[index].description,
                    username: topicProvider.topics[index].usersName,
                    record: topicProvider.topics[index].record,
                    code: topicProvider.topics[index].code,
                    agentName: topicProvider.topics[index].agentName
                  );
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
