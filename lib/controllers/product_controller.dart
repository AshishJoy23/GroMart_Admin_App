import 'package:get/get.dart';
import 'package:gromart_admin_app/models/models.dart';

import '../services/services.dart';

class ProductController extends GetxController {
  final DatabaseServices database = DatabaseServices();
  
  var products = <ProductModel>[].obs;
  var productImageUrls = <dynamic>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];
  get isTopRated => newProduct['isTopRated'];
  get isTodaySpecial => newProduct['isTodaySpecial'];

  @override
  void onClose() {
    newProduct.clear();
    productImageUrls.clear();
    super.onClose();
  }
}