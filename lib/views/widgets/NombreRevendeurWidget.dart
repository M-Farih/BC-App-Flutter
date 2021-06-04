import 'package:bc_app/providers/nombre_total_revendeur_provider.dart';
import 'package:flutter/material.dart';

class NombreRevendeurWidget extends StatelessWidget {
  const NombreRevendeurWidget({
    Key key,
    @required this.nbrRevendeur,
  }) : super(key: key);

  final NombreTotalRevendeurProvider nbrRevendeur;

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width -50,
          height: 150.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              /// Nombre total des revendeurs
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nombre total des revendeurs'),
                      Container(width: MediaQuery.of(context).size.width * 0.25,child: Divider(color: Colors.black54)),
                      Text('${nbrRevendeur.sellersTotalCount.toString()}', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${nbrRevendeur.count}', style: TextStyle(color: Colors.blue, fontSize: 50.0, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width-50,
                    child: ListView.separated(
                      itemBuilder: (context, index){
                        return GestureDetector(
                          child: Text('${nbrRevendeur.sellersCount[index].city}'),
                          onTap: (){
                            nbrRevendeur.getCitycount(index);
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: nbrRevendeur.sellersCount.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_ , __) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text('|', style: TextStyle(color: Colors.grey),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_outlined, size: 16, color: Colors.blue.withOpacity(0.3)),
                      Icon(Icons.touch_app, size: 18, color: Colors.blue.withOpacity(0.3)),
                      Icon(Icons.arrow_forward_outlined, size: 16, color: Colors.blue.withOpacity(0.3)),
                    ],
                  )
                ],

              ),
            ),
          ),
        )
      ],
    );
  }
}