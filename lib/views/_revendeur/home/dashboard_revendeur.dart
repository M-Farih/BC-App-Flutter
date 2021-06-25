import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/views/widgets/ristourneWidget.dart';
import 'package:bc_app/views/widgets/sliderVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<RistourneProvider>(context, listen: false).getRistourneImage();
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      int id = Provider.of<AuthProvider>(context, listen: false).currentUsr.iduser;
      Provider.of<AuthProvider>(context, listen: false).getUserSolde(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var ristourneProvider = Provider.of<RistourneProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2C7DBF),
      body: ristourneProvider.isBusy
        ?Center(child: CircularProgressIndicator())
        :SingleChildScrollView(
        child: Center(
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
                        '${authProvider.solde} Dhs',
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
                Container(
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
                            SliderVerticalWidget(imgUrl: 'assets/images/mousse.png', title: 'بونج', turnover:  numbers2[0], maxi: max),
                            SliderVerticalWidget(imgUrl: 'assets/images/salon.png', title: 'مختلف', turnover:  numbers2[1], maxi: max),
                            SliderVerticalWidget(imgUrl: 'assets/images/banquette.png', title: 'سداري', turnover:  numbers2[2], maxi: max),
                            SliderVerticalWidget(imgUrl: 'assets/images/matelas.png', title: 'ماطلة', turnover:  numbers2[3], maxi: max),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                          RistourneWidget(isLocal: false, imageLink: ristourneProvider.image)
                    ],
                  ),

                )
              ],
            ),
          ),
      ),
    );
  }


}
