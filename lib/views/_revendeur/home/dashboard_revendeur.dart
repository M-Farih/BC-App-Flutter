import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/caProvider.dart';
import 'package:bc_app/providers/myNoteProvider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/views/widgets/TextLinesCard.dart';
import 'package:bc_app/views/widgets/ristourneWidget.dart';
import 'package:bc_app/views/widgets/sliderVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<AuthProvider>(context, listen: false).getUserSolde(iduser);
      Provider.of<CaProvider>(context, listen: false).getCA(idvendor);

      // NOTE ======================================
      print("dddddddddddddddddddddddddddddddddddd");
      // print("homa hado " +
      //     Provider.of<MyNoteProvider>(context, listen: false).getMyNote(idvendor, 8, 55, 8).toString());
      Provider.of<MyNoteProvider>(context, listen: false)
          .getMyNote(idvendor, 87557, 5087, 4);

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
    var noteProvider = Provider.of<MyNoteProvider>(context, listen: true);

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2C7DBF),
      body: ristourneProvider.isBusy
          ? Center(child: CircularProgressIndicator())
          : authProvider.busy
              ? Center(child: CircularProgressIndicator())
              : caProvider.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 20.0, 15.0, 0),
                                  child: Text(
                                    'المردود السنوي من ${authProvider.from} الى ${authProvider.to}',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 5.0),
                                  child: Text(
                                    '${authProvider.ristourne}',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 25.0),
                                  child: Text(
                                    '${authProvider.solde} Dhs',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F4F7),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Column(
                                children: [
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SliderVerticalWidget(
                                            imgUrl: 'assets/images/mousse.png',
                                            title: 'بونج',
                                            turnover: authProvider.mousse,
                                            maxi: authProvider.max),
                                        SliderVerticalWidget(
                                            imgUrl: 'assets/images/salon.png',
                                            title: 'مختلف',
                                            turnover: authProvider.divers,
                                            maxi: authProvider.max),
                                        SliderVerticalWidget(
                                            imgUrl:
                                                'assets/images/banquette.png',
                                            title: 'سداري',
                                            turnover: authProvider.banquette,
                                            maxi: authProvider.max),
                                        SliderVerticalWidget(
                                            imgUrl: 'assets/images/matelas.png',
                                            title: 'ماطلة',
                                            turnover: authProvider.matelas,
                                            maxi: authProvider.max),
                                      ],
                                    ),
                                  ),
                                  double.parse(authProvider.currentUsr.ca) >=
                                          10000.0
                                      ? Column(
                                          children: [
                                            TextLinesCard(
                                                  backgroundColor:
                                                      Color(0xFF7ad1ca),
                                                  linesData: [
                                                    {
                                                      'الاسم الكامل للبائع':
                                                          (authProvider
                                                                      .currentUsr
                                                                      .firstName +
                                                                  ' ' +
                                                                  authProvider
                                                                      .currentUsr
                                                                      .lastName) ??
                                                              "-----------"
                                                    },
                                                    {
                                                      'مندوب مبيعاتي':
                                                          authProvider
                                                                  .currentUsr
                                                                  .agentName ??
                                                              "-----------"
                                                    },
                                                    {
                                                      'المدينة': authProvider
                                                              .currentUsr
                                                              .city ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'تاريخ آخر شراء': authProvider
                                                              .currentUsr
                                                              .lastpurchasedate ??
                                                          "-- / -- / ----"
                                                    },
                                                  ],
                                                  valueTextColor: Colors.white,
                                                  titleTextColor: Colors.white,
                                                ) ??
                                                CircularProgressIndicator(),
                                            TextLinesCard(
                                                  backgroundColor:
                                                      Color(0xFF7ab1d1),
                                                  linesData: [
                                                    {
                                                      'التنقيط': noteProvider
                                                              .myNote[0].note
                                                              .toString() ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'التقييم': noteProvider
                                                              .myNote[0]
                                                              .notation
                                                              .toString() ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'الرصيد': noteProvider
                                                              .myNote[0].solde
                                                              .toString() ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'غير مدفوعة': noteProvider
                                                              .myNote[0]
                                                              .total_nbrimp
                                                              .toString() ??
                                                          "-----------"
                                                    },
                                                  ],
                                                  valueTextColor: Colors.white,
                                                  titleTextColor: Colors.white,
                                                ) ??
                                                CircularProgressIndicator(),
                                            TextLinesCard(
                                                  backgroundColor:
                                                      Color(0xFFef888d),
                                                  linesData: [
                                                    {
                                                      'رقم المعاملات / السنة':
                                                          caProvider.ca[0]
                                                                  .total_ca_184
                                                                  .toString() ??
                                                              "-----------"
                                                    },
                                                    {
                                                      'رقم المعاملات / الشهر':
                                                          caProvider.ca[0]
                                                                  .total_ca_365
                                                                  .toString() ??
                                                              "-----------"
                                                    },
                                                    // {
                                                    //   'الموعد الاخير للدفع': caProvider
                                                    //                   .ca[0]
                                                    //                   .payment_deadline ==
                                                    //               0 ||
                                                    //           null
                                                    //       ? 'يوم --'
                                                    //       : caProvider.ca[0]
                                                    //                   .payment_deadline ==
                                                    //               1
                                                    //           ? caProvider.ca[0]
                                                    //                   .payment_deadline
                                                    //                   .toString() +
                                                    //               " يوم"
                                                    //           : caProvider.ca[0]
                                                    //                       .payment_deadline ==
                                                    //                   2
                                                    //               ? caProvider.ca[0]
                                                    //                       .payment_deadline
                                                    //                       .toString() +
                                                    //                   " يومان"
                                                    //               : caProvider.ca[0]
                                                    //                           .payment_deadline >=
                                                    //                       3
                                                    //                   ? caProvider
                                                    //                           .ca[0]
                                                    //                           .payment_deadline
                                                    //                           .toString() +
                                                    //                       " أيام"
                                                    //                   : caProvider.ca[0]
                                                    //                               .payment_deadline >=
                                                    //                           11
                                                    //                       ? caProvider.ca[0].payment_deadline.toString() + " يوم"
                                                    //                       : 'يوم --'
                                                    // },
                                                    {
                                                      'الموعد الاخير للدفع': caProvider
                                                                  .ca[0]
                                                                  .payment_deadline
                                                                  .toString() +
                                                              'أيام ' ??
                                                          'يوم --'
                                                    },
                                                  ],
                                                  valueTextColor: Colors.white,
                                                  titleTextColor: Colors.white,
                                                ) ??
                                                CircularProgressIndicator(),
                                            TextLinesCard(
                                                  backgroundColor:
                                                      Color(0xFFfac759),
                                                  linesData: [
                                                    {
                                                      'رقم المعاملات / الفئة':
                                                          ''
                                                    },
                                                    {'البلاتين': '-- %'},
                                                    {'الذهب': '-- %'},
                                                    {'الفضة': '-- %'},
                                                    {'أخرى': '-- %'},
                                                  ],
                                                  valueTextColor: Colors.white,
                                                  titleTextColor: Colors.white,
                                                ) ??
                                                CircularProgressIndicator(),
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
