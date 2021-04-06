import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/productCard.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {

  final String category;

  const ProductList({this.category});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back),
                    Text(
                      'المنتوجات',
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    )
                  ],
                ),
              ),
            ),
            GridView.count(
              childAspectRatio: 0.6,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ProductCard(name: 'Sleepwell',imgPath: 'images/1.png', desc: 'Le matelas est un élément essentiel du couchage de bébé. Votre bébé passe près de 18 heures par jour sur son matelas durant ses premiers mois. On considère qu’un bébé passe autant d’heures sur son matelas en 2 ans qu’un adulte en passe en 5 à 6 ans. Avec le matelas de bébé de Bonbino Confort on privilégie la sécurité, le confort et la qualité de l’air qu’il respire. Ainsi votre enfant sera confortablement installé dans son lit et pourra bénéficier de nuits calmes avec moins de réveils nocturnes. Il pourra ainsi bénéficier d’un sommeil de qualité qui aide à son bon développement physique et psychologique.',),
                ProductCard(name: 'Softy',imgPath: 'images/2.png', desc: 'Softy est un matelas à ressorts ensachés de haute technologie. Sa plus grande particularité...',),ProductCard(name: 'Sleepwell',imgPath: 'images/1.png', desc: 'Le nouveau matelas Sleepwell à ressorts bonnell est une garantie de fraîcheur.  Il vous offre ...',),
                ProductCard(name: 'Softy',imgPath: 'images/2.png', desc: 'Softy est un matelas à ressorts ensachés de haute technologie. Sa plus grande particularité...',),ProductCard(name: 'Sleepwell',imgPath: 'images/1.png', desc: 'Le nouveau matelas Sleepwell à ressorts bonnell est une garantie de fraîcheur.  Il vous offre ...',),
                ProductCard(name: 'Softy',imgPath: 'images/2.png', desc: 'Softy est un matelas à ressorts ensachés de haute technologie. Sa plus grande particularité...',),
                ],
            ),

          ],
        ),
      )
    );
  }
}
