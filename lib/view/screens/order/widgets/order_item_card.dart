import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/view/config/config.dart';
import 'package:gromart_admin_app/view/screens/order/order_item_info.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class OrderItemCardWidget extends StatelessWidget {
  const OrderItemCardWidget({
    super.key,
    required this.orderProductDetailsMap,
    this.isActive = false,
  });

  final Map<String, dynamic> orderProductDetailsMap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ProductController pController = Get.put(ProductController());
    final OrderController odrController = Get.put(OrderController());
    ProductModel product = pController.products.firstWhere(
        (product) => product.id == orderProductDetailsMap['productId']);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 12,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: GestureDetector(
          onTap: () {
            Get.to(() => OrderItemInfoScreen(
                  orderItemDetailsMap: orderProductDetailsMap,
                  isActive: isActive,
                ));
          },
          child: Container(
            height: size.height * 0.18,
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
                      width: size.height * 0.14,
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                (orderProductDetailsMap['isCancelled'])
                                    ? 'Cancelled'
                                    : (orderProductDetailsMap['isDelivered'])
                                        ? 'Delivered'
                                        : (orderProductDetailsMap['isShipped'])
                                            ? 'Shipped'
                                            : (orderProductDetailsMap[
                                                    'isProcessed'])
                                                ? 'Processed'
                                                : 'Confirmed',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            isActive
                                ? MainButtonWidget(
                                    buttonText: 'Cancel',
                                    onPressed: () {
                                      Utils.showAlertDialogBox(
                                          context,
                                          'Are You Sure?',
                                          'Do you wnat to cancel the entire order.',
                                          () {
                                        log('cancelled');
                                        odrController.cancelOrderItem(
                                            orderItem: orderProductDetailsMap);
                                        Utils.showSnackBar(
                                            'Order Item is cancelled',
                                            Colors.redAccent);
                                        Get.back();
                                      });
                                    },
                                    heightFactor: 0.035,
                                    isSubButton: true,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${orderProductDetailsMap['quantity']} x ${product.price}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              '${orderProductDetailsMap['quantity'] * product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                (orderProductDetailsMap['isCancelled'])
                                    ? 'Cancelled on :'
                                    : (orderProductDetailsMap['isDelivered'])
                                        ? 'Delivered on :'
                                        : (orderProductDetailsMap['isShipped'])
                                            ? 'Shipped on :'
                                            : (orderProductDetailsMap[
                                                    'isProcessed'])
                                                ? 'Processed on :'
                                                : (orderProductDetailsMap[
                                                        'isConfirmed'])
                                                    ? 'Confirmed on :'
                                                    : 'Placed on :',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              (orderProductDetailsMap['isCancelled'])
                                  ? '${orderProductDetailsMap['cancelledAt']}'
                                  : (orderProductDetailsMap['isDelivered'])
                                      ? '${orderProductDetailsMap['deliveredAt']}'
                                      : (orderProductDetailsMap['isShipped'])
                                          ? '${orderProductDetailsMap['shippedAt']}'
                                          : (orderProductDetailsMap[
                                                  'isProcessed'])
                                              ? '${orderProductDetailsMap['processedAt']}'
                                              : '${orderProductDetailsMap['confirmedAt']}',
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
    );
  }
}
