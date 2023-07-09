import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class ProductCarouselWidget extends StatelessWidget {
  final List<ProductModel> products;
  const ProductCarouselWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: ProductCardWidget(
                product: products[index],
              ),
            );
          }),
    );
  }
}