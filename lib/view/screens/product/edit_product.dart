import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/services/database_services.dart';
import 'package:gromart_admin_app/services/storage_services.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;
  final ProductController productController;
  const EditProductScreen({
    super.key,
    required this.product,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final StorageService storage = StorageService();
    final DatabaseServices database = DatabaseServices();

    productController.newProduct.addAll({
      'id': product.id,
      'name': product.name,
      'category': product.category,
      'description': product.description,
      'imageUrls': product.imageUrls,
      'isPopular': product.isPopular,
      'isRecommended': product.isRecommended,
      'isTodaySpecial': product.isTodaySpecial,
      'isTopRated': product.isTopRated,
      'price': product.price.toString(),
      'quantity': product.quantity.toString(),
    });
    productController.productImageUrls.value = product.imageUrls;
    List<String> textfieldHintText = [
      product.name,
      product.category,
      product.description,
      product.price.toString(),
      product.quantity.toString(),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: 'Edit Product',
          actionList: const [],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: ListView(
          children: [
            ProductAddImageWidget(
              productController: productController,
              storage: storage,
            ),
            const SizedBox(
              height: 10,
            ),
            const SectionTitleWidget(
              title: 'Update Information',
            ),
            ProductDetailsWidget(
              productController: productController,
              hintTexts: textfieldHintText,
              editPage: true,
            ),
            const SizedBox(height: 24.0),
            MainButtonWidget(
              buttonText: 'Update Product',
              onPressed: () async {
                log('*****************');
                log(product.id.toString());
                await database.updateProduct(
                  ProductModel(
                    id: productController.newProduct['id'] ?? product.id,
                    name: productController.newProduct['name'] ?? product.name,
                    category: productController.newProduct['category'] ??
                        product.category,
                    description: productController.newProduct['description'] ??
                        product.description,
                    imageUrls: productController.newProduct['imageUrls'] ??
                        product.imageUrls,
                    isRecommended:
                        productController.newProduct['isRecommended'] ?? false,
                    isPopular:
                        productController.newProduct['isPopular'] ?? false,
                    isTopRated:
                        productController.newProduct['isTopRated'] ?? false,
                    isTodaySpecial:
                        productController.newProduct['isTodaySpecial'] ?? false,
                    price: double.parse(productController.newProduct['price']),
                    quantity:
                        int.parse(productController.newProduct['quantity']),
                  ),
                );
                log('<<<<<<<<<<<<<<<<<<<here not edited>>>>>>>>>>>>>>>>>>>');
                log(productController.newProduct.toString());
                productController.onClose();
                log(productController.newProduct.toString());
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
