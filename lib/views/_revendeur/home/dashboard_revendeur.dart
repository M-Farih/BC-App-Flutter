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
import 'package:url_launcher/url_launcher.dart';

class Dashboard_revendeur extends StatefulWidget {
  @override
  _Dashboard_revendeurState createState() => _Dashboard_revendeurState();
}

class _Dashboard_revendeurState extends State<Dashboard_revendeur> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {});
    Provider.of<RistourneProvider>(context, listen: false).getRistourneImage();
    Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    int iduser =
        Provider.of<AuthProvider>(context, listen: false).currentUsr.iduser;
    int idvendor =
        Provider.of<AuthProvider>(context, listen: false).currentUsr.idvendor;
    Provider.of<CaProvider>(context, listen: false).getCA(idvendor);
    Provider.of<CaFamilleProvider>(context, listen: false)
        .getCAFamille(idvendor);
    final caProvider = Provider.of<CaProvider>(context, listen: false);
    final myNoteProvider = Provider.of<MyNoteProvider>(context, listen: false);

    final ca = caProvider.ca.first;

    myNoteProvider.getMyNote(
      idvendor,
      ca.total_ca_365,
      ca.total_ca_184,
      ca.payment_deadline,
    );
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

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2C7DBF),
      body:
          // ristourneProvider.isBusy
          //     ? Center(child: CircularProgressIndicator())
          // :
          caProvider.isBusy
              ? Center(child: CircularProgressIndicator())
              // : caFamilleProvider.isBusy
              //     ? Center(child: CircularProgressIndicator())
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
                                'العائد السنوي لسنة ${DateTime.now().year}',
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
                                15.0,
                                5.0,
                                15.0,
                                0.0,
                              ),
                              child: Text(
                                caFamilleProvider.caFamille.first.total_ca !=
                                        null
                                    ? '${caFamilleProvider.caFamille.first.total_ca} درهم'
                                    : '0 درهم',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        caFamilleProvider.caFamille.first.total_ca != null
                            ? double.parse(caFamilleProvider
                                        .caFamille.first.total_ca) >=
                                    10000.00
                                ? noteProvider.myNote.first.cat != null
                                    ? RatingBar.builder(
                                        initialRating: double.parse(noteProvider
                                                .myNote.first.cat) ??
                                            0,
                                        minRating: double.parse(noteProvider
                                                .myNote.first.cat) ??
                                            0,
                                        maxRating: double.parse(noteProvider
                                                .myNote.first.cat) ??
                                            0,
                                        itemSize: 30.0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ignoreGestures: true,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.5),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (double value) {
                                          print(value);
                                        },
                                      )
                                    : Text(
                                        "Tu n\'as pas d\'avis pour le moment",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                : SizedBox()
                            : SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                15.0,
                                5.0,
                                15.0,
                                5.0,
                              ),
                              child: Text(
                                caFamilleProvider.caFamille.first.ristourne !=
                                        null
                                    ? '${caFamilleProvider.caFamille.first.ristourne}'
                                    : '--%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                      turnover: double.parse(caFamilleProvider
                                              .caFamille
                                              .first
                                              .total_ca_Mousse) ??
                                          0.0,
                                      maxi: double.parse(caFamilleProvider
                                              .caFamille.first.total_ca) ??
                                          0.0,
                                    ),
                                    SliderVerticalWidget(
                                      imgUrl: 'assets/images/salon.png',
                                      title: 'مختلف',
                                      turnover: double.parse(caFamilleProvider
                                              .caFamille
                                              .first
                                              .total_ca_Divers) ??
                                          0.0,
                                      maxi: double.parse(caFamilleProvider
                                              .caFamille.first.total_ca) ??
                                          0.0,
                                    ),
                                    SliderVerticalWidget(
                                      imgUrl: 'assets/images/banquette.png',
                                      title: 'سداري',
                                      turnover: double.parse(caFamilleProvider
                                              .caFamille
                                              .first
                                              .total_ca_Banquette) ??
                                          0.0,
                                      maxi: double.parse(caFamilleProvider
                                              .caFamille.first.total_ca) ??
                                          0.0,
                                    ),
                                    SliderVerticalWidget(
                                      imgUrl: 'assets/images/matelas.png',
                                      title: 'ماطلة',
                                      turnover: double.parse(caFamilleProvider
                                              .caFamille
                                              .first
                                              .total_ca_Matelas) ??
                                          0.0,
                                      maxi: double.parse(caFamilleProvider
                                              .caFamille.first.total_ca) ??
                                          0.0,
                                    ),
                                  ],
                                ),
                              ),
                              caFamilleProvider.caFamille.first.total_ca != null
                                  ? double.parse(caFamilleProvider
                                              .caFamille.first.total_ca) >=
                                          10000.00
                                      ? Column(
                                          children: [
                                            TextLinesCard(
                                                  backgroundColor:
                                                      Color(0xFF7ad1ca),
                                                  linesData: [
                                                    {
                                                      // ignore: null_aware_before_operator
                                                      'الاسم الكامل للبائع': (authProvider
                                                                  .currentUsr
                                                                  ?.firstName +
                                                              // ignore: can_be_null_after_null_aware
                                                              (authProvider
                                                                      .currentUsr
                                                                      ?.firstName
                                                                      .isEmpty
                                                                  ? ''
                                                                  : ' ') +
                                                              authProvider
                                                                  ?.currentUsr
                                                                  ?.lastName) ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'مندوب مبيعاتي':
                                                          authProvider
                                                                  .currentUsr
                                                                  ?.agentName ??
                                                              "-----------"
                                                    },
                                                    {
                                                      'المدينة': authProvider
                                                              .currentUsr
                                                              ?.city ??
                                                          "-----------"
                                                    },
                                                    {
                                                      'تاريخ آخر شراء': caProvider
                                                              .ca
                                                              .first
                                                              ?.lastpurchasedate ??
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
                                                      'النقطة \ التنقيط':
                                                          noteProvider.myNote
                                                                  .first?.note
                                                                  .toString() ??
                                                              "-----------"
                                                    },
                                                    {
                                                      'التقييم': noteProvider
                                                              .myNote
                                                              .first
                                                              ?.notation
                                                              .toString() ??
                                                          "-----------",
                                                      'isRTL': false,
                                                    },
                                                    {
                                                      'الرصيد': noteProvider
                                                                  .myNote
                                                                  .first
                                                                  ?.solde
                                                                  .toString() +
                                                              ' درهم' ??
                                                          "---- درهم"
                                                    },
                                                    {
                                                      'المدفوعات بدون رصيد':
                                                          noteProvider
                                                                  .myNote
                                                                  .first
                                                                  ?.total_nbrimp
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
                                                      'قيمة المبيعات السنوية':
                                                          caProvider.ca.first
                                                                      ?.total_ca_365
                                                                      .toString() +
                                                                  ' درهم' ??
                                                              "---- درهم"
                                                    },
                                                    {
                                                      'متوسط قيمة المبيعات الشهرية':
                                                          caProvider.ca.first
                                                                      ?.total_ca_184
                                                                      .toString() +
                                                                  ' درهم' ??
                                                              "---- درهم"
                                                    },
                                                    {
                                                      'مدة الدفع': caProvider
                                                                  .ca
                                                                  .first
                                                                  ?.payment_deadline ==
                                                              0
                                                          ? 'يوم --'
                                                          : caProvider.ca.first
                                                                      ?.payment_deadline ==
                                                                  1
                                                              ? caProvider
                                                                      .ca
                                                                      .first
                                                                      ?.payment_deadline
                                                                      .toString() +
                                                                  " يوم"
                                                              : caProvider
                                                                          .ca
                                                                          .first
                                                                          ?.payment_deadline ==
                                                                      2
                                                                  ? caProvider
                                                                          .ca
                                                                          .first
                                                                          ?.payment_deadline
                                                                          .toString() +
                                                                      " يومان"
                                                                  // ignore: null_aware_before_operator
                                                                  : caProvider.ca.first?.payment_deadline >=
                                                                              3 &&
                                                                          // ignore: null_aware_before_operator
                                                                          caProvider.ca.first?.payment_deadline <=
                                                                              10
                                                                      ? caProvider.ca.first?.payment_deadline.toString() + " أيام"
                                                                      // ignore: null_aware_before_operator
                                                                      : caProvider.ca.first?.payment_deadline >= 11
                                                                          ? caProvider.ca.first?.payment_deadline.toString() + " يوم"
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
                                            //           'إجمالي المبيعات / الفئة':
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
                                      : SizedBox()
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
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2C7DBF),
        onPressed: () async {
          String url =
              "https://apps.who.int/iris/bitstream/handle/10665/205234/9789242500196_software_fre.pdf";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch the guide file';
          }
        },
        child: Icon(
          Icons.my_library_books_rounded,
        ),
      ),
    );
  }
}
