import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:bc_app/views/widgets/sellerProductStatistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerDetails extends StatefulWidget {
  final int id;
  final String profileImg, phoneNumber, mail, username, password, solde, ristourne;

  SellerDetails({this.id, this.profileImg, this.phoneNumber, this.mail, this.username, this.password, this.solde, this.ristourne});

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
                                Navigator.of(context).pop();
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
                        Text('${userProvider.userById.firstName ??""} ${userProvider.userById.lastName ??""}',
                            style: TextStyle(color: Colors.white, fontSize: 25)),
                        Text('${widget.solde} Dhs',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Ristourne ${widget.ristourne}',
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ),

                  /// seller Statistics
                  SizedBox(height: 30),
                  sellerProductStatistics(
                    productImage: 'assets/images/matelas.png',
                    productName: 'Matelas',
                    productPrice: '3700',
                    textColor: 0xFF2C7DBF,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/banquette.png',
                    productName: 'Banquette',
                    productPrice: '8500',
                    textColor: 0xFF84489B,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/mousse.png',
                    productName: 'Mousse',
                    productPrice: '9500',
                    textColor: 0xFF81BA48,
                  ),
                  sellerProductStatistics(
                    productImage: 'assets/images/salon.png',
                    productName: 'Salon',
                    productPrice: '2100',
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
                            color: Color(0xFF2C7DBF),
                            borderRadius: BorderRadius.circular(50)
                          ),
                            child: Icon(Icons.call, color: Colors.white,)
                        ),
                        onTap:(){
                          print('appeler');
                          contactProvider.call('${widget.phoneNumber}');
                        },
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFF2C7DBF),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.mail, color: Colors.white,)
                        ),
                        onTap:(){
                          print('mail');
                          contactProvider.mailSeller('${widget.mail}');
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
