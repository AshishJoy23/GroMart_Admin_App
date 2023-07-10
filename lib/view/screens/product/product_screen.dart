import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/product_controller.dart';
import 'package:gromart_admin_app/models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  final ProductController productController;
  const ProductScreen({
    super.key,
    required this.product,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          title: 'Product Details',
          actionList: const [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.edit,color: Colors.black,),
            // ),
            SizedBox(
              width: 10,
            ),
          ],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: ListView(
          children: [
            // CarouselSlider(
            //   options: CarouselOptions(
            //     aspectRatio: 1.45,
            //     viewportFraction: 0.96,
            //     enlargeCenterPage: true,
            //     enlargeStrategy: CenterPageEnlargeStrategy.height,
            //   ),
            //   items: [
            //     CarouselCardWidget(
            //       product: product,
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: size.height * 0.3,
                child: PageView.builder(
                  itemCount: product.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      product.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            ProductNameAndPrice(product: product),
            DetailsExpansionTileWidget(
                textData: product.description,
                titleData: 'Product Information'),
            DetailsExpansionTileWidget(
                textData: product.description,
                titleData: 'Delivery Information'),
          ],
        ),
        // bottomNavigationBar: const ProductBottomAppBar(),
      ),
    );
  }
}
