import 'package:bc_app/views/product/productList.dart';
import 'package:bc_app/views/widgets/categoryContainer.dart';
import 'package:flutter/material.dart';

class ProductCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'منتجاتنا',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductList(
                            category: "matelas"
                          )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CategoryContainer(imgUrl: 'images/matelas.png', text: 'ماطلات', color: 0xFF2C7DBF),
                    ),
                  ),
                  GestureDetector(
                    onTap:()=> print('سداري'),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  CategoryContainer(imgUrl: 'images/banquette.png', text: 'سداري', color: 0xFF84489B),
                    ),
                  ),
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:()=> print('مختلف'),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CategoryContainer(imgUrl: 'images/salon.png', text: 'مختلف', color: 0xFFE32A33),
                  ),
                ),
                GestureDetector(
                  onTap:()=> print('بونج'),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  CategoryContainer(imgUrl: 'images/mousse.png', text: 'بونج', color: 0xFF81BA48),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}