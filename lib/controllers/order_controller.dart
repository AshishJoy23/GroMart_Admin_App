import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void onInit() async {
    super.onInit();
    orders.bindStream(database.getAllOrders());
    loadAllOrders();
  }

  void loadAllOrders() {
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
          if (orderItem['isConfirmed'] && !orderItem['isDelivered'] ||
              !orderItem['isCancelled']) {
            activeOrders.add(orderItem);
          }
        }
      }
    }
    log('<<<<<<<active orders>>>>>>>');
    log(activeOrders.toString());
    log('<<<<<<<<<<<-------------------->>>>>>>>>>>');
    //completed orders
    for (var order in orders) {
      if (order.isConfirmed || order.isCancelled) {
        for (var orderItem in order.orderDetailsMap) {
          if (orderItem['isDelivered'] || orderItem['isCancelled']) {
            completedOrders.add(orderItem);
          }
        }
      }
    }
    log('<<<<<<<completed orders>>>>>>>');
    log(completedOrders.toString());
    log('<<<<<<<<<<<-------------------->>>>>>>>>>>');
  }

  void cancelOrder({required OrderModel order}) async {
    log(order.toString());
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
    for (var orderItem in order.orderDetailsMap) {
      Map<String, dynamic> eachOrder = {
        'orderId': order.id,
        'productId': orderItem['productId'],
        'quantity': orderItem['quantity'],
        'isConfirmed': orderItem['isConfirmed'],
        'confirmedAt': orderItem['confirmedAt'],
        'isProcessed': orderItem['isProcessed'],
        'processedAt': orderItem['processedAt'],
        'isShipped': orderItem['isShipped'],
        'shippedAt': orderItem['shippedAt'],
        'isDelivered': orderItem['isDelivered'],
        'deliveredAt': orderItem['deliveredAt'],
        'isCancelled': true,
        'cancelledAt': DateFormat('MMM d, yyyy').format(DateTime.now()),
      };
      updatedOrderDetailsMap.add(eachOrder);
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
      Map<String, dynamic> eachOrder = {
        'orderId': order.id,
        'productId': orderItem['productId'],
        'quantity': orderItem['quantity'],
        'isConfirmed': true,
        'confirmedAt': DateFormat('MMM d, yyyy').format(DateTime.now()),
        'isProcessed': orderItem['isProcessed'],
        'processedAt': orderItem['processedAt'],
        'isShipped': orderItem['isShipped'],
        'shippedAt': orderItem['shippedAt'],
        'isDelivered': orderItem['isDelivered'],
        'deliveredAt': orderItem['deliveredAt'],
        'isCancelled': orderItem['isCancelled'],
        'cancelledAt': orderItem['cancelledAt'],
      };
      updatedOrderDetailsMap.add(eachOrder);
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

  void cancelOrderItem(
      {required OrderModel order, required int productId}) async {
    log(order.toString());
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
    for (var orderItem in order.orderDetailsMap) {
      if (orderItem['productId'] == productId) {
        Map<String, dynamic> eachOrder = {
          'orderId': order.id,
          'productId': orderItem['productId'],
          'quantity': orderItem['quantity'],
          'isConfirmed': orderItem['isConfirmed'],
          'confirmedAt': orderItem['confirmedAt'],
          'isProcessed': orderItem['isProcessed'],
          'processedAt': orderItem['processedAt'],
          'isShipped': orderItem['isShipped'],
          'shippedAt': orderItem['shippedAt'],
          'isDelivered': orderItem['isDelivered'],
          'deliveredAt': orderItem['deliveredAt'],
          'isCancelled': true,
          'cancelledAt': DateFormat('MMM d, yyyy').format(DateTime.now()),
        };
        updatedOrderDetailsMap.add(eachOrder);
      } else {
        updatedOrderDetailsMap.add(orderItem);
      }
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
      isCancelled: order.isCancelled,
      subTotal: order.subTotal,
      deliveryFee: order.deliveryFee,
      grandTotal: order.grandTotal,
    );
    log('<<<<<<<<<<<<<<///////>>>>>>>>>>>>>>');
    log(updatedOrder.toString());
    await database.updateOrder(updatedOrder);
  }

  void updateOrderItemStatus(
      {required OrderModel order,
      required int productId,
      required String orderStatus}) async {
    log(order.toString());
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
    for (var orderItem in order.orderDetailsMap) {
      if (orderItem['productId'] == productId) {
        if (orderStatus == 'Processed') {
          orderItem['isProcessed'] = true;
          orderItem['processedAt'] =
              DateFormat('MMM d, yyyy').format(DateTime.now());
        } else if (orderStatus == 'Shipped') {
          orderItem['isShipped'] = true;
          orderItem['shippedAt'] =
              DateFormat('MMM d, yyyy').format(DateTime.now());
        } else {
          orderItem['isDelivered'] = true;
          orderItem['deliveredAt'] =
              DateFormat('MMM d, yyyy').format(DateTime.now());
        }
        // Map<String, dynamic> eachOrder = {
        //   'orderId': order.id,
        //   'productId': orderItem['productId'],
        //   'quantity': orderItem['quantity'],
        //   'isConfirmed': orderItem['isConfirmed'],
        //   'confirmedAt': orderItem['confirmedAt'],
        //   'isProcessed': orderItem['isProcessed'],
        //   'processedAt': orderItem['processedAt'],
        //   'isShipped': orderItem['isShipped'],
        //   'shippedAt': orderItem['shippedAt'],
        //   'isDelivered': orderItem['isDelivered'],
        //   'deliveredAt': orderItem['deliveredAt'],
        //   'isCancelled': true,
        //   'cancelledAt': DateFormat('MMM d, yyyy').format(DateTime.now()),
        // };
        updatedOrderDetailsMap.add(orderItem);
      } else {
        updatedOrderDetailsMap.add(orderItem);
      }
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
      isCancelled: order.isCancelled,
      subTotal: order.subTotal,
      deliveryFee: order.deliveryFee,
      grandTotal: order.grandTotal,
    );
    log('<<<<<<<<<<<<<<///////>>>>>>>>>>>>>>');
    log(updatedOrder.toString());
    await database.updateOrder(updatedOrder);
  }
}
