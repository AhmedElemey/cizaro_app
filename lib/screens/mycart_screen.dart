import 'package:cizaro_app/helper/database_helper.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatefulWidget {
  static final routeName = '/my-cart-screen';

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {

  @override
  void initState() {
    super.initState();
  }

  Widget cartProductsList() {
      final cart = Provider.of<CartViewModel>(context,listen: true);
      return cart.cartProductModel.length == 0 ? Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(25),
          child: Center(child: Text('Cart is Empty, please Search and Add your Product.',textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3))): Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cart.cartProductModel?.length ?? 0,
          itemBuilder: (ctx, index) => CartItem(
              imgUrl: cart.cartProductModel[index].mainImg,
              productName: cart.cartProductModel[index].name,
              productCategory:  cart.cartProductModel[index].categoryName,
              productPrice: cart.cartProductModel[index].price,
              totalAvailability: cart.cartProductModel[index].availability,
              totalPrice: cart.cartProductModel[index].price * cart.cartProductModel[index].quantity,
              productQuantity: cart.cartProductModel[index].quantity ?? 1,
              myController: TextEditingController(text: cart.cartProductModel[index].quantity.toString()),
              onDelete: () {
                cart.deleteCartProduct(index,cart.cartProductModel[index].id);
                setState(() {
                  cart.cartProductModel?.removeAt(index);
                }
                );},
              onPlusQuantity: () =>
                cart.increaseQuantity(index),
              onMinusQuantity: () =>
                cart.decreaseQuantity(index)))
      );

  }

  @override
  Widget build(BuildContext context) {
    final total = Provider.of<CartViewModel>(context,listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("My Cart"),
            cartProductsList(),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .1,
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .07,
                    child: Column(
                      children: [
                        Text(
                          "TOTAL",
                          textScaleFactor:
                          MediaQuery
                              .of(context)
                              .textScaleFactor * .9,
                        ),
                        Spacer(),
                        Container(
                            child: Text(
                              total.totalPrice.toString() ?? '00.00',
                              textScaleFactor:
                              MediaQuery
                                  .of(context)
                                  .textScaleFactor * 1.4,
                              style: TextStyle(color: Color(0xff3A559F)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .4,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .06,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: new EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "CHECKOUT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xff3A559F),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
