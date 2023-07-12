import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/controllers.dart';
import '../../../../services/services.dart';

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
            ? InkWell(
                onTap: () async {
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
                    var imageUrl =
                        await storage.getCategoryImageURL(image.name);
                    categoryController.categoryImageUrl.value = imageUrl;
                    await categoryController.newProduct.update(
                      'imageUrl',
                      (_) => categoryController.categoryImageUrl,
                      ifAbsent: () => categoryController.categoryImageUrl,
                    );

                    log(categoryController.newProduct['imageUrl'].toString());
                  }
                },
                child: Container(
                  color: Colors.black,
                  height: size.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 36,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Choose an image',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.3,
                    child: Image.network(
                      categoryController.categoryImageUrl.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () async {
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
                          var imageUrl =
                              await storage.getCategoryImageURL(image.name);
                          categoryController.categoryImageUrl.value = imageUrl;
                          await categoryController.newProduct.update(
                            'imageUrl',
                            (_) => categoryController.categoryImageUrl,
                            ifAbsent: () => categoryController.categoryImageUrl,
                          );

                          log(
                            categoryController.newProduct['imageUrl']
                                .toString(),
                          );
                        }
                      },
                      backgroundColor: Colors.black87,
                      child: const Icon(
                        Icons.add_photo_alternate,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
