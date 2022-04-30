import 'package:get/get.dart';
import 'package:getx_tuto/modules/shop_module/api/configs.dart';

class ProductsApi {
  static Future<Response> loadAll() async {
    return GetConnect().get(PRODUCTS_URL);
  }
}
