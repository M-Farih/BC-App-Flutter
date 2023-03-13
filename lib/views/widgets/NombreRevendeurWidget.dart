import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/nombre_total_revendeur_provider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NombreRevendeurWidget extends StatefulWidget {
  const NombreRevendeurWidget({
    Key key,
    @required this.nbrRevendeur,
    this.citySelected,
  }) : super(key: key);

  final NombreTotalRevendeurProvider nbrRevendeur;
  final int citySelected;

  @override
  State<NombreRevendeurWidget> createState() => _NombreRevendeurWidgetState();
}

class _NombreRevendeurWidgetState extends State<NombreRevendeurWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserProvider>(context, listen: false);
      Provider.of<AuthProvider>(context, listen: false).currentUsr;

      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      int idvendor =
          Provider.of<AuthProvider>(context, listen: false).currentUsr.idvendor;
      Provider.of<UserProvider>(context, listen: false)
          .getSellersByAgent(idvendor);
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    int cityColor = 0xFFe5e5e7;
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
          width: MediaQuery.of(context).size.width - 50,
          height: 160.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              /// Nombre total des revendeurs
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(authProvider.currentUsr.idrole.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nombre total des revendeurs'),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Divider(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        authProvider.currentUsr.idrole == 2
                            ? '${userProvider.sellers.length} / ${widget.nbrRevendeur.sellersTotalCount}'
                            : '${widget.nbrRevendeur.sellersTotalCount}',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.nbrRevendeur.count}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                      height: 50,
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Center(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Text(
                                  '${widget.nbrRevendeur.sellersCount[index].city}',
                                  style: index != widget.citySelected
                                      ? TextStyle(color: Colors.grey)
                                      : TextStyle(color: Colors.blue)),
                              onTap: () {
                                widget.nbrRevendeur.getCitycount(index);
                              },
                            );
                          },
                          shrinkWrap: true,
                          itemCount: widget.nbrRevendeur.sellersCount.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              '|',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_outlined,
                              size: 16, color: Colors.blue.withOpacity(0.3)),
                          Icon(Icons.touch_app,
                              size: 18, color: Colors.blue.withOpacity(0.3)),
                          Icon(Icons.arrow_forward_outlined,
                              size: 16, color: Colors.blue.withOpacity(0.3)),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
