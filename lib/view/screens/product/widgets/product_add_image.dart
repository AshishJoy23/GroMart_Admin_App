import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/controllers.dart';
import '../../../../services/services.dart';
import '../../../widgets/widgets.dart';

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
            ? AddImageButtonWidget(
              title: 'Choose an image',
                onTapFunction: () async {
                  await pickImageFromGallery(context);
                },
              )
            : SizedBox(
                height: size.height * 0.3,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: productController.productImageUrls.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                          width: size.width,
                          child: Image.network(
                            productController.productImageUrls[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff388E3C),
                                  backgroundColor: Colors.white,
                                ),
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
                                    // Delete the image from storage and remove it from the list
                                    var imageUrl = productController
                                        .productImageUrls[index];
                                    await storage.deleteProductImage(imageUrl);
                                    productController.productImageUrls
                                        .remove(imageUrl);
                                    productController.newProduct.update(
                                      'imageUrls',
                                      (_) => productController.productImageUrls,
                                      ifAbsent: () =>
                                          productController.productImageUrls,
                                    );
                                  },
                                  backgroundColor: Colors.black87,
                                  child: const Icon(
                                    Icons.delete_forever,
                                    size: 24,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () async {
                                    await pickImageFromGallery(context);
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
                    );
                  },
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
  }
}
