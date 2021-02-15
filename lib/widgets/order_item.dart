import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String orderId,
      orderDate,
      orderShippingAddress,
      orderRecipient,
      orderPaymentMethod,
      orderStatus;
  final double orderTotal;
  final int orderStatusId;

  OrderItem(
      {this.orderId,
      this.orderDate,
      this.orderShippingAddress,
      this.orderRecipient,
      this.orderPaymentMethod,
      this.orderStatus,
      this.orderStatusId,
      this.orderTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ID',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text('------------------------------------------------------'),
                Text(orderId ?? '162184'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Date',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text('-----------------------------------------------'),
                Text(orderDate ?? DateTime.now().toString().split(' ').first),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipped Address',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text('---------'),
                Text(orderShippingAddress ?? '12 st cairo'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Flexible(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Recipient',
          //           textScaleFactor:
          //               MediaQuery.of(context).textScaleFactor * 1.2,
          //           style: const TextStyle(
          //               color: Color(0xff707070), fontWeight: FontWeight.bold)),
          //       Text(
          //           '-----------------------------------------------------------'),
          //       Text(orderRecipient ?? '162184'),
          //     ],
          //   ),
          // ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Method',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text('------------------------------------'),
                Text(orderPaymentMethod ?? '162184'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text(
                    '--------------------------------------------------------------'),
                Text(orderTotal.toString() + ' L.E' ?? '162184'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: const TextStyle(
                        color: Color(0xff707070), fontWeight: FontWeight.bold)),
                Text(
                    '----------------------------------------------------------------'),
                Text(
                  orderStatus ?? 'Ordered',
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                  style: TextStyle(
                      color: orderStatusId == 1
                          ? Colors.green
                          : orderStatusId == 2
                              ? Colors.red
                              : Colors.blueAccent),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.94,
              height: MediaQuery.of(context).size.height * 0.015,
              margin: const EdgeInsets.only(top: 15),
              color: Colors.grey.shade300)
        ],
      ),
    );
  }
}
