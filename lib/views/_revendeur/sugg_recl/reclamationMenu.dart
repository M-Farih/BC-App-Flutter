import 'package:bc_app/models/topic.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/listReclamation.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/reclamation.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/reclamationCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;


class ReclamationMenu extends StatefulWidget {
  @override
  _ReclamationMenuState createState() => _ReclamationMenuState();
}

class _ReclamationMenuState extends State<ReclamationMenu> {
  String agentPhone;
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP().whenComplete(() async {
        int idUser = Provider.of<AuthProvider>(context, listen: false).currentUsr.iduser;
        agentPhone = Provider.of<AuthProvider>(context, listen: false).currentUsr.agentPhone;
        Provider.of<TopicProvider>(context, listen: false).getSuggestions(idUser, 1);
        await Provider.of<TopicProvider>(context, listen: false).getReclamations(idUser, 2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    var topicProvider = Provider.of<TopicProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F7),
      body: topicProvider.isBusy
          ?Center(child: CircularProgressIndicator())
          :Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: [
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Color(0xFFFC8F6E)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('اقتراح جديد', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.thumb_up, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ReclamationPage(
                            idtype_reason: 1,
                          ))
                      );
                    },
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Color(0xFFF67B97)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('شكاية جديدة', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.feedback, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ReclamationPage(
                            idtype_reason: 2,
                          ))
                      );
                    },
                  ),
                  SizedBox(width: 10,),
                  agentPhone != null
                      ?GestureDetector(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Color(0xFF7D85E7)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('اتصال', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.call, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                    onTap: (){
                      contactProvider.call('${agentPhone}');
                    },
                  )
                      :GestureDetector(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Color(0xFF939393)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('اتصال', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.call, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              ///suggestion
              SizedBox(height: 40),
              topicProvider.suggestions.length <= 0
                  ?Text('لا يوجد اقتراحات', style: TextStyle(color: Colors.black54),)
                  :Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('اقتراحاتي', style: TextStyle(color: Color(0xFFFC8F6E), fontWeight: FontWeight.bold, fontSize: 20),),
                        ],
                      ),
                      ReclamationCard(
                        image: topicProvider.suggestions.first.userImg,
                        phone:topicProvider.suggestions.first.telephone,
                        reason: topicProvider.suggestions.first.reason,
                        rec_id: topicProvider.suggestions.first.idtopic,
                        status: topicProvider.suggestions.first.indicator,
                        date: topicProvider.suggestions.first.created_at,
                        dateToShow: timeago.format(DateTime.parse(topicProvider.suggestions.first.created_at), locale: 'ar'),
                        topic: topicProvider.suggestions.first.reason,
                        message: topicProvider.suggestions.first.description,
                        username: topicProvider.suggestions.first.usersName,
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: Color(0xFFFC8F6E), borderRadius: BorderRadius.circular(40)),
                          child: Icon(Icons.arrow_drop_down_rounded, size: 30, color: Colors.white),
                        ),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ListReclamation(
                                idreason: 1,
                              ))
                          );
                        },
                      ),
                    ],
                  ),


              ///reclamation
              Divider(),
              topicProvider.reclamations.length <= 0
                  ?Text('لا يوجد شكايات', style: TextStyle(color: Colors.black54))
                  :Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('شكاياتي', style: TextStyle(color: Color(0xFFF67B97), fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ),
                  ReclamationCard(
                    image: topicProvider.reclamations.first.userImg,
                    phone: topicProvider.reclamations.first.telephone,
                    reason: topicProvider.reclamations.first.reason,
                    rec_id: topicProvider.reclamations.first.idtopic,
                    status: topicProvider.reclamations.first.indicator,
                    date: topicProvider.reclamations.first.created_at,
                    dateToShow: timeago.format(DateTime.parse(topicProvider.reclamations.first.created_at), locale: 'ar'),
                    topic: topicProvider.reclamations.first.reason,
                    message: topicProvider.reclamations.first.description,
                    username: topicProvider.reclamations.first.usersName,
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: Color(0xFFF67B97), borderRadius: BorderRadius.circular(40)),
                      child: Icon(Icons.arrow_drop_down_rounded, size: 30,color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ListReclamation(
                            idreason: 2,
                          ))
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
