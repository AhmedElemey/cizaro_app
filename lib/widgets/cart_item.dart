import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatefulWidget {
  final String productName,
      imgUrl,
      colorSpecValue,
      sizeSpecValue,
      productCategory;
  int productQuantity, totalAvailability, index, id;
  final double totalPrice, productPrice, productPriceAfterDiscount;
  var myController = TextEditingController();
  final VoidCallback onDelete;
  // final VoidCallback onPlusQuantity;
  // final VoidCallback onMinusQuantity;
  // final Function onUpdateQuantity;
  final CartViewModel cartProvider;

  CartItem(
      {Key key,
      this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfterDiscount,
      this.productCategory,
      this.totalAvailability,
      this.myController,
      this.totalPrice,
      this.productQuantity,
      this.index,
      this.id,
      this.onDelete,
      // this.onMinusQuantity,
      this.colorSpecValue,
      this.sizeSpecValue,
      // this.onUpdateQuantity,
      // this.onPlusQuantity,
      this.cartProvider})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // TextEditingController quantityController = TextEditingController();
  var cartProvider;
  @override
  void initState() {
    super.initState();

    cartProvider = widget.cartProvider;
    ///////listener of text input./////
    // widget.myController.addListener(() {
    //   print("value: ${widget.myController.text}");
    //   // widget.productQuantity = int.parse(widget.myController.text)
    //   // setState(() {});
    //   widget.productQuantity = int.parse(widget.myController.text);
    //
    //   widget.cartProvider.updateQuantity(
    //     index: widget.index,
    //
    //   );
    // });
    //  quantityController.text = 1.toString();
  }

  @override
  void dispose() {
    //  quantityController.dispose();
    widget.myController.dispose();
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
                          child: Image.network(widget.imgUrl,
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
                              widget.productName,
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
                                widget.productPriceAfterDiscount ==
                                        widget.productPrice
                                    ? widget.productPrice.toString() +
                                        ' le'.tr()
                                    : widget.productPriceAfterDiscount == null
                                        ? widget.productPrice.toString() +
                                            ' le'.tr()
                                        : widget.productPriceAfterDiscount == 0
                                            ? widget.productPrice
                                            : widget.productPriceAfterDiscount
                                                    .toString() +
                                                ' le'.tr(),
                                // style: const TextStyle(
                                //     fontWeight: FontWeight.bold),
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
                                widget.productCategory,

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
                                onPressed: widget.onDelete)
                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        child: Row(
                          children: [
                            Text(
                              widget.sizeSpecValue == ""
                                  ? ''
                                  : 'Size : ${widget.sizeSpecValue}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                            ),
                            Text(widget.colorSpecValue == "" ? '' : ' , ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4)),
                            Text(widget.colorSpecValue == "" ? '' : 'Color : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4)),
                            widget.colorSpecValue == ""
                                ? Container()
                                : CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(int.parse(
                                        '0xff${widget.colorSpecValue}')),
                                    foregroundColor: Color(int.parse(
                                        '0xff${widget.colorSpecValue}'))),
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
                                  hintText: widget.myController.text ??
                                      widget.productQuantity.toString(),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal *
                                          .07)),
                              controller: widget.myController,
                              onChanged: (value) {
                                // widget.myController.addListener((){
                                //   print("value: ${widget.myController.text}");
                                //   widget.productQuantity = int.parse(value);
                                //   print(widget.productQuantity);
                                //   setState(() {});
                                // });
                                // widget.onUpdateQuantity(widget.index,widget.productQuantity);
                                // setState(() {
                                widget.myController.text = value;
                                widget.productQuantity =
                                    int.parse(widget.myController.text);
                                cartProvider.updateQuantity(
                                    index: widget.index,
                                    productId: widget.id,
                                    quantity: widget.productQuantity);
                                // });

                                // widget.onUpdateQuantity();
                              },
                            ),
                          ),
                          widget.totalAvailability - 1 >= widget.productQuantity
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
                                  widget.totalPrice.toStringAsFixed(2) +
                                      ' le'.tr(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      color: Color(0xff3A559F)),

                                  // style:
                                  //     const TextStyle(color: Color(0xff3A559F)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      widget.totalAvailability <= widget.productQuantity
                          ? Center(
                              child: Text(
                                  "${widget.totalAvailability}" +
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
