import 'package:cizaro_app/helper/database_helper.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCartScreen extends StatefulWidget {
  static final routeName = '/my-cart-screen';

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<ProductCart> cartItemsList = [];

  Widget getCartItems(){
    return FutureBuilder(
        future: _getData(),
        builder: (context,snapshot) {
          return createListView(context,snapshot);
        });
  }

  Future<List<ProductCart>> _getData() async {
    var dbHelper = DataBaseHelper.db;
    await dbHelper.getCartItems().then((value) {
      print('getValue : $value');
      cartItemsList = value;
    });
    return cartItemsList;
  }

  removeCartItem(int itemId) async {
    var dbHelper = DataBaseHelper.db;
    await dbHelper.deleteCartItem(itemId).then((value) {
      print('value : Deleted');
    });
  }

  updateCartItem(ProductCart productCart) async {
    var dbHelper = DataBaseHelper.db;
    await dbHelper.updateProduct(productCart).then((value) {
      print('updateValue : $value');
    });
  }

  createListView(BuildContext context, AsyncSnapshot snapshot) {
    cartItemsList = snapshot.data;

    if(cartItemsList != null || cartItemsList != []) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cartItemsList?.length ?? 0,
          itemBuilder: (ctx, index) => StatefulBuilder(builder: (BuildContext context, StateSetter setStateUpdate)
            {return  CartItem(
              key: UniqueKey(),
              imgUrl: cartItemsList[index].mainImg ??  "",
              productName: cartItemsList[index].name ?? "Treecode",
              productCategory:  cartItemsList[index].categoryName ?? "men fashion",
              productPrice: cartItemsList[index].price ?? 65,
              totalPrice: cartItemsList[index].price * cartItemsList[index].quantity ?? 49.99,
              productQuantity: cartItemsList[index].quantity ?? 1,
              myController: TextEditingController(text: cartItemsList[index].quantity.toString()),
              onDelete: () => setStateUpdate(() {
                removeCartItem(cartItemsList[index].id);
                cartItemsList.removeAt(index);
              }),
              onPlusQuantity: () {
                final productCart = ProductCart(
                    id: cartItemsList[index].id,
                    name: cartItemsList[index].name,
                    mainImg: cartItemsList[index].mainImg,
                    price: cartItemsList[index].price,
                    categoryName: cartItemsList[index].categoryName,
                    quantity: cartItemsList[index].quantity++,
                    availability: cartItemsList[index].quantity
                );
                setStateUpdate(() {
                  updateCartItem(productCart);
                });
              },
              onMinusQuantity: () {
                final productCart = ProductCart(
                    id: cartItemsList[index].id,
                    name: cartItemsList[index].name,
                    mainImg: cartItemsList[index].mainImg,
                    price: cartItemsList[index].price,
                    categoryName: cartItemsList[index].categoryName,
                    quantity: cartItemsList[index].quantity--,
                    availability: cartItemsList[index].quantity
                );
                setStateUpdate(() {
                  updateCartItem(productCart);
                });
                },
              onUpdateQuantity: () {
                final productCart = ProductCart(
                    id: cartItemsList[index].id,
                    name: cartItemsList[index].name,
                    mainImg: cartItemsList[index].mainImg,
                    price: cartItemsList[index].price,
                    categoryName: cartItemsList[index].categoryName,
                    quantity: int.parse(cartItemsList[index].quantity.toString()),
                    availability: cartItemsList[index].quantity
                );
                setStateUpdate(() {
                  updateCartItem(productCart);
                });
              },
            );}

          ),
        ),
      );
    }else {
      Container(child: Center(child: Text('Cart is Empty, please Search and Add your Product.',textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("My Cart"),
            getCartItems(),
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
                            '\$' + "45454",
                            textScaleFactor:
                            MediaQuery
                                .of(context)
                                .textScaleFactor * 1.4,
                            style: TextStyle(color: Color(0xff3A559F)),
                          ),
                        )
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
