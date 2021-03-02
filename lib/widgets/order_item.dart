import 'package:cizaro_app/size_config.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String orderNumber,
      orderDate,
      orderShippingAddress,
      orderRecipient,
      orderPaymentMethod,
      orderStatus;
  final double orderTotal;
  final int orderStatusId, orderId;

  OrderItem(
      {this.orderNumber,
      this.orderId,
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
      height: SizeConfig.blockSizeVertical * 24,
      margin: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 4,
          left: SizeConfig.blockSizeHorizontal * 4,
          top: SizeConfig.blockSizeVertical * 1),
      child: Column(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ID',
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(
                    child: Text(
                        ' ------------------------------------------------------')),
                Text(
                  orderNumber ?? '162184',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Date',
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(
                    child: Text(
                        ' -----------------------------------------------')),
                Text(
                  orderDate ?? DateTime.now().toString().split(' ').first,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipped Address',
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(child: Text(' --------------')),
                Text(
                  orderShippingAddress ?? '12 st cairo',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
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
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(child: Text(' ------------------------------------')),
                Text(
                  orderPaymentMethod ?? '162184',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,

                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                      ' --------------------------------------------------------------'),
                ),
                Text(
                  orderTotal.toString() + ' L.E' ?? '162184',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status',
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                      ' ----------------------------------------------------------------'),
                ),
                Text(
                  orderStatus ?? 'Ordered',
                  // textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.1,
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3.2,
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
              width: SizeConfig.blockSizeHorizontal * 94,
              height: SizeConfig.blockSizeVertical * 1.5,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
              color: Colors.grey.shade300)
        ],
      ),
    );
  }
}