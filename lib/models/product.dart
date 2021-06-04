class Product{

  final int idproduct;
  final String name;
  final String description;
  final String image;
  final int famille;

  Product(this.idproduct, this.name, this.description, this.image, this.famille);

  dynamic toJson() => {'idproduct': idproduct, 'name': name, 'description': description, 'image': image, 'famille': famille};

  Product.fromJson(Map<String, dynamic> json)
      : idproduct = json['idproduct'],
        name = json['name'],
        description = json['description'],
        image = json['image'],
        famille = json['famille'];
}