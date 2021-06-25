import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final assetPath, title, description;
  final double price;

  ProductDetail(
      {this.assetPath,
      this.price,
      this.title,
      this.description});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
        appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false),
        body: Column(
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
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${widget.assetPath}"),
                  fit: BoxFit.contain,
                ),
              ),
              child: Text('') /* add child content here */,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${widget.description}',
                  style: TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.normal),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ));
  }
}
