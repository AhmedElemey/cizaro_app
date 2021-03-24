import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatefulWidget {
  final ProductCart item;
  final int index;
  final CartViewModel cartProvider;

  CartItem({Key key, this.item, this.index, this.cartProvider})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  TextEditingController quantityController;
  CartViewModel cartProvider;
  @override
  void initState() {
    super.initState();
    cartProvider = widget.cartProvider;
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5),
      child: Card(
        elevation: 5,
        child: Container(
          height: SizeConfig.blockSizeVertical * 27,
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2,
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeVertical * 18,
                          child: Image.network(widget.item.mainImg,
                              fit: BoxFit.fitHeight)))),
              Flexible(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 5.5,
                            child: Text(
                              widget.item.name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5,
                                  color: Color(0xff515C6F)),
                            ),
                          ),
                          Spacer(),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                  left: SizeConfig.blockSizeHorizontal * 1),
                              child: Text(
                                widget.item.priceAfterDiscount ==
                                        widget.item.price
                                    ? widget.item.price.toString() + ' le'.tr()
                                    : widget.item.priceAfterDiscount == null
                                        ? widget.item.price.toString() +
                                            ' le'.tr()
                                        : widget.item.priceAfterDiscount == 0
                                            ? widget.item.price.toString()
                                            : widget.item.priceAfterDiscount
                                                    .toString() +
                                                ' le'.tr(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 3.5,
                                    color: Color(0xff515C6F)),
                              ))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Text(
                                widget.item.categoryName,

                                // style: const TextStyle(color: Colors.blueGrey)
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 3,
                                    color: Color(0xff515C6F)),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(Icons.delete,
                                    size: SizeConfig.safeBlockHorizontal * 6,
                                    color: Colors.red),
                                onPressed: () => cartProvider.deleteCartProduct(
                                    index: widget.index,
                                    productId: widget.item.id))
                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        child: Row(
                          children: [
                            Text(
                              widget.item.sizeSpecValue == "" ||
                                      widget.item.sizeSpecValue == null
                                  ? ''
                                  : 'Size : ${widget.item.sizeSpecValue}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                            ),
                            Text(
                                widget.item.colorSpecValue == "" ||
                                        widget.item.colorSpecValue == null
                                    ? ''
                                    : ' , ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4)),
                            Text(
                                widget.item.colorSpecValue == "" ||
                                        widget.item.colorSpecValue == null
                                    ? ''
                                    : 'Color : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4)),
                            widget.item.colorSpecValue == "" ||
                                    widget.item.colorSpecValue == null
                                ? Container()
                                : CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(int.parse(
                                        '0xff${widget.item.colorSpecValue}')),
                                    foregroundColor: Color(int.parse(
                                        '0xff${widget.item.colorSpecValue}'))),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () =>
                                cartProvider.decreaseQuantity(widget.index),
                            child: CircleAvatar(
                              radius: SizeConfig.blockSizeHorizontal * 3,
                              backgroundColor: Colors.black12,
                              child: Center(
                                child: Icon(CupertinoIcons.minus,
                                    size: SizeConfig.safeBlockHorizontal * 5,
                                    color: Color(0xff707070)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2),
                            width: SizeConfig.blockSizeHorizontal * 9,
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left:
                                          SizeConfig.blockSizeHorizontal * .07),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal *
                                          .07)),
                              controller: TextEditingController(
                                  text: widget.item.quantity.toString()),
                              onChanged: (value) {
                                widget.item.quantity = int.parse(value);
                                if (widget.item.quantity >=
                                    widget.item.availability) {
                                  widget.item.quantity =
                                      widget.item.availability;
                                } else if (widget.item.quantity == 0) {
                                  widget.item.quantity = 1;
                                }
                                cartProvider.updateQuantity(
                                    index: widget.index,
                                    productId: widget.item.id,
                                    quantity: widget.item.quantity ?? 1);
                              },
                            ),
                          ),
                          widget.item.availability - 1 >= widget.item.quantity
                              ? GestureDetector(
                                  onTap: () => cartProvider
                                      .increaseQuantity(widget.index),
                                  child: CircleAvatar(
                                    radius: SizeConfig.blockSizeHorizontal * 3,
                                    backgroundColor: Colors.black12,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size:
                                            SizeConfig.safeBlockHorizontal * 5,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: SizeConfig.blockSizeHorizontal * 3,
                                  backgroundColor: Colors.black12,
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: SizeConfig.safeBlockHorizontal * 5,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                left: SizeConfig.blockSizeHorizontal * 1),
                            child: Column(
                              children: [
                                Text(
                                  "TOTAL",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.5),
                                ),
                                Text(
                                  "${cartProvider.getTotalPriceOfItem(widget.item).toStringAsFixed(2) + ' le'.tr()}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      color: Color(0xff3A559F)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      widget.item.availability <= widget.item.quantity ?? 1
                          ? Center(
                              child: Text(
                                  "${widget.item.availability}" +
                                          "available".tr() ??
                                      '',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4)))
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
