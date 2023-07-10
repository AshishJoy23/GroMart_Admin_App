import 'package:get/get.dart';
import 'package:gromart_admin_app/models/models.dart';
import '../services/services.dart';

class CategoryController extends GetxController {
  final DatabaseServices database = DatabaseServices();
  
  var categories= <CategoryModel>[].obs;
  var newProduct = {}.obs;

  @override
  void onInit() {
    categories.bindStream(database.getCategories());
    super.onInit();
  }

  @override
  void onClose() {
    newProduct.clear();
    super.onClose();
  }
}