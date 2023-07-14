import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../widgets/widgets.dart';

class EachCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  EachCategoryScreen({
    super.key,
    required this.category,
  });


  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    final List<ProductModel> categoryProducts = productController.products
        .where((product) => product.category == category.name)
        .toList();
        log(categoryProducts.toString());
        log(category.name);
        
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
        backgroundColor: Colors.transparent,
        appBar: CustomAppBarWidget(
          title: category.name,
          actionList: const [],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          itemCount: categoryProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: ProductCardWidget(
                product: categoryProducts[index],
                productController: productController,
              ),
            );
          },
        ),
      ),
    );
  }
}
