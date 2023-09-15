import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/banner_controller.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/services.dart';
import '../../../widgets/widgets.dart';

class CustomBannerWidget extends StatelessWidget {
  CustomBannerWidget({super.key});

  final BannerController bannerController = Get.put(BannerController());
  final DatabaseServices database = DatabaseServices();
  final StorageService storage = StorageService();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: (bannerController.banners.isEmpty)
            ? AddImageButtonWidget(
              title: 'Choose an image for the banner',
                onTapFunction: () async {
                  await pickImageFromGallery(context);
                },
              )
            : CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.58,
                  viewportFraction: 0.93,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  autoPlay: true,
                ),
                items: List.generate(
                  bannerController.banners.length,
                  (index) => CarouselCardWidget(
                    banner: bannerController.banners[index],
                    bannerController: bannerController,
                    storage: storage,
                    database: database,
                    title: 'New Offers',
                    onPressed: () async {
                      await pickImageFromGallery(context);
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Future pickImageFromGallery(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image was selected..'),
        ),
      );
    }
    if (image != null) {
      await storage.uploadBannerImage(image);
      var imageUrl = await storage.getBannerImageURL(image.name);
      bannerController.bannerImageUrl.value = imageUrl;
      DateTime currentTime = DateTime.now();
      int milliseconds = currentTime.millisecondsSinceEpoch;
      log(milliseconds.toString());
      await bannerController.newBanner.update(
        'id',
        (_) => milliseconds,
        ifAbsent: () => milliseconds,
      );
      await bannerController.newBanner.update(
        'imageUrl',
        (_) => bannerController.bannerImageUrl,
        ifAbsent: () => bannerController.bannerImageUrl,
      );
      database.addBanner(
        BannerModel(
          id: bannerController.newBanner['id'],
          imageUrl: bannerController.newBanner['imageUrl'].value,
        ),
      );
      log(bannerController.bannerImageUrl.toString());
    }
  }
}
