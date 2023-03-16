import 'package:bc_app/const/extentions.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/caFamilleProvider.dart';
import 'package:bc_app/providers/caProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/myNoteProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/widgets/TextLinesCard.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/sellerProductStatistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SellerDetails extends StatefulWidget {
  final int id, idvendor, idrole;
  final String profileImg,
      phoneNumber,
      mail,
      username,
      password,
      firstName,
      lastName,
      agentName,
      city,
      address;

  SellerDetails({
    this.id,
    this.idvendor,
    this.profileImg,
    this.phoneNumber,
    this.mail,
    this.username,
    this.password,
    this.idrole,
    this.firstName,
    this.lastName,
    this.agentName,
    this.city,
    this.address,
  });

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  String extractTwoDigitsAfterDot(String numberString) {
    int dotIndex = numberString.indexOf(".");
    if (dotIndex != -1 && dotIndex + 3 <= numberString.length) {
      return numberString.substring(0, dotIndex + 3);
    } else {
      return numberString;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Provider.of<UserProvider>(context, listen: false)
            .getSellerById(widget.id);
        Provider.of<CaFamilleProvider>(context, listen: false)
            .getCAFamille(widget.idvendor);
        Provider.of<CaProvider>(context, listen: false).getCA(widget.idvendor);
        Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      },
    );

    final caProvider = Provider.of<CaProvider>(context, listen: false);
    final myNoteProvider = Provider.of<MyNoteProvider>(context, listen: false);
    int idvendor =
        Provider.of<AuthProvider>(context, listen: false).currentUsr.idvendor;

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
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    // New
    var caProvider = Provider.of<CaProvider>(context, listen: true);
    var caFamilleProvider =
        Provider.of<CaFamilleProvider>(context, listen: true);
    var noteProvider = Provider.of<MyNoteProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Color(0xFFF1F4F7),
      appBar: MyAppBar(
        isSeller: userProvider.userById.idrole == 3 ? true : false,
        roleId: userProvider.userById.idrole,
      ),
      body: userProvider.busy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  /// back btn & icon-title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         userProvider.userById.idrole == 3
                            //             ? HomePage_Revendeur(index: 2)
                            //             : userProvider.userById.idrole == 2
                            //                 ? HomePage_Commercial(index: 2)
                            //                 : HomePage_admin(index: 2),
                            //   ),
                            // );
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: Container(
                              width: 80,
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_back, size: 17),
                                  Text(
                                    'Retour',
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // btns
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: widget.phoneNumber != ""
                                        ? Color(0xFF2C7DBF)
                                        : Color(0xFFA0A0A0),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              onTap: () {
                                contactProvider.call('${widget.phoneNumber}');
                              },
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: widget.mail != ""
                                          ? Color(0xFF2C7DBF)
                                          : Color(0xFFA0A0A0),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              onTap: () {
                                contactProvider.mailSeller('${widget.mail}');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  /// seller card
                  Container(
                    height: userProvider.userById.idrole == 3
                        ? MediaQuery.of(context).size.height * 0.44
                        : MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width - 50,
                    margin: EdgeInsets.only(
                      top: userProvider.userById.idrole == 3
                          ? MediaQuery.of(context).size.height * 0
                          : MediaQuery.of(context).size.height * 0.1,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/user-card.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${widget.profileImg}',
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                userProvider.userById.firstName != null ||
                                        userProvider.userById.lastName != null
                                    ? userProvider.userById.firstName +
                                        ' ' +
                                        userProvider.userById.lastName
                                    : '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              width: MediaQuery.of(context).size.width * 0.75,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        userProvider.userById.idrole == 3
                            ? Text(
                                'CA pour l\'année ${DateTime.now().year}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                ),
                              )
                            : SizedBox(),
                        userProvider.userById.idrole == 3
                            ? Text(
                                caFamilleProvider.caFamille.first.total_ca !=
                                        null
                                    ? '${caFamilleProvider.caFamille.first.total_ca} Dhs'
                                    : '--- Dhs',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        userProvider.userById.idrole == 3
                            ? Text(
                                caFamilleProvider.caFamille.first.total_ca !=
                                        null
                                    ? '${caFamilleProvider.caFamille.first.ristourne}'
                                    : '-- %',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                ),
                              )
                            : SizedBox(),
                        noteProvider.myNote.first.cat != null &&
                                caFamilleProvider.caFamille.first.total_ca !=
                                    null
                            ? Container(
                                child: double.parse(caFamilleProvider
                                            .caFamille.first.total_ca) >=
                                        10000.00
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
                                    : SizedBox(),
                              )
                            : SizedBox(),
                        userProvider.userById.idrole != 3
                            ? Column(
                                children: [
                                  SizedBox(height: 30),
                                  widget.phoneNumber.isEmpty ||
                                          widget.phoneNumber != null
                                      ? GestureDetector(
                                          onTap: () {
                                            contactProvider.call(
                                              '${widget.phoneNumber}',
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_history,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "${widget.address}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      contactProvider.call(
                                        '${widget.phoneNumber}',
                                      );
                                    },
                                    child: Text(
                                      "${widget.phoneNumber}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  GestureDetector(
                                    onTap: () {
                                      contactProvider.mailSeller(
                                        '${widget.mail}',
                                      );
                                    },
                                    child: Text(
                                      "${widget.mail}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),

                  /// seller Statistics
                  SizedBox(height: 30),
                  userProvider.userById.idrole == 3
                      ? sellerProductStatistics(
                          productImage: 'assets/images/matelas.png',
                          familleName: 'Matelas',
                          famillePrice: caFamilleProvider
                                          .caFamille.first.total_ca_Matelas !=
                                      null &&
                                  // ignore: unrelated_type_equality_checks
                                  caFamilleProvider
                                          .caFamille.first.total_ca_Matelas !=
                                      0
                              ? '${extractTwoDigitsAfterDot(caFamilleProvider.caFamille.first.total_ca_Matelas)}'
                              : '0 Dhs',
                          textColor: 0xFF2C7DBF,
                        )
                      : SizedBox(),
                  userProvider.userById.idrole == 3
                      ? sellerProductStatistics(
                          productImage: 'assets/images/banquette.png',
                          familleName: 'Banquette',
                          famillePrice: caFamilleProvider
                                          .caFamille.first.total_ca_Banquette !=
                                      null &&
                                  // ignore: unrelated_type_equality_checks
                                  caFamilleProvider
                                          .caFamille.first.total_ca_Banquette !=
                                      0
                              ? '${extractTwoDigitsAfterDot(caFamilleProvider.caFamille.first.total_ca_Banquette)}'
                              : '0 Dhs',
                          textColor: 0xFF84489B,
                        )
                      : SizedBox(),
                  userProvider.userById.idrole == 3
                      ? sellerProductStatistics(
                          productImage: 'assets/images/mousse.png',
                          familleName: 'Mousse',
                          famillePrice: caFamilleProvider
                                          .caFamille.first.total_ca_Mousse !=
                                      null &&
                                  // ignore: unrelated_type_equality_checks
                                  caFamilleProvider
                                          .caFamille.first.total_ca_Mousse !=
                                      0
                              ? '${extractTwoDigitsAfterDot(caFamilleProvider.caFamille.first.total_ca_Mousse)}'
                              : '0 Dhs',
                          textColor: 0xFF81BA48,
                        )
                      : SizedBox(),
                  userProvider.userById.idrole == 3
                      ? sellerProductStatistics(
                          productImage: 'assets/images/salon.png',
                          familleName: 'Salon',
                          famillePrice: caFamilleProvider
                                          .caFamille.first.total_ca_Divers !=
                                      null &&
                                  // ignore: unrelated_type_equality_checks
                                  caFamilleProvider
                                          .caFamille.first.total_ca_Divers !=
                                      0
                              ? '${extractTwoDigitsAfterDot(caFamilleProvider.caFamille.first.total_ca_Divers)}'
                              : '0 Dhs',
                          textColor: 0xFFE32A33,
                        )
                      : SizedBox(),

                  userProvider.userById.idrole == 3
                      ? caFamilleProvider.caFamille.first.total_ca != null
                          ? double.parse(caFamilleProvider
                                      .caFamille.first.total_ca) >=
                                  10000.00
                              ? Column(
                                  children: [
                                    TextLinesCard(
                                          backgroundColor: Color(0xFF7ad1ca),
                                          linesData: [
                                            {
                                              'الاسم الكامل للبائع': (widget
                                                          .firstName +
                                                      (widget.firstName.isEmpty
                                                          ? ''
                                                          : ' ') +
                                                      widget.lastName) ??
                                                  "-----------"
                                            },
                                            {
                                              'مندوب مبيعاتي':
                                                  widget.agentName ??
                                                      "-----------",
                                            },
                                            {
                                              'المدينة':
                                                  widget.city ?? "-----------"
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
                                          backgroundColor: Color(0xFF7ab1d1),
                                          linesData: [
                                            {
                                              'التنقيط': noteProvider
                                                      .myNote.first?.note
                                                      .toString() ??
                                                  "-----------"
                                            },
                                            {
                                              'التقييم': noteProvider
                                                      .myNote.first?.notation
                                                      .toString() ??
                                                  "-----------",
                                              'isRTL': false,
                                            },
                                            {
                                              'الرصيد': noteProvider
                                                          .myNote.first?.solde
                                                          .toString() +
                                                      ' درهم' ??
                                                  "---- درهم"
                                            },
                                            {
                                              'المستحقات الغير مدفوعة':
                                                  noteProvider.myNote.first
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
                                          backgroundColor: Color(0xFFef888d),
                                          linesData: [
                                            {
                                              'إجمالي المبيعات / 365 يوم':
                                                  caProvider.ca.first
                                                              ?.total_ca_365
                                                              .toString() +
                                                          ' درهم' ??
                                                      "---- درهم"
                                            },
                                            {
                                              'إجمالي المبيعات / 184 يوم':
                                                  caProvider.ca.first
                                                              ?.total_ca_184
                                                              .toString() +
                                                          ' درهم' ??
                                                      "---- درهم"
                                            },
                                            {
                                              'مهلة الدفع': caProvider.ca.first
                                                          ?.payment_deadline ==
                                                      0
                                                  ? 'يوم --'
                                                  : caProvider.ca.first?.payment_deadline ==
                                                          1
                                                      ? caProvider.ca.first
                                                              ?.payment_deadline
                                                              .toString() +
                                                          " يوم"
                                                      : caProvider.ca.first?.payment_deadline ==
                                                              2
                                                          ? caProvider.ca.first
                                                                  ?.payment_deadline
                                                                  .toString() +
                                                              " يومان"
                                                          // ignore: null_aware_before_operator
                                                          : caProvider.ca.first?.payment_deadline >=
                                                                      3 &&
                                                                  // ignore: null_aware_before_operator
                                                                  caProvider
                                                                          .ca
                                                                          .first
                                                                          ?.payment_deadline <=
                                                                      10
                                                              ? caProvider
                                                                      .ca
                                                                      .first
                                                                      ?.payment_deadline
                                                                      .toString() +
                                                                  " أيام"
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
                          : SizedBox()
                      : SizedBox(),

                  ///btn
                  SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
