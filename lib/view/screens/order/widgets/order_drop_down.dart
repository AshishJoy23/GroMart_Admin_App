import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';

class OrderDropDownFormWidget extends StatelessWidget {
  final Map<String, dynamic> orderItemDetailsMap;
  final OrderController ordController;
  const OrderDropDownFormWidget({
    required this.orderItemDetailsMap,
    required this.ordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> deliveryStatusOptions1 = [
      'Processed',
      'Shipped',
      'Delivered',
    ];
    List<String> deliveryStatusOptions2 = [
      'Shipped',
      'Delivered',
    ];
    List<String> deliveryStatusOptions3 = [
      'Delivered',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownButtonFormField(
        iconSize: 30,
        iconEnabledColor: Colors.black,
        hint: Text(orderItemDetailsMap['isShipped']
            ? 'Shipped'
            : orderItemDetailsMap['isProcessed']
                ? 'Processed'
                : 'Confirmed'),
        borderRadius: BorderRadius.circular(10),
        dropdownColor: const Color(0xffC8E6C9),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        items: (!orderItemDetailsMap['isProcessed'] &&
                !orderItemDetailsMap['isShipped'] &&
                !orderItemDetailsMap['isDelivered'])
            ? deliveryStatusOptions1.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList()
            : (orderItemDetailsMap['isProcessed'] &&
                    !orderItemDetailsMap['isShipped'] &&
                    !orderItemDetailsMap['isDelivered'])
                ? deliveryStatusOptions2.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList()
                : deliveryStatusOptions3.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
        onChanged: (value) {
          log(value!);
          ordController.updateOrderItemBtnFlag.value = true;
          ordController.orderDeliveryStatus.value = value;
          log('--------------------------------------------------------');
          log(ordController.orderDeliveryStatus.value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == 'Shipped') {
            log('enter ship if');
            return !orderItemDetailsMap['isProcessed']
                ? 'Order item is not yet processed'
                : null;
          }
          if (value == 'Delivered') {
            log('enter deliverr if');
            return !orderItemDetailsMap['isProcessed']
                ? 'Order item is not yet processed'
                : !orderItemDetailsMap['isShipped']
                    ? 'Order item is not yet shipped'
                    : null;
          }
          return null;
        },
      ),
    );
  }
}
