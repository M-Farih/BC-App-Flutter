import 'package:bc_app/views/widgets/photoViewer.dart';
import 'package:bc_app/views/widgets/sliderVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:photo_view/photo_view.dart';


class Dashboard_revendeur extends StatefulWidget {
  @override
  _Dashboard_revendeurState createState() => _Dashboard_revendeurState();
}

class _Dashboard_revendeurState extends State<Dashboard_revendeur> {

  double value = 50;
  double max;
  List<double> numbers = [25000, 1500, 10000, 8484];
  Map<int , double> numbers2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    numbers.sort();
    max = numbers.last;
    max = max * 1.5;
    print('the bigger number --> ${numbers.last}');
    numbers2 = numbers.asMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C7DBF),
      body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      'المردود السنوي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                    child: Text(
                      '32 765,00 Dhs',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F4F7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)
                        )
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('المردود',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SliderVerticalWidget(imgUrl: 'images/matelas.png', title: 'بونج', turnover:  numbers2[0], maxi: max),
                              SliderVerticalWidget(imgUrl: 'images/salon.png', title: 'مختلف', turnover:  numbers2[1], maxi: max),
                              SliderVerticalWidget(imgUrl: 'images/banquette.png', title: 'سداري', turnover:  numbers2[2], maxi: max),
                              SliderVerticalWidget(imgUrl: 'images/mousse.png', title: 'ماطلة', turnover:  numbers2[3], maxi: max),
                            ],
                          ),
                        ),

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                              height: 150.0,
                              child: Center(
                                  child: GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset('images/restourne.png'),
                                      ),
                                      onTap: () {
                                        print("image clicked!!!");
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => MyPhotoViewer(imageUrl: 'images/restourne.png')));
                                      }
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                  )
              )
            ],
          ),
        ),
    );
  }
}
