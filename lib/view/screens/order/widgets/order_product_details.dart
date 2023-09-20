import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/view/screens/product/product_screen.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
    required this.orderProductDetailsMap,
  });

  final Map<String, dynamic> orderProductDetailsMap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ProductController pController = Get.put(ProductController());
    ProductModel product = pController.products.firstWhere(
        (product) => product.id == orderProductDetailsMap['productId']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => ProductScreen(
                  product: product, productController: pController));
            },
            child: Material(
              elevation: 12,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                height: size.height * 0.15,
                width: size.width / 1,
                decoration: const BoxDecoration(
                  color: Color(0xffC8E6C9),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.imageUrls[0],
                          width: size.height * 0.12,
                          height: size.height * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '₹ ${product.price}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            const Divider(
                              color: Colors.black87,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${orderProductDetailsMap['quantity'] * product.price}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Text(
                                  'QTY : ${orderProductDetailsMap['quantity']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
