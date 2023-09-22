import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/order_model.dart';
import 'package:gromart_admin_app/view/screens/order/widgets/order_card.dart';
import 'package:gromart_admin_app/view/screens/order/widgets/order_item_card.dart';
import '../../widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());

    log(orderController.pendingOrders.toString());
    //orderController.loadAllOrders();
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
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const MainAppBarWidget(
              title: 'Orders',
              isOrder: true,
              heightFactor: 90,
            ),
            body: TabBarView(
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      //padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: orderController.pendingOrders.length,
                      itemBuilder: (context, index) {
                        final OrderModel order =
                            orderController.pendingOrders[index];
                        return OrderCardWidget(order: order);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      //padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: orderController.activeOrders.length,
                      itemBuilder: (context, index) {
                        var orderItem = orderController.activeOrders[index];
                        return OrderItemCardWidget(
                          orderProductDetailsMap: orderItem,
                          isActive: true,
                        );
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      //padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: orderController.completedOrders.length,
                      itemBuilder: (context, index) {
                        var orderItem = orderController.completedOrders[index];
                        return OrderItemCardWidget(
                            orderProductDetailsMap: orderItem);
                      },
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const MainBottomNavBar(),
          ),
        ));
  }
}
