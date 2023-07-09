import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gromart_admin_app/models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({
    super.key,
    required this.product,
  });

  static const String routeName = '/product';

  static Route route({required ProductModel product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProductScreen(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textData =
        'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. ';
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
          actionList: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit,color: Colors.black,),
            ),
            const SizedBox(width: 10,),
          ],
        ),
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.45,
                viewportFraction: 0.96,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: [
                CarouselCardWidget(
                  product: product,
                ),
              ],
            ),
            ProductNameAndPrice(product: product),
            DetailsExpansionTileWidget(
                textData: textData, titleData: 'Product Information'),
            DetailsExpansionTileWidget(
                textData: textData, titleData: 'Delivery Information'),
          ],
        ),
        // bottomNavigationBar: const ProductBottomAppBar(),
      ),
    );
  }
}