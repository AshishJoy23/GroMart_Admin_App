import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/order_model.dart';
import 'package:gromart_admin_app/view/config/config.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class OrderItemInfoScreen extends StatelessWidget {
  final Map<String, dynamic> orderItemDetailsMap;
  final bool isActive;
  const OrderItemInfoScreen({
    super.key,
    required this.orderItemDetailsMap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final OrderController ordController = Get.find<OrderController>();
    final OrderModel order = ordController.orders
        .firstWhere((order) => order.id == orderItemDetailsMap['orderId']);
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
        appBar: CustomAppBarWidget(
          title: 'Order Info',
          actionList: const [],
          leadingOnPressed: () {
            ordController.updateOrderItemBtnFlag.value = false;
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
                (isActive)
                    ? SizedBox(
                        height: size.height * 0.09,
                        child: Row(
                          children: [
                            Text(
                              'Order Status: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: OrderDropDownFormWidget(
                                orderItemDetailsMap: orderItemDetailsMap,
                                ordController: ordController,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const Divider(
                  color: Colors.black,
                ),
                Text(
                  'Order Product Detail:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                OrderProductDetails(
                  orderProductDetailsMap: orderItemDetailsMap,
                ),
                OrderDeliverAddress(order: order),
                OrderPaymentSummary(order: order),
                (isActive)
                    ? Column(
                        children: [
                          Row(
                            children: [
                              MainButtonWidget(
                                buttonText: 'Cancel Order',
                                onPressed: () {
                                  Utils.showAlertDialogBox(
                                      context,
                                      'Are You Sure?',
                                      'Do you want to cancel the order item.',
                                      () {
                                    log('cancelled');
                                    ordController.cancelOrderItem(
                                        orderItem: orderItemDetailsMap);
                                    Utils.showSnackBar(
                                        'Order is cancelled', Colors.redAccent);
                                    Get.back();
                                  });
                                },
                                isSubButton: true,
                              ),
                            ],
                          ),
                          Obx(
                            () => (ordController.updateOrderItemBtnFlag.value)
                                ? Row(
                                    children: [
                                      MainButtonWidget(
                                        buttonText: 'Update Order',
                                        onPressed: () {
                                          Utils.showAlertDialogBox(
                                            context,
                                            'Are You Sure?',
                                            'Do you want to update the order status.',
                                            () {
                                              ordController
                                                  .updateOrderItemBtnFlag
                                                  .value = false;
                                              ordController
                                                  .updateOrderItemStatus(
                                                      orderItem: orderItemDetailsMap,
                                                      orderStatus: ordController.orderDeliveryStatus.value);
                                              Utils.showSnackBar(
                                                  'Order status is updated',
                                                  Colors.green);
                                              Get.back();
                                              log('updated');
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
