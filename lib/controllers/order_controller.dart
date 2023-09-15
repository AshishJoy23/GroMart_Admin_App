import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/models/models.dart';

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
}
