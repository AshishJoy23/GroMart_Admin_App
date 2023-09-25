import 'dart:developer';
import 'package:get/get.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:intl/intl.dart';

import '../services/services.dart';

class OrderController extends GetxController {
  final DatabaseServices database = DatabaseServices();

  var orders = <OrderModel>[].obs;
  var pendingOrders = <OrderModel>[].obs;
  var activeOrders = <Map<String, dynamic>>[].obs;
  var completedOrders = <Map<String, dynamic>>[].obs;
  var orderDeliveryStatus = ''.obs;
  var updateOrderItemBtnFlag = false.obs;

  @override
  void onInit() async {
    super.onInit();
    orders.bindStream(database.getAllOrders());
    loadAllOrders();
  }

  void loadAllOrders() {
    // pending orders
    pendingOrders.clear();
    activeOrders.clear();
    completedOrders.clear();
    pendingOrders.value = orders
        .where((order) =>
            (order.isPlaced && !order.isCancelled && !order.isConfirmed))
        .toList();
    log('<<<<<<<pending orders>>>>>>>');
    log(pendingOrders.toString());
    log('<<<<<<<<<<<-------------------->>>>>>>>>>>');
    //active orders
    for (var order in orders) {
      if (order.isConfirmed && !order.isCancelled) {
        for (var orderItem in order.orderDetailsMap) {
          if (orderItem['isConfirmed'] &&
              !orderItem['isDelivered'] &&
              !orderItem['isCancelled']) {
            activeOrders.add(orderItem);
          }
        }
      }
      if (order.isConfirmed || order.isCancelled) {
        for (var orderItem in order.orderDetailsMap) {
          if (orderItem['isDelivered'] || orderItem['isCancelled']) {
            completedOrders.add(orderItem);
          }
        }
      }
    }
    log('<<<<<<<active orders>>>>>>>');
    log(activeOrders.toString());
    log('<<<<<<<<<<<-------------------->>>>>>>>>>>');
    log('<<<<<<<completed orders>>>>>>>');
    log(completedOrders.toString());
    log('<<<<<<<<<<<-------------------->>>>>>>>>>>');
  }

  void cancelOrder({required OrderModel order}) async {
    log(order.toString());
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
    for (var orderItem in order.orderDetailsMap) {
      orderItem['isCancelled'] = true;
      orderItem['cancelledAt'] = DateFormat('MMM d, yyyy').format(DateTime.now());
      updatedOrderDetailsMap.add(orderItem);
    }
    final OrderModel updatedOrder = OrderModel(
      id: order.id,
      email: order.email,
      orderDetailsMap: updatedOrderDetailsMap,
      address: order.address,
      paymentMethod: order.paymentMethod,
      placedAt: order.placedAt,
      isPlaced: order.isPlaced,
      isConfirmed: order.isConfirmed,
      isCancelled: true,
      subTotal: order.subTotal,
      deliveryFee: order.deliveryFee,
      grandTotal: order.grandTotal,
    );
    log('<<<<<<<<<<<<<<///////>>>>>>>>>>>>>>');
    log(updatedOrder.toString());
    await database.updateOrder(updatedOrder);
  }

  void confirmOrder({required OrderModel order}) async {
    log(order.toString());
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
    for (var orderItem in order.orderDetailsMap) {
      orderItem['isConfirmed'] = true;
      orderItem['confirmedAt'] = DateFormat('MMM d, yyyy').format(DateTime.now());
      updatedOrderDetailsMap.add(orderItem);
    }
    final OrderModel updatedOrder = OrderModel(
      id: order.id,
      email: order.email,
      orderDetailsMap: updatedOrderDetailsMap,
      address: order.address,
      paymentMethod: order.paymentMethod,
      placedAt: order.placedAt,
      isPlaced: order.isPlaced,
      isConfirmed: true,
      isCancelled: order.isCancelled,
      subTotal: order.subTotal,
      deliveryFee: order.deliveryFee,
      grandTotal: order.grandTotal,
    );
    log('<<<<<<<<<<<<<<///////>>>>>>>>>>>>>>');
    log(updatedOrder.toString());
    await database.updateOrder(updatedOrder);
  }

  void cancelOrderItem({required Map<String, dynamic> orderItem}) async {
    log('<<<<<<<<<cancel iten fn>>>>>>>>>');
    log(orderItem.toString());
    final OrderModel order =
        orders.firstWhere((order) => order.id == orderItem['orderId']);
    log(order.toString());
    log('<<<<<<<<<<before updating item>>>>>>>>>>');
    final int itemIndex =
        order.orderDetailsMap.indexWhere((item) => item == orderItem);
    orderItem['isCancelled'] = true;
    orderItem['cancelledAt'] = DateFormat('MMM d, yyyy').format(DateTime.now());
    order.orderDetailsMap[itemIndex] = orderItem;
    log(order.toString());
    log('<<<<<<<<<<after updating item>>>>>>>>>>');
    log('<<<<<<<<<<<<<<///////>>>>>>>>>>>>>>');
    await database.updateOrder(order);
  }

  void updateOrderItemStatus(
      {required Map<String, dynamic> orderItem,
      required String orderStatus}) async {
    log('<<<<<<<<iten status fn>>>>>>>>>');
    log(orderStatus);
    log(orderItem.toString());
    final OrderModel order =
        orders.firstWhere((order) => order.id == orderItem['orderId']);
    log(order.toString());
    log('<<<<<<<<<<before updating item>>>>>>>>>>');
    final int itemIndex =
        order.orderDetailsMap.indexWhere((item) => item == orderItem);
    if (orderStatus == 'Processed') {
      log('<<<<inside processed  if>>>>');
      orderItem['isProcessed'] = true;
      orderItem['processedAt'] =
          DateFormat('MMM d, yyyy').format(DateTime.now());
    } else if (orderStatus == 'Shipped') {
      log('<<<<inside shipped  if>>>>');
      orderItem['isShipped'] = true;
      orderItem['shippedAt'] = DateFormat('MMM d, yyyy').format(DateTime.now());
    } else {
      log('<<<<inside deliverd  if>>>>');
      orderItem['isDelivered'] = true;
      orderItem['deliveredAt'] =
          DateFormat('MMM d, yyyy').format(DateTime.now());
    }
    log('----------------------------------------------------------------');
    log(orderItem.toString());
    order.orderDetailsMap[itemIndex] = orderItem;
    log(order.toString());
    log('<<<<<<<<<<after updating item>>>>>>>>>>');
    await database.updateOrder(order);
  }
}
