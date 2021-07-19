import 'package:flutter/material.dart';

class sellerProductStatistics extends StatelessWidget {
  final String productImage, familleName, famillePrice;
  final int textColor;
  const sellerProductStatistics({
    Key key, this.productImage, this.textColor, this.familleName, this.famillePrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset("${productImage}", scale: 0.3,),
                      SizedBox(width: 10),
                      Text('${familleName}',style: TextStyle(color: Colors.black54, fontSize: 18))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                     Text('${famillePrice} Dhs', style: TextStyle(color: Color(textColor), fontSize: 19))

                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
