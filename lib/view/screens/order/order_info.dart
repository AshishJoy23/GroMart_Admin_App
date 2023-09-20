import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/order_model.dart';
import 'package:gromart_admin_app/view/config/config.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class OrderInfoScreen extends StatelessWidget {
  final OrderModel order;
  const OrderInfoScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final OrderController ordController = Get.find<OrderController>();
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
          title: 'Order Info',
          actionList: const [],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        order.id,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      order.placedAt,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                Text(
                  'Order Products Detail:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.orderDetailsMap.length,
                  itemBuilder: (context, index) {
                    return OrderProductDetails(
                      orderProductDetailsMap: order.orderDetailsMap[index],
                    );
                  },
                ),
                OrderDeliverAddress(order: order),
                OrderPaymentSummary(order: order),
                Row(
                  children: [
                    MainButtonWidget(
                      buttonText: 'Cancel',
                      onPressed: () {
                        Utils.showAlertDialogBox(context, 'Are You Sure?',
                            'Do you wnat to cancel the entire order.', () {
                          log('cancelled');
                          ordController.cancelOrder(order: order);
                          Utils.showSnackBar(
                              'Order is cancelled', Colors.redAccent);
                          Get.back();
                        });
                      },
                      isSubButton: true,
                    ),
                  ],
                ),
                Row(
                  children: [
                    MainButtonWidget(
                      buttonText: 'Confirm',
                      onPressed: () {
                        Utils.showAlertDialogBox(
                          context,
                          'Are You Sure?',
                          'Do you wnat to confirm the entire order.',
                          () {
                            ordController.confirmOrder(order: order);
                            Utils.showSnackBar(
                                'Order is confirmed', Colors.green);
                            Get.back();
                            log('confirmed');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
