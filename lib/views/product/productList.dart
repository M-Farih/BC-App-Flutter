import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {

  final String category;

  const ProductList({this.category});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      Provider.of<ProductProvider>(context, listen: false).getProducts('1');
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var productProvider = Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false),
      body: productProvider.isBusy
          ?Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
            GridView.count(
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
                           );
              })
            ),
          ],
        ),
      )

    );
  }
}
