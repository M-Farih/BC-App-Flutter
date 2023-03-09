import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {

  final String type;

  const ProductList({Key key, this.type}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {


  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      Provider.of<ProductProvider>(context, listen: false).getProducts(widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
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
      child: Scaffold(
        appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false),
        body: productProvider.isBusy
            ?Center(child: CircularProgressIndicator())
            :SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
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
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 100,
                        height: 40,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_back, size: 17),
                            Text(
                              authProvider.currentUsr.idrole == 3
                                  ?'المنتوجات'
                                  :'Produits',
                              style: TextStyle(
                                  fontSize: 17
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              productProvider.product.length != 0
                  ?GridView.count(
                childAspectRatio: 0.6,
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(productProvider.product.length, (index){
                  return ProductCard(
                               name: productProvider.product[index].name,
                               desc: productProvider.product[index].description,
                               imgPath: productProvider.product[index].image.replaceAll('"', '').trim(),
                                id: productProvider.product[index].idproduct.toString(),
                                type: widget.type,
                                isRevendeur: authProvider.currentUsr.idrole == 3 ?true :false,
                             );
                })
              )
                  :Center(child: Text(authProvider.currentUsr.idrole == 3 ?'لا يوجد منتجات للعرض' :'Aucun produit à afficher'),)
            ],
          ),
        )

      ),
    );
  }
}
