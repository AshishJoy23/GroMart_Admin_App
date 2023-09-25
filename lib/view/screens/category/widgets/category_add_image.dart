import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/controllers.dart';
import '../../../../services/services.dart';
import '../../../widgets/widgets.dart';

class CategoryAddImageWidget extends StatelessWidget {
  const CategoryAddImageWidget({
    super.key,
    required this.categoryController,
    required this.storage,
  });

  final CategoryController categoryController;
  final StorageService storage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: (categoryController.categoryImageUrl.isEmpty)
            ? AddImageButtonWidget(
                title: 'Choose an image',
                onTapFunction: () async {
                  await pickImageFromGallery(context);
                },
              )
            : Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.3,
                    child: Image.network(
                      categoryController.categoryImageUrl.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      MainButtonWidget(
                        isSubButton: true,
                        buttonText: 'Change Image',
                        onPressed: () async {
                          await pickImageFromGallery(context);
                        },
                      ),
                    ],
                  ),
                ],
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
      await storage.uploadCategoryImage(image);
      var imageUrl = await storage.getCategoryImageURL(image.name);
      categoryController.categoryImageUrl.value = imageUrl;
      await categoryController.newProduct.update(
        'imageUrl',
        (_) => categoryController.categoryImageUrl,
        ifAbsent: () => categoryController.categoryImageUrl,
      );
      log(categoryController.newProduct['imageUrl'].toString());
    }
  }
}
