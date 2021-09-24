import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/commentProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/buildMessage.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReclamationDetails extends StatefulWidget {
  final int rec_id, status;
  final String Message, date, reason, img, phone, sellerName, record, topic;
  final bool isReclamation;

  ReclamationDetails(
      {this.rec_id, this.Message, this.status, this.date, this.reason, this.img, this.phone, this.sellerName, this.record, this.isReclamation, this.topic});

  @override
  _ReclamationDetailsState createState() => _ReclamationDetailsState();
}

class _ReclamationDetailsState extends State<ReclamationDetails> {
  TextEditingController messageController = new TextEditingController();

  AudioPlayer audioPlayer = AudioPlayer();

  String statusName;
  int statusColor;

  bool isPlayed = false;
  int position = 0;
  int audioDuration =0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CommentProvider>(context, listen: false)
          .getComments(widget.rec_id);
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });

    super.initState();

    switch (widget.status) {
      case 0:
        statusName = 'تم التوصل بها';
        statusColor = 0xFF2C7DBF;
        break;
      case 1:
        statusName = 'يتم معالجتها';
        statusColor = 0xFFFC8F6E;
        break;
      case 2:
        statusName = 'تمت المعالجة';
        statusColor = 0xFF1DC1C3;
        break;
    }
    print('-------- /  ${widget.reason}  /------------');
  }

  @override
  Widget build(BuildContext context) {
    var commentProvider = Provider.of<CommentProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    var topicProvider = Provider.of<TopicProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MyAppBar(
            isSeller: authProvider.currentUsr.idrole == 3 ? true : false, roleId: authProvider.currentUsr.idrole),
        body: commentProvider.isBusy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        ///back btn & icon-title
                        widget.reason == "2"
                            ?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      authProvider.currentUsr.idrole != 3
                                          ?Navigator.of(context).pop()
                                          :Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>HomePage_Revendeur(index: 2)
                                      ));
                                      },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.arrow_back, size: 16,),
                                            Text(
                                              authProvider.currentUsr.idrole == 3
                                                  ?'رجوع'
                                                  :'Retour',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      authProvider.currentUsr.idrole == 3
                                          ?'شكاية'
                                              :'Réclamation',
                                      style: TextStyle(
                                          color: Color(0xFFF67B97),
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(width: 15.0),
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF67B97),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Icon(Icons.feedback,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                            :Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.arrow_back, size: 16,),
                                            Text(
                                              authProvider.currentUsr.idrole == 3
                                                  ?'رجوع'
                                                  :'Retour',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      authProvider.currentUsr.idrole == 3
                                          ?'اقتراح'
                                          :'Suggestion',
                                      style: TextStyle(
                                          color: Color(0xFFFC8F6E),
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(width: 15.0),
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFC8F6E),
                                        borderRadius:
                                        BorderRadius.circular(50.0),
                                      ),
                                      child: Icon(Icons.thumb_up,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///Reclamation details
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(backgroundImage: NetworkImage(
                                            widget.img != ""
                                                ?'${widget.img.replaceAll('"', '').trim()}'
                                                :'https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${widget.sellerName}'
                                          ),),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${widget.sellerName}'),
                                            authProvider.currentUsr.idrole == 3
                                                ?Text('${widget.date}',
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Colors.black54))
                                                :Text('${widget.date}',
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Colors.black)),

                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 35,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Color(statusColor),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$statusName',
                                            style:
                                                TextStyle(color: Colors.white),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${widget.topic}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textDirection: TextDirection.rtl,
                                          //overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding
                                  (
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${widget.Message}',
                                          style: TextStyle(color: Colors.black),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                ///audio player
                                widget.record != ""
                                    ?Column(
                                  children: [
                                    Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            child: Icon(
                                              !isPlayed
                                                  ?Icons.play_arrow
                                                  :Icons.pause,
                                              size: 30.0,
                                            ),
                                            onTap: () {
                                              audioController(
                                                  !isPlayed
                                                      ?'play'
                                                      :'stop'
                                              );
                                              setState(() {
                                                isPlayed =
                                                !isPlayed;
                                              });
                                            }
                                        ),
                                        Slider(
                                          max: audioDuration.toDouble(),
                                          min: 0,
                                          value: position.toDouble(),
                                          onChanged: (v){},
                                        ),
                                        //Text('${audioDuration}'),
                                      ],
                                    ),
                                  ],
                                )
                                    :SizedBox(),

                              ],
                            ),
                          ),
                        ),
                        widget.status == 2
                            ? SizedBox(height: 20.0)
                            : SizedBox(),

                        /// btn send msg & btn call
                        widget.status != 2
                        ?Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: authProvider.currentUsr.idrole != 3
                              ?Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: true,
                                child: GestureDetector(
                                  child: ProfilInfoBtn(
                                    text: authProvider.currentUsr.idrole == 3
                                    ?'الرد' :'Répondre',
                                    color: 0xFF1B7DBB,
                                    textColor: 0xFFFFFFFF,
                                    btnHeight: 35.0,
                                    btnWidth: 120.0,
                                  ),
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      customHeader: Icon(
                                        Icons.mail_outline_rounded,
                                        size: 55,
                                      ),
                                      borderSide: BorderSide(
                                          color: Color(0xFF1B7DBB), width: 2),
                                      width: MediaQuery.of(context).size.width,
                                      buttonsBorderRadius:
                                          BorderRadius.all(Radius.circular(2)),
                                      headerAnimationLoop: false,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'INFO',
                                      desc: 'Dialog description here...',
                                      btnOkColor: Color(0xFF1B7DBB),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'ادخل الرسالة',
                                              border: null,
                                              hintStyle: TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            controller: messageController,
                                            keyboardType: TextInputType.multiline,
                                            minLines: 1,
                                            //Normal textInputField will be displayed
                                            maxLines:
                                                8, // when user presses enter it will adapt to it
                                          ),
                                        ),
                                      ),
                                      showCloseIcon: true,
                                      btnOkText: 'ارسال',
                                      btnOkOnPress: () {
                                        commentProvider.sendComment(
                                            authProvider.currentUsr.iduser,
                                            widget.rec_id,
                                            messageController.text,
                                            '${authProvider.currentUsr.firstName} ${authProvider.currentUsr.lastName}',
                                            authProvider.currentUsr.profileImage
                                        );
                                        topicProvider.updateTopic(widget.rec_id, 1);
                                        playSound();
                                        messageController.text = "";
                                      },
                                    )..show();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              widget.phone != ""
                                  ?Visibility(
                                visible: authProvider.currentUsr.idrole == 3 ?false :true,
                                child: GestureDetector(
                                  child: ProfilInfoBtn(
                                    text: 'Appeler',
                                    color: 0xFFFFFFFF,
                                    textColor: 0xFF1B7DBB,
                                    btnHeight: 35.0,
                                    btnWidth: 120.0,
                                  ),
                                  onTap: (){
                                    if(widget.phone != ""){
                                      contactProvider.call(widget.phone);
                                    }
                                  },
                                ),
                              )
                                  :SizedBox(),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF67B97),
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(Icons.lock, color: Colors.white, size: 19,),
                                ),
                                onTap: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('Êtes-vous sûr'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Clôturer', style: TextStyle(color: Colors.red),),
                                            onPressed: () {
                                              topicProvider.updateTopic(widget.rec_id, 2).then((value) => Navigator.of(context).pushReplacementNamed('home'));
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Fermer'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          )
                              :Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: widget.status ==1 ?true :false,
                                child: GestureDetector(
                                  child: ProfilInfoBtn(
                                    text: authProvider.currentUsr.idrole == 3
                                        ?'الرد' :'Répondre',
                                    color: 0xFF1B7DBB,
                                    textColor: 0xFFFFFFFF,
                                    btnHeight: 35.0,
                                    btnWidth: 120.0,
                                  ),
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      customHeader: Icon(
                                        Icons.mail_outline_rounded,
                                        size: 55,
                                      ),
                                      borderSide: BorderSide(
                                          color: Color(0xFF1B7DBB), width: 2),
                                      width: MediaQuery.of(context).size.width,
                                      buttonsBorderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                      headerAnimationLoop: false,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'INFO',
                                      desc: 'Dialog description here...',
                                      btnOkColor: Color(0xFF1B7DBB),
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'ادخل الرسالة',
                                              border: null,
                                              hintStyle: TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            controller: messageController,
                                            keyboardType: TextInputType.multiline,
                                            minLines: 1,
                                            //Normal textInputField will be displayed
                                            maxLines:
                                            8, // when user presses enter it will adapt to it
                                          ),
                                        ),
                                      ),
                                      showCloseIcon: true,
                                      btnOkText: 'ارسال',
                                      btnOkOnPress: () {
                                        commentProvider.sendComment(
                                            authProvider.currentUsr.iduser,
                                            widget.rec_id,
                                            messageController.text,
                                            '${authProvider.currentUsr.firstName} ${authProvider.currentUsr.lastName}',
                                          authProvider.currentUsr.profileImage
                                        );
                                        topicProvider.updateTopic(widget.rec_id, 1);
                                        playSound();
                                        messageController.text = "";
                                      },
                                    )..show();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                            ],
                          )
                        )
                        :SizedBox(),

                        /// cloture message
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: authProvider.currentUsr.idrole == 3
                              ?Text(widget.status == 2 ? 'لقد تمت معالجة طلبكم' : '', style: TextStyle(color: Colors.grey))
                              :Text(widget.status == 2 ? 'Demande clôturée' : '', style: TextStyle(color: Colors.grey),),

                        ),

                        ///responses
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: commentProvider.comments.length,
                            itemBuilder: (context, int index) {
                              return BuildMessage(
                                senderName: commentProvider.comments[index].Name,
                                senderId: commentProvider.comments[index].iduser,
                                name: commentProvider.comments[index].Name,
                                img: commentProvider.comments[index].image != "" ?commentProvider.comments[index].image.replaceAll('"', '').trim() :'https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${commentProvider.comments[index].Name}',
                                message: commentProvider.comments[index].comment,
                                senderRoleId: commentProvider.comments[index].idrole,
                                date: commentProvider.comments[index].created_at,
                              );
                            }),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void playSound() async {
    int result = await audioPlayer.play(
        'https://audio-previews.elements.envatousercontent.com/files/81335720/preview.mp3');
    if (result == 1) {
      print('sound played');
    } else {
      print('error');
    }
  }

  void audioController(String state) async {
    switch (state) {
      case 'play':
        print('****  ${widget.record.toString().replaceAll('"', '').trim()}');
        await audioPlayer.play('${widget.record.toString().replaceAll('"', '').trim()}');
        audioPlayer.onAudioPositionChanged.listen((Duration p) {
          setState(() => position = p.inSeconds);
        });

        audioPlayer.onDurationChanged.listen((Duration d) {
          setState(() => audioDuration = d.inSeconds);
          print('Max duration: $d');
        });

        break;
      case 'stop':
        audioPlayer?.pause();
        break;
    }
  }
}
