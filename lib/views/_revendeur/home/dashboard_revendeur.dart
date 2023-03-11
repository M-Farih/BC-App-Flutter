import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/caFamilleProvider.dart';
import 'package:bc_app/providers/caProvider.dart';
import 'package:bc_app/providers/myNoteProvider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/views/widgets/TextLinesCard.dart';
import 'package:bc_app/views/widgets/ristourneWidget.dart';
import 'package:bc_app/views/widgets/sliderVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Dashboard_revendeur extends StatefulWidget {
  @override
  _Dashboard_revendeurState createState() => _Dashboard_revendeurState();
}

class _Dashboard_revendeurState extends State<Dashboard_revendeur> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<RistourneProvider>(context, listen: false)
          .getRistourneImage();
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      int iduser =
          Provider.of<AuthProvider>(context, listen: false).currentUsr.iduser;
      int idvendor =
          Provider.of<AuthProvider>(context, listen: false).currentUsr.idvendor;
      Provider.of<CaProvider>(context, listen: false).getCA(idvendor);
      Provider.of<CaFamilleProvider>(context, listen: false)
          .getCAFamille(idvendor);

      // Provider.of<AuthProvider>(context, listen: false).getUserSolde(iduser);
      // later 1

      // NOTE ======================================
      print("dddddddddddddddddddddddddddddddddddd");
      // int kk =
      //     Provider.of<CaProvider>(context, listen: false).ca.first.total_ca_184;
      // print(kk);
      // print("homa hado " +
      //     Provider.of<MyNoteProvider>(context, listen: false).getMyNote(idvendor, 8, 55, 8).toString());
      // Provider.of<MyNoteProvider>(context, listen: false)
      //     .getMyNote(idvendor, 87557, 5087, 4);

      // Provider.of<MyNoteProvider>(context, listen: false).getMyNote(
      //     idvendor,
      //     Provider.of<CaProvider>(context, listen: true).ca[0].total_ca_365,
      //     Provider.of<CaProvider>(context, listen: true).ca[0].total_ca_184,
      //     Provider.of<CaProvider>(context, listen: true)
      //         .ca[0]
      //         .payment_deadline);
      // Provider.of<MyNoteProvider>(context, listen: false).getMyNote(
      //     idvendor,
      //     Provider.of<CaProvider>(context, listen: false).ca[0].total_ca_365,
      //     Provider.of<CaProvider>(context, listen: false).ca[0].total_ca_184,
      //     Provider.of<CaProvider>(context, listen: false)
      //         .ca[0]
      //         .payment_deadline);
    });
  }

  @override
  Widget build(BuildContext context) {
    var ristourneProvider =
        Provider.of<RistourneProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var caProvider = Provider.of<CaProvider>(context, listen: true);
    var caFamilleProvider =
        Provider.of<CaFamilleProvider>(context, listen: true);
    var noteProvider = Provider.of<MyNoteProvider>(context, listen: true);

    Provider.of<MyNoteProvider>(context, listen: false).getMyNote(
        authProvider.currentUsr.idvendor,
        caProvider.ca.first.total_ca_365,
        caProvider.ca.first.total_ca_184,
        caProvider.ca.first.payment_deadline);

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2C7DBF),
      body:
          // ristourneProvider.isBusy
          //     ? Center(child: CircularProgressIndicator())
          //     : authProvider.busy
          //         ? Center(child: CircularProgressIndicator())
          //         : caProvider.isBusy
          //             ? Center(child: CircularProgressIndicator())
          //             :
          SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      'المردود السنوي لسنة ${DateTime.now().year}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                    child: Text(
                      '${caFamilleProvider.caFamille.first.ristourne}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                    child: Text(
                      caFamilleProvider.caFamille.first.total_ca != null
                          ? '${caFamilleProvider.caFamille.first.total_ca} Dhs'
                          : '--- Dhs',
                      // later
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              RatingBar.builder(
                initialRating: double.parse(noteProvider.myNote.first.cat),
                itemSize: 30.0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 1.05,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 14,
                    // ),
                    // RatingBar.builder(
                    //   initialRating:
                    //       double.parse(noteProvider.myNote.first.cat),
                    //   itemSize: 30.0,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   ignoreGestures: true,
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ),
                    //   onRatingUpdate: (double value) {
                    //     print(value);
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Text(
                            'المردود',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SliderVerticalWidget(
                            imgUrl: 'assets/images/mousse.png',
                            title: 'بونج',
                            turnover: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca_Mousse) ??
                                0.0,
                            maxi: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca) ??
                                0.0,
                          ),
                          SliderVerticalWidget(
                            imgUrl: 'assets/images/salon.png',
                            title: 'مختلف',
                            turnover: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca_Divers) ??
                                0.0,
                            maxi: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca) ??
                                0.0,
                          ),
                          SliderVerticalWidget(
                            imgUrl: 'assets/images/banquette.png',
                            title: 'سداري',
                            turnover: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca_Banquette) ??
                                0.0,
                            maxi: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca) ??
                                0.0,
                          ),
                          SliderVerticalWidget(
                            imgUrl: 'assets/images/matelas.png',
                            title: 'ماطلة',
                            turnover: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca_Matelas) ??
                                0.0,
                            maxi: double.parse(caFamilleProvider
                                    .caFamille.first.total_ca) ??
                                0.0,
                          ),
                        ],
                      ),
                    ),
                    // double.parse(authProvider.currentUsr.ca) >=
                    //         10000.0
                    // later
                    10000.0 >= 10000.0
                        ? Column(
                            children: [
                              TextLinesCard(
                                    backgroundColor: Color(0xFF7ad1ca),
                                    linesData: [
                                      {
                                        'الاسم الكامل للبائع':
                                            (authProvider.currentUsr.firstName +
                                                    ' ' +
                                                    authProvider
                                                        .currentUsr.lastName) ??
                                                "-----------"
                                      },
                                      {
                                        'مندوب مبيعاتي':
                                            authProvider.currentUsr.agentName ??
                                                "-----------"
                                      },
                                      {
                                        'المدينة':
                                            authProvider.currentUsr.city ??
                                                "-----------"
                                      },
                                      {
                                        'تاريخ آخر شراء': caProvider
                                                .ca.first.lastpurchasedate ??
                                            "-- / -- / ----"
                                      },
                                    ],
                                    valueTextColor: Colors.white,
                                    titleTextColor: Colors.white,
                                  ) ??
                                  CircularProgressIndicator(),
                              TextLinesCard(
                                    backgroundColor: Color(0xFF7ab1d1),
                                    linesData: [
                                      {
                                        'التنقيط': noteProvider
                                                .myNote.first.note
                                                .toString() ??
                                            "-----------"
                                      },
                                      {
                                        'التقييم': noteProvider
                                                .myNote.first.notation
                                                .toString() ??
                                            "-----------"
                                      },
                                      {
                                        'الرصيد': noteProvider
                                                .myNote.first.solde
                                                .toString() ??
                                            "-----------"
                                      },
                                      {
                                        'غير مدفوعة': noteProvider
                                                .myNote.first.total_nbrimp
                                                .toString() ??
                                            "-----------"
                                      },
                                    ],
                                    valueTextColor: Colors.white,
                                    titleTextColor: Colors.white,
                                  ) ??
                                  CircularProgressIndicator(),
                              TextLinesCard(
                                    backgroundColor: Color(0xFFef888d),
                                    linesData: [
                                      {
                                        'رقم المعاملات / السنة': caProvider
                                                .ca.first.total_ca_365
                                                .toString() ??
                                            "-----------"
                                      },
                                      {
                                        'رقم المعاملات / الشهر': caProvider
                                                .ca.first.total_ca_184
                                                .toString() ??
                                            "-----------"
                                      },
                                      {
                                        'الموعد الاخير للدفع': caProvider
                                                    .ca.first.payment_deadline ==
                                                0
                                            ? 'يوم --'
                                            : caProvider.ca.first.payment_deadline ==
                                                    1
                                                ? caProvider
                                                        .ca.first.payment_deadline
                                                        .toString() +
                                                    " يوم"
                                                : caProvider.ca.first
                                                            .payment_deadline ==
                                                        2
                                                    ? caProvider.ca.first
                                                            .payment_deadline
                                                            .toString() +
                                                        " يومان"
                                                    : caProvider.ca.first
                                                                .payment_deadline >=
                                                            3
                                                        ? caProvider.ca.first
                                                                .payment_deadline
                                                                .toString() +
                                                            " أيام"
                                                        : caProvider.ca.first
                                                                    .payment_deadline >=
                                                                11
                                                            ? caProvider
                                                                    .ca
                                                                    .first
                                                                    .payment_deadline
                                                                    .toString() +
                                                                " يوم"
                                                            : 'يوم --'
                                      },
                                    ],
                                    valueTextColor: Colors.white,
                                    titleTextColor: Colors.white,
                                  ) ??
                                  CircularProgressIndicator(),
                              // TextLinesCard(
                              //       backgroundColor:
                              //           Color(0xFFfac759),
                              //       linesData: [
                              //         {
                              //           'رقم المعاملات / الفئة':
                              //               ''
                              //         },
                              //         {'البلاتين': '-- %'},
                              //         {'الذهب': '-- %'},
                              //         {'الفضة': '-- %'},
                              //         {'أخرى': '-- %'},
                              //       ],
                              //       valueTextColor: Colors.white,
                              //       titleTextColor: Colors.white,
                              //     ) ??
                              //     CircularProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : SizedBox(),
                    RistourneWidget(
                      isLocal: false,
                      imageLink: ristourneProvider.image,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
