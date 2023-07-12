import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/view/screens/product/edit_product.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../screens/screens.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final ProductController productController;
  ProductCardWidget({
    super.key,
    required this.product,
    required this.productController,
  });

  final DatabaseServices database = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    var heightScrn = MediaQuery.of(context).size.height / 5;
    var widthScrn = MediaQuery.of(context).size.width / 2.5;
    return InkWell(
      onTap: () {
        Get.to(() => ProductScreen(
              product: product,
              productController: productController,
            ));
      },
      child: Stack(
        children: [
          SizedBox(
            width: widthScrn,
            height: heightScrn,
            child: Image.network(
              product.imageUrls[0],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Container(
              width: widthScrn,
              height: heightScrn,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  iconSize: 30,
                  padding: const EdgeInsets.all(1.0),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Edit",
                      child: TextButton(
                        onPressed: () async{
                          await Get.to(() => EditProductScreen(
                                product: product,
                                productController: productController,
                              ));
                          Get.back();
                        },
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "Delete",
                      child: TextButton(
                        onPressed: () async {
                          await database.deleteProduct(product.id);
                          Get.back();
                        },
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: widthScrn,
              height: heightScrn * 0.35,
              decoration: BoxDecoration(
                color: const Color(0xff388E3C).withAlpha(230),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          '\$${product.price}',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
