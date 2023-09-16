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
  var activeOrders = <OrderModel>[].obs;
  var completedOrders = <OrderModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    orders.bindStream(database.getAllOrders());
    loadAllOrders();
  }

  void loadAllOrders() {
    pendingOrders.value = orders
        .where((order) =>
            (order.isPlaced == true &&
            order.isCancelled == false &&
            order.isConfirmed == false))
        .toList();
        log('<<<<<<<laoding>>>>>>>');
        log(pendingOrders.toString());
  }

  void cancelEntireOrder({required OrderModel order}){
    final List<Map<String, dynamic>> updatedOrderDetailsMap = [];
      for (var orderItem in order.orderDetailsMap)  {
        Map<String, dynamic> eachOrder = {
          'orderId': order.id,
          'productId': orderItem['productId'],
          'quantity': orderItem['quantity'],
          'isConfirmed': false,
          'confirmedAt': '',
          'isProcessed': false,
          'processedAt': '',
          'isShipped': false,
          'shippedAt': '',
          'isDelivered': false,
          'deliveredAt': '',
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
        isPlaced: true,
        isConfirmed: false,
        isCancelled: true,
        subTotal: order.subTotal,
        deliveryFee: order.deliveryFee,
        grandTotal: order.grandTotal,
      );
  }
}
