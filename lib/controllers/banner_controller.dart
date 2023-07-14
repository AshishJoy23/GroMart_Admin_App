import 'package:get/get.dart';

class BannerController extends GetxController {
  var bannerImageUrls = <dynamic>[].obs;
  @override
  void onInit() {
    bannerImageUrls.clear();
    super.onInit();
  }
  @override
  void onClose() {
    bannerImageUrls.clear();
    super.onClose();
  }
}