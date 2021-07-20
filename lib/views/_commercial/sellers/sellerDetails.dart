import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:bc_app/views/widgets/sellerProductStatistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerDetails extends StatefulWidget {
  final int id;
  final String profileImg, phoneNumber, mail, username, password, solde, ristourne, matelas, banquette, mousse, divers, from, to;

  SellerDetails({this.id, this.profileImg, this.phoneNumber, this.mail, this.username, this.password, this.solde, this.ristourne, this.matelas, this.banquette, this.mousse, this.divers, this.from, this.to});

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserProvider>(context, listen: false)
          .getSellerById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F7),
      appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false, roleId: authProvider.currentUsr.idrole),
      body: userProvider.busy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.arrow_back, size: 17),
                                    Text(
                                      'رجوع',
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// seller card
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/user-card.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white, width: 5)),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('${widget.profileImg}'),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('${userProvider.userById.firstName ??""} ${userProvider.userById.lastName ??""}',
                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                  overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              width: MediaQuery.of(context).size.width * 0.75,
                            ),
                          ],
                        ),
                        Text('${widget.solde} Dhs',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Ristourne ${widget.ristourne}',
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                        Text('Depuis le ${widget.from} au ${widget.to}',
                            style: TextStyle(color: Colors.white, fontSize: 12.5)),
                      ],
                    ),
                  ),

                  /// seller Statistics
                  SizedBox(height: 30),
                  sellerProductStatistics(
                    productImage: 'assets/images/matelas.png',
                    familleName: 'Matelas',
                    famillePrice: '${widget.matelas}',
                    textColor: 0xFF2C7DBF,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/banquette.png',
                    familleName: 'Banquette',
                    famillePrice: '${widget.banquette}',
                    textColor: 0xFF84489B,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/mousse.png',
                    familleName: 'Mousse',
                    famillePrice: '${widget.mousse}',
                    textColor: 0xFF81BA48,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/salon.png',
                    familleName: 'Salon',
                    famillePrice: '${widget.divers}',
                    textColor: 0xFFE32A33,
                  ),

                  ///btn
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: widget.phoneNumber != "" ? Color(0xFF2C7DBF) :Color(0xFFA0A0A0),
                            borderRadius: BorderRadius.circular(50)
                          ),
                            child: Icon(Icons.call, color: Colors.white,)
                        ),
                        onTap:(){
                          print('appeler ${widget.phoneNumber}');
                          widget.phoneNumber != "" ?contactProvider.call('${widget.phoneNumber}') :print('walo');
                        },
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: widget.mail != "" ? Color(0xFF2C7DBF) :Color(0xFFA0A0A0),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.mail, color: Colors.white,)
                        ),
                        onTap:(){
                          widget.mail != "" ?contactProvider.mailSeller('${widget.mail}') :print('walo');
                        },
                      ),
                    ],
                  )
                ],
              ),
          ),
    );
  }
}
