import 'package:bc_app/views/widgets/photoViewer.dart';
import 'package:bc_app/views/widgets/sliderVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:photo_view/photo_view.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  double value = 50;

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
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SliderVerticalWidget(imgUrl: 'images/matelas.png', title: 'بونج', turnover:  35064),
                            SliderVerticalWidget(imgUrl: 'images/salon.png', title: 'مختلف', turnover:  52264),
                            SliderVerticalWidget(imgUrl: 'images/banquette.png', title: 'سداري', turnover:  91159),
                            SliderVerticalWidget(imgUrl: 'images/mousse.png', title: 'ماطلة', turnover:  18161),
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
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
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
