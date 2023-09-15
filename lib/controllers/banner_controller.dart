import 'package:get/get.dart';
import 'package:gromart_admin_app/models/models.dart';
import '../services/services.dart';

class BannerController extends GetxController {
  final DatabaseServices database = DatabaseServices();
  
  var banners = <BannerModel>[].obs;
  var newBanner = {}.obs;
  var bannerImageUrl = ''.obs;

  @override
  void onInit() {
    banners.bindStream(database.getBanners());
    super.onInit();
  }

  @override
  void onClose() {
    newBanner.clear();
    super.onClose();
  }
}