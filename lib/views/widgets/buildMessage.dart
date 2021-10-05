import 'dart:convert';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildMessage extends StatefulWidget {
  final String name, date, message, senderName, img;
  final int senderId, senderRoleId;

  ///"https://bc.meks.ma/BC/uploaded_files/image/cc2b2aa97c41db11f89dfcdd4b121b59.png" logo BC

  BuildMessage({this.name, this.date, this.message, this.senderId, this.senderName, this.img, this.senderRoleId});

  @override
  _BuildMessageState createState() => _BuildMessageState();
}

class _BuildMessageState extends State<BuildMessage> {
  int messageColor = 0xFFFFFFFF;
  Alignment messageAlignement = Alignment.topLeft;
  BubbleNip nipDirection = BubbleNip.leftTop;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }

  ///admin box decoration
  BoxDecoration adminBoxDecoration = BoxDecoration(
    color: Color(0xFFFFFFFF),
    border: Border.all(color: Colors.blueAccent),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.red.withOpacity(0.1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  /// seller box decoration
  BoxDecoration sellerBoxDecoration = BoxDecoration(
    color: Color(0xFFFFFFFF),
    border: Border.all(color: Colors.redAccent),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.blueAccent.withOpacity(0.3),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    String userImage = authProvider.currentUsr.profileImage != "" ?authProvider.currentUsr.profileImage.replaceAll('"', '').trim() :"https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${authProvider.currentUsr.lastName}+${authProvider.currentUsr.firstName}";
    print('-----> ${widget.senderRoleId}');
    if(authProvider.currentUsr.idrole != 3){
      return authProvider.spbusy
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: widget.senderId == authProvider.currentUsr.iduser
              ? sellerBoxDecoration
              : adminBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.senderRoleId != 3
                        ?CircleAvatar(backgroundImage: AssetImage('assets/images/adminbc.png'))
                        :CircleAvatar(backgroundImage: NetworkImage(widget.img),),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.senderName}'),
                          Text('${widget.date}',
                              style: TextStyle(fontSize: 10.0, color: Colors.black54)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.message}',
                        style: TextStyle(),
                        textDirection: TextDirection.rtl,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0)
              ],
            ),
          ),
        ),
      );
    }
    else{
      return authProvider.spbusy
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: widget.senderId == authProvider.currentUsr.iduser
              ? sellerBoxDecoration
              : adminBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.senderRoleId != 3
                    ?CircleAvatar(backgroundImage: AssetImage('assets/images/adminbc.png'))
                    :CircleAvatar(backgroundImage: NetworkImage(widget.img),),

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authProvider.currentUsr.iduser == widget.senderId
                              ?Text('${widget.senderName}')
                              :Text(widget.senderRoleId != 3 ?'العميل' :'${widget.senderName}'),
                          Text('${widget.date}',
                              style: TextStyle(fontSize: 10.0, color: Colors.black54)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.message}',
                        style: TextStyle(),
                        textDirection: TextDirection.rtl,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0)
              ],
            ),
          ),
        ),
      );
    }
  }
}
