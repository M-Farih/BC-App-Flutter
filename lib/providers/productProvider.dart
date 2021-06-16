import 'dart:convert';

import 'package:bc_app/models/product.dart';
import 'package:bc_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier{
  bool isBusy = false;
  ProductService _productService = ProductService();
  List<Product> _product = List();
  List<Product> get product => _product;


  Future <void> getProducts(String id) async{
    isBusy = true;
    notifyListeners();
    var response = await _productService.getProducts(id);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print('product ---> ${data}');
      _product.clear();
      data['data'].forEach((p)=> _product.add(Product.fromJson(p)));
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(String name, String description, String image, String famille) async{
    isBusy = true;
    notifyListeners();
    var response =  await _productService.addProduct(name, description, image, famille);
    notifyListeners();
    isBusy = false;
  }

  Future<void> getProductById(String id) async{
    isBusy = true;
    notifyListeners();
    var response = await _productService.getProductById(id);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print('all products --> ${data}');
      data['data'].forEach((p)=> _product.add(Product.fromJson(p)));
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(String name, String description, String image, String famille, String id) async{
    isBusy = true;
    notifyListeners();
    var response =  await _productService.updateProduct(name, description, image, famille, id);
    notifyListeners();
    isBusy = false;
  }

  Future<void> deleteProduct(String id) async{
    print('del');
    isBusy = true;
    notifyListeners();
    var response = await _productService.deleteProduct(id);
    if(response.statusCode == 200 || response.statusCode == 201){
      isBusy = false;
      notifyListeners();
      print('${response.body}');
    }
  }
}