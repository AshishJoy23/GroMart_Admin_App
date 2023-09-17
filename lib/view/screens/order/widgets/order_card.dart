import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/view/config/config.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 12,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: GestureDetector(
          onTap: () {
            Get.to(() => OrderInfoScreen());
          },
          child: Container(
            height: size.height * 0.3,
            width: size.width / 1,
            decoration: const BoxDecoration(
              color: Color(0xffC8E6C9),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              order.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Placed On:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14, color: Colors.black54),
                          ),
                          Text(
                            order.placedAt,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.black45,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivered To:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                          ),
                          const Text(
                            '',
                          ),
                          Text(
                            'No. of Items:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                          ),
                          Text(
                            'Payment Method:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                          ),
                          Text(
                            'Total Amount:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.address!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            Text(
                              'Phone: ${order.address!.phone}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              order.orderDetailsMap.length.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              order.paymentMethod,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              order.grandTotal.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      MainButtonWidget(
                        buttonText: 'Cancel',
                        onPressed: () {
                          Utils.showAlertDialogBox(context, 'Are You Sure?',
                              'Do you wnat to cancel the entire order.', () {
                            log('cancelled');
                            orderController.cancelOrder(order: order);
                            Utils.showSnackBar('Order is cancelled', Colors.redAccent);
                            Get.back();
                          });
                        },
                        heightFactor: 0.045,
                        isSubButton: true,
                      ),
                      MainButtonWidget(
                          buttonText: 'Confirm',
                          onPressed: () {
                            Utils.showAlertDialogBox(
                              context,
                              'Are You Sure?',
                              'Do you wnat to confirm the entire order.',
                              () {
                                orderController.confirmOrder(order: order);
                                Utils.showSnackBar('Order is confirmed', Colors.green);
                                Get.back();
                                log('confirmed');
                              },
                            );
                          },
                          heightFactor: 0.045),
                    ],
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
