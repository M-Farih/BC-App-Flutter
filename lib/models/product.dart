class Product{

  final int id;
  final String p_image;
  final String p_title;
  final double p_price;
  final String p_description;
  final String p_category;
  final List<String> p_dimentions;
  final List<String> colors;

  Product(this.id, this.p_image, this.p_title, this.p_price, this.p_description,
      this.p_category, this.p_dimentions, this.colors);

  dynamic toJson() => {'id': id, 'p_image': p_image, 'p_title': p_title, 'p_price': p_price, 'p_description': p_description, 'p_category': p_category, 'p_dimentions': p_dimentions, 'colors': colors};

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        p_image = json['p_image'],
        p_title = json['p_title'],
        p_price = json['p_price'],
        p_description = json['p_description'],
        p_category = json['p_category'],
        p_dimentions = json['p_dimentions'],
        colors = json['colors'];

}