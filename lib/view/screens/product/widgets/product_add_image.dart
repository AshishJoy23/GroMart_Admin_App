import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/controllers.dart';
import '../../../../services/services.dart';

class ProductAddImageWidget extends StatelessWidget {
  const ProductAddImageWidget({
    super.key,
    required this.productController,
    required this.storage,
  });

  final ProductController productController;
  final StorageService storage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: (productController.productImageUrls.isEmpty)
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
                    await storage.uploadProductImage(image);
                    var imageUrl = await storage.getProductImageURL(image.name);
                    productController.productImageUrls.add(imageUrl);
                    productController.newProduct.update(
                      'imageUrls',
                      (_) => productController.productImageUrls,
                      ifAbsent: () => productController.productImageUrls,
                    );

                    log(productController.newProduct['imageUrls'].toString());
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
                    height: size.height * 0.3,
                    child: PageView.builder(
                      itemCount: productController.productImageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          productController.productImageUrls[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: SizedBox(
                      height: size.height * 0.28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton.small(
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
                                await storage.uploadProductImage(image);
                                var imageUrl =
                                    await storage.getProductImageURL(image.name);
                                productController.productImageUrls.add(imageUrl);
                                productController.newProduct.update(
                                  'imageUrls',
                                  (_) => productController.productImageUrls,
                                  ifAbsent: () => productController.productImageUrls,
                                );
                                log(productController.newProduct['imageUrls']
                                    .toString());
                              }
                            },
                            backgroundColor: Colors.black87,
                            child: const Icon(
                              Icons.delete_forever,
                              size: 24,
                            ),
                          ),
                          FloatingActionButton(
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
                                await storage.uploadProductImage(image);
                                var imageUrl =
                                    await storage.getProductImageURL(image.name);
                                productController.productImageUrls.add(imageUrl);
                                productController.newProduct.update(
                                  'imageUrls',
                                  (_) => productController.productImageUrls,
                                  ifAbsent: () => productController.productImageUrls,
                                );
                                log(productController.newProduct['imageUrls']
                                    .toString());
                              }
                            },
                            backgroundColor: Colors.black87,
                            child: const Icon(
                              Icons.add_photo_alternate,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
