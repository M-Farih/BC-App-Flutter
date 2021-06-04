import 'package:bc_app/views/widgets/photoViewer.dart';
import 'package:flutter/material.dart';

class RestourneWidget extends StatefulWidget {
  @override
  _RestourneWidgetState createState() => _RestourneWidgetState();
}

class _RestourneWidgetState extends State<RestourneWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width -50,
            height: 230.0,
            child: Center(
                child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('أساس حساب الخصم',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              )
                            ],
                          ),
                          Image.asset('assets/images/restourne.png'),
                        ],
                      ),
                    ),
                    onTap: () {
                      print("image clicked!!!");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyPhotoViewer(imageUrl: 'assets/images/restourne.png')));
                    }
                )
            ),
          ),
        ),
      ],
    );
  }
}
