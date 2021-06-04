import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/nombre_total_revendeur_provider.dart';
import 'package:bc_app/views/widgets/NombreRevendeurWidget.dart';
import 'package:bc_app/views/widgets/ristourneWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Dashboard_commercial extends StatefulWidget {
  @override
  _Dashboard_commercialState createState() => _Dashboard_commercialState();
}

class _Dashboard_commercialState extends State<Dashboard_commercial> {

  String count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NombreTotalRevendeurProvider>(context, listen: false).getStatisticsByCity();
      Provider.of<NombreTotalRevendeurProvider>(context, listen: false).getSellersCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    var nbrRevendeur = Provider.of<NombreTotalRevendeurProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xff2C7DBF),
      body: nbrRevendeur.isBusy
          ?Center(child: CircularProgressIndicator())
          :Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                    child: Text(
                      '${authProvider.currentUsr.firstName} ${authProvider.currentUsr.firstName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
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
                        SizedBox(height: 40.0),
                        NombreRevendeurWidget(nbrRevendeur: nbrRevendeur),

                        SizedBox(height: 30),
                        RestourneWidget()
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


