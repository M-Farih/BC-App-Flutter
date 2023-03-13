import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/promotionProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productAdd.dart';
import 'package:bc_app/views/product/productList.dart';
import 'package:bc_app/views/product/promotionAdd.dart';
import 'package:bc_app/views/widgets/categoryContainer.dart';
import 'package:bc_app/views/widgets/photoViewer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCategories extends StatefulWidget {
  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PromotionProvider>(context, listen: false).getPromotions();
      Provider.of<PromotionProvider>(context, listen: false).getAnnonces();
      Provider.of<PromotionProvider>(context, listen: false).getPdfLink();
      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var promoProvider = Provider.of<PromotionProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
      body: authProvider.userChekcerIsBusy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ///our promos
                    Column(
                      children: [
                        Visibility(
                          visible: authProvider.currentUsr.idrole == 3
                              ? true
                              : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //if is seller
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child:
                                      // promoProvider.promotions.length > 0
                                      //     ?
                                      ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff2C7DBF),
                                    ),
                                    onPressed: () async {
                                      String url = promoProvider.pdfLink;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: Icon(
                                      Icons.download_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      authProvider.currentUsr.idrole == 3
                                          ? "تحميل العروض"
                                          : "Télécharger",
                                    ),
                                  )
                                  // : ElevatedButton.icon(
                                  //     style: ElevatedButton.styleFrom(
                                  //       primary: Color(0xff2C7DBF),
                                  //     ),
                                  //     onPressed: null,
                                  //     icon: Icon(
                                  //       Icons.download_outlined,
                                  //       size: 18,
                                  //       color: Colors.white,
                                  //     ),
                                  //     label: Text(
                                  //       authProvider.currentUsr.idrole == 3
                                  //           ? "تحميل العروض"
                                  //           : "Télécharger",
                                  //     ),
                                  //   ),
                                  ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  // promoProvider.promotions.length > 0
                                  //     ?
                                  'عروضنا',
                                  // : 'لا توجد عروض حاليا',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              //if is not seller
                            ],
                          ),
                        ),
                        // promoProvider.promotions.length > 0
                        //     ? 
                            Visibility(
                                visible: authProvider.currentUsr.idrole == 3
                                    ? false
                                    : true,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //btn
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 5, 20),
                                          child: Text(
                                            promoProvider.promotions.length > 0
                                                ? 'Promos'
                                                : 'Nos Promos',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        authProvider.currentUsr.idrole == 1
                                            ? Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  GestureDetector(
                                                    child: Icon(Icons.add,
                                                        color:
                                                            Color(0xff2C7DBF),
                                                        size: 22),
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PromotionAdd()));
                                                    },
                                                  ),
                                                ],
                                              )
                                            : authProvider.currentUsr.idrole ==
                                                    0
                                                ? Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      GestureDetector(
                                                        child: Icon(Icons.add,
                                                            color: Color(
                                                                0xff2C7DBF),
                                                            size: 22),
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PromotionAdd()));
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff2C7DBF),
                                        ),
                                        onPressed: () async {
                                          String url = promoProvider.pdfLink;
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        icon: Icon(
                                          Icons.download_outlined,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                            authProvider.currentUsr.idrole == 3
                                                ? "تحميل"
                                                : "Télécharger"),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            // : SizedBox()
                            ,

                        /// carousel:SizedBox(),
                        promoProvider.promotions.length > 0
                            ? CarouselSlider(
                                options: CarouselOptions(
                                    height: 200, autoPlay: true),
                                items: promoProvider.promotions.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              //  i.promo.isEmpty
                                              //     ?
                                              GestureDetector(
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 6.9,
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    alignment: Alignment.center,
                                                    image: NetworkImage(
                                                      i.promo
                                                          .replaceAll('"', '')
                                                          .trim(),
                                                    )),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyPhotoViewer(
                                                              imageUrl: i.promo
                                                                  .replaceAll(
                                                                      '"', '')
                                                                  .trim())));
                                            },
                                          )
                                          // : Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //       vertical: 80,
                                          //     ),
                                          //     child: SizedBox(
                                          //       width: 20,
                                          //       child:
                                          //           CircularProgressIndicator(
                                          //         strokeWidth: 2.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          );
                                    },
                                  );
                                }).toList(),
                              )
                            : CircularProgressIndicator(),

                        /// annonces
                        promoProvider.annonces.length > 0
                            ? Column(
                                children: [
                                  Visibility(
                                    visible: authProvider.currentUsr.idrole == 3
                                        ? true
                                        : false,
                                    child: Row(
                                      mainAxisAlignment:
                                          authProvider.currentUsr.idrole == 3
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        //if is seller
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'إعلان',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: authProvider.currentUsr.idrole == 3
                                        ? false
                                        : true,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //btn
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 5, 20),
                                              child: Text(
                                                'Annonces',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            authProvider.currentUsr.idrole == 1
                                                ? Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      GestureDetector(
                                                        child: authProvider
                                                                    .currentUsr
                                                                    .idrole ==
                                                                0
                                                            ? Icon(Icons.add,
                                                                color: Color(
                                                                    0xff2C7DBF),
                                                                size: 22)
                                                            : SizedBox(),
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PromotionAdd()));
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : authProvider.currentUsr
                                                            .idrole ==
                                                        0
                                                    ? Row(
                                                        children: [
                                                          SizedBox(width: 10),
                                                          GestureDetector(
                                                            child: Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xff2C7DBF),
                                                                size: 22),
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              PromotionAdd()));
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.network(
                                                  promoProvider
                                                      .annonces[0].promo
                                                      .replaceAll('"', '')
                                                      .trim(),
                                                  fit: BoxFit.cover),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyPhotoViewer(
                                                              imageUrl:
                                                                  promoProvider
                                                                      .annonces[
                                                                          0]
                                                                      .promo
                                                                      .replaceAll(
                                                                          '"',
                                                                          '')
                                                                      .trim())));
                                            },
                                          ),
                                          authProvider.currentUsr.idrole == 0
                                              ? Positioned(
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: FlatButton(
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      color: Color(0xFFF5F6F9),
                                                      onPressed: () {
                                                        progressDialog.show();
                                                        promoProvider
                                                            .deletePromo(
                                                                promoProvider
                                                                    .annonces[0]
                                                                    .idpromo
                                                                    .toString())
                                                            .whenComplete(() {
                                                          progressDialog.hide();
                                                          _confirmation(
                                                              context);
                                                        });
                                                      },
                                                      child: Icon(Icons.clear,
                                                          size: 21.0),
                                                    ),
                                                  ),
                                                  top: 1,
                                                  right: 1,
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),

                    /// our products
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: authProvider.currentUsr.idrole == 3
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                authProvider.currentUsr.idrole == 3
                                    ? 'منتجاتنا'
                                    : 'Produits',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            authProvider.currentUsr.idrole == 1
                                ? Row(
                                    children: [
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        child: Icon(Icons.add,
                                            color: Color(0xff2C7DBF), size: 22),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductAdd(
                                                        isAdd: true,
                                                        image: '',
                                                        description: '',
                                                        name: '',
                                                        id: '',
                                                      )));
                                        },
                                      ),
                                    ],
                                  )
                                : authProvider.currentUsr.idrole == 0
                                    ? Row(
                                        children: [
                                          SizedBox(width: 10),
                                          GestureDetector(
                                            child: Icon(Icons.add,
                                                color: Color(0xff2C7DBF),
                                                size: 22),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductAdd(
                                                            isAdd: true,
                                                            image: '',
                                                            description: '',
                                                            name: '',
                                                            id: '',
                                                          )));
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          type: "1",
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CategoryContainer(
                                    imgUrl: 'assets/images/mousse.png',
                                    text: authProvider.currentUsr.idrole == 3
                                        ? 'أثاث'
                                        : 'Salon',
                                    color: 0xFF81BA48),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          type: "2",
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CategoryContainer(
                                    imgUrl: 'assets/images/salon.png',
                                    text: authProvider.currentUsr.idrole == 3
                                        ? 'مختلف'
                                        : 'Divers',
                                    color: 0xFFE32A33),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          type: "3",
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CategoryContainer(
                                    imgUrl: 'assets/images/banquette.png',
                                    text: authProvider.currentUsr.idrole == 3
                                        ? 'سداري'
                                        : 'Banquettes',
                                    color: 0xFF84489B),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          type: "4",
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CategoryContainer(
                                    imgUrl: 'assets/images/matelas.png',
                                    text: authProvider.currentUsr.idrole == 3
                                        ? 'ماطلات'
                                        : 'Matelas',
                                    color: 0xFF2C7DBF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

Future<void> _confirmation(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirmation',
          textDirection: TextDirection.rtl,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Opération terminée avec succès',
                  textDirection: TextDirection.ltr),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage_admin()));
            },
          ),
        ],
      );
    },
  );
}
