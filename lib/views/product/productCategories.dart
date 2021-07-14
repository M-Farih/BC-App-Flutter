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
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCategories extends StatefulWidget {
  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('product page');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PromotionProvider>(context, listen: false).getPromotions();
      Provider.of<PromotionProvider>(context, listen: false).getAnnonces();
      Provider.of<PromotionProvider>(context, listen: false).getPdfLink();
      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();

      switch(role_id){
        case 0:
          print('super admin');
          break;
        case 1:
          print('admin');
          break;
        case 2:
          print('commercial');
          break;
        case 3:
          print('revendeur');
          break;
        default:
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var promoProvider = Provider.of<PromotionProvider>(context, listen: true);
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
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff2C7DBF),
                                  ),
                                  onPressed: () async {
                                    print('download pdf...');
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'عروضنا',
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
                        Visibility(
                          visible: authProvider.currentUsr.idrole == 3
                              ? false
                              : true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //btn
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 5, 20),
                                    child: Text(
                                      'Promos',
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
                                                  color: Color(0xff2C7DBF),
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
                                      : authProvider.currentUsr.idrole == 0
                                  ?Row(
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
                                                      PromotionAdd()));
                                        },
                                      ),
                                    ],
                                  )
                                  :SizedBox(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff2C7DBF),
                                  ),
                                  onPressed: () async {
                                    print('download pdf...');
                                    String url = promoProvider.pdfLink;
                                    print('url --> $url');
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
                        ),

                        /// carousel
                        CarouselSlider(
                          options: CarouselOptions(height: 200, autoPlay: true),
                          items: promoProvider.promotions.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                    child: GestureDetector(
                                      child: Image.network(i.promo.replaceAll('"', '').trim(),
                                          fit: BoxFit.fill),
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => MyPhotoViewer(
                                                imageUrl:
                                                i.promo.replaceAll('"', '').trim()
                                            )
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),

                        /// annonces
                        promoProvider.annonces.length > 0
                            ?Column(
                          children: [
                            Visibility(
                              visible: authProvider.currentUsr.idrole == 3
                                  ? true
                                  : false,
                              child: Row(
                                mainAxisAlignment: authProvider.currentUsr.idrole == 3
                                    ?MainAxisAlignment.end
                                    :MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //btn
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 20, 5, 20),
                                        child: Text(
                                          'Annonces',
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
                                                color: Color(0xff2C7DBF),
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
                                          : authProvider.currentUsr.idrole == 0
                                          ?Row(
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
                                                          PromotionAdd()));
                                            },
                                          ),
                                        ],
                                      )
                                          :SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CarouselSlider(
                              options: CarouselOptions(height: 200, autoPlay: true),
                              items: promoProvider.annonces.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration:
                                        BoxDecoration(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: GestureDetector(
                                          child: Image.network(i.promo.replaceAll('"', '').trim(),
                                              fit: BoxFit.fill),
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => MyPhotoViewer(
                                                    imageUrl:
                                                    i.promo.replaceAll('"', '').trim()
                                                )
                                            ));
                                          },
                                          onLongPress: (){
                                            if(authProvider.currentUsr.idrole == 0){
                                              promoProvider.deletePromo(i.idpromo.toString()).whenComplete(() {
                                                _confirmation(context);
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        )
                            :SizedBox()
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
                              padding:
                                  const EdgeInsets.all(20),
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
                            :authProvider.currentUsr.idrole == 0
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
                                : SizedBox()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProductList(type: "1",)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CategoryContainer(
                                    imgUrl: 'assets/images/mousse.png',
                                    text: authProvider.currentUsr.idrole == 3
                                        ? 'اتات'
                                        : 'Salon',
                                    color: 0xFF81BA48),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProductList(type: "2",)));
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
                                    builder: (context) =>
                                        ProductList(type: "3",)));
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
                                    builder: (context) =>
                                        ProductList(type: "4",)));
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
  print('disc clicked');
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
              Text('Opération terminée avec succès', textDirection: TextDirection.ltr),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage_admin()));
            },
          ),
        ],
      );
    },
  );
}