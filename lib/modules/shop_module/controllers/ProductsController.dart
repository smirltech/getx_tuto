import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_tuto/modules/shop_module/api/products_api.dart';
import 'package:getx_tuto/modules/shop_module/screens/detail/product_screen.dart';

import '../models/product.dart';

class ProductsController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> filteredProducts = RxList<Product>();
  var randomImage = ''.obs;
  var product = Rxn<Product>();
  var searchTerm = ''.obs;
  var searchEditingController = TextEditingController().obs;

  void filterIt(String searchTerm) {
    this.searchTerm.value = searchTerm;
  }

  Future<void> loadProducts() async {
    Response response = await ProductsApi.loadAll();
    if (response.statusCode == 200) {
      products.value = Product.listFromMap(response.body['products']);
      if (products.value.length > 0 && randomImage.value == '') {
        randomImage.value = products.value.first.thumbnail!;
      }
      if (filteredProducts.value.isEmpty) {
        filteredProducts.value = products.value;
      }
    }
    // log(response.bodyString!);
  }

  _updateRandomImage() async {
    while (true) {
      if (products.value.length > 0) {
        randomImage.value = products.value[math.Random().nextInt(products.value.length)].thumbnail!;
      }
      // log(randomImage.value);
      await 5.delay();
    }
  }

  @override
  void onInit() {
    loadProducts();
    super.onInit();
    _updateRandomImage();
    debounce(searchTerm, (e) {
      filteredProducts.value =
          products.value.where((product) => product.title!.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }, time: const Duration(milliseconds: 1000));
  }

  void viewProduct(Product value) {
    product.value = value;
    Get.to(() => ProductScreen());
  }
}
