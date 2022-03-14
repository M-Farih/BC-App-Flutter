import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/product/productAdd.dart';
import 'package:bc_app/views/product/productDetails.dart';
import 'package:bc_app/views/product/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String name, desc, imgPath, id, type;
  final bool isRevendeur;


  ProductCard({this.name, this.imgPath, this.desc, this.id, this.type, this.isRevendeur});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool actionBtn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actionBtn = false;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var productProvider = Provider.of<ProductProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
            authProvider.currentUsr.idrole == 3
                ?HomePage_Revendeur(index: 1)
                :authProvider.currentUsr.idrole == 2
                ?HomePage_Commercial(index: 1)
                :HomePage_admin(index: 1)
        ));
      },
      child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
          child: GestureDetector(
            onLongPress: (){
              setState(() {
                if(!widget.isRevendeur) actionBtn = true;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetail(
                        assetPath: widget.imgPath, title: widget.name, description: widget.desc)));
              },
              child: Card(
                child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      SizedBox(
                          height: 120,
                          child: widget.imgPath != ""
                              ?Image.network('${widget.imgPath}', fit: BoxFit.contain)
                              :Image.asset('assets/images/dummyproduct.jpg')
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 20,
                              child: Text(
                                '${widget.name}',
                                style: TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.bold),
                                textDirection: TextDirection.ltr,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '${widget.desc}',
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.normal),
                            textDirection: TextDirection.ltr,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 25.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Lire la suite',
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 10.0),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 10.0,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: actionBtn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(40)),
                                  child: Icon(Icons.edit, size: 18,color: Colors.white),
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductAdd(isAdd: false, name: widget.name, description: widget.desc, image: widget.imgPath, id: widget.id,)));
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(40)),
                                  child: Icon(Icons.delete, size: 18,color: Colors.white),
                                ),
                              ),
                              onTap: (){
                                productProvider.deleteProduct(widget.id);
                                _confirmation(context, widget.type);
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(40)),
                                  child: Icon(Icons.clear, size: 18,color: Colors.grey),
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  actionBtn = false;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              ),
            )
          )),
    );
  }
}

Future<void> _confirmation(context, type) async {
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
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => ProductList(type: type)));
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  ProductList(type: type)), (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    },
  );
}
