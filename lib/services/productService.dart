import 'package:bc_app/models/product.dart';


class ProductService{

  static List<Product> products = List<Product>();

  ///fill
  static Future <List<Product>> fillProduct() async{

    Product p1 = new Product(1, 'images/1.png', 'MATELAS DE BÉBÉ', 400.0 , 'Le matelas est un élément essentiel du couchage de bébé. Votre bébé passe près de 18 heures par jour sur son matelas durant ses premiers mois. On considère qu’un bébé passe autant d’heures sur son matelas en 2 ans qu’un adulte en passe en 5 à 6 ans. Avec le matelas de bébé de Bonbino Confort on privilégie la sécurité, le confort et la qualité de l’air qu’il respire. Ainsi votre enfant sera confortablement installé dans son lit et pourra bénéficier de nuits calmes avec moins de réveils nocturnes. Il pourra ainsi bénéficier d’un sommeil de qualité qui aide à son bon développement physique et psychologique.', 'MATELAS', ['120*60', '140*70'], ['Bleu bebe', 'Rose bebe']);
    products.add(p1);

    Product p2 = new Product(2, "images/3.png", 'PLAISIDORT', 638.0 , 'La banquette Plaisidort en ressort et en mousse agglomérée de qualité supérieure est conçue avec passion et finesse pour vous procurer un moment agréable et chaleureux. Composée de tissu cotonneux nappe piqué avec 250 gr/m2 de ouate, elle vous offre une meilleure sensation de confort et d\'accueil. Optez pour une bonne hygiène, en choisissant cette banquette en tissu anti-allergique et anti-acariens, dont la composition et le raffinement charmeront bien vos invités. ', 'BANQUETTES', ['L100*P70*H25', 'L100*P70*H28', 'L100*P70*H30'], ['Bleu']);
    products.add(p2);

    Product p3 = new Product(3, "images/5.png", 'SALON CANARIES', 17000.00 , 'Chaque élément du salon Canaries est passé entre les mains d\'un artisan qualifié pour vous offrir le meilleur des deux mondes: Modernité et tradition. Il est construit sur une base solide en bois de pin, avec un dossier épais et une profondeur d’assise large, tout, pour garantir un confort irréprochable.  Son somptueux tissu en velours est doux au toucher tandis que ses coussins en brocart ajoutent une touche de glamour.', 'AMEUBLEMENT', ['3.15 x 3.15 m'], ['-']);
    products.add(p3);

    Product p4 = new Product(4, "images/4.png", 'SALON FLOWERS', 13000.00 , 'Le salon Flowers agence élégance et raffinement, grâce à son tissu fleuri harmonisé avec du velours qui donnera de la fraîcheur à votre espace. Parfaitement élaboré, jusqu\'aux moindres détails, sur une base solide en bois de pin qui apporte à son aspect plus de robustesse. Mieux encore, il s’agit d’un contrat de qualité, ce salon a été conçu pour résister à un usage très fréquenté.', 'AMEUBLEMENT', ['130 x 105 cm'], ['Bleu']);
    products.add(p4);

    return products;
  }


}