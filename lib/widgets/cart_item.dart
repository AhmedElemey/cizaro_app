import 'package:cizaro_app/size_config.dart';
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
  int productQuantity, totalAvailability, index;
  final double totalPrice, productPrice, productPriceAfterDiscount;
  var myController = TextEditingController();
  final VoidCallback onDelete;
  final VoidCallback onPlusQuantity;
  final VoidCallback onMinusQuantity;
  final Function onUpdateQuantity;

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
      this.onDelete,
      this.onMinusQuantity,
      this.colorSpecValue,
      this.sizeSpecValue,
      this.onUpdateQuantity,
      this.onPlusQuantity})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    widget.myController.addListener(() {
      print("value: ${widget.myController.text}");
      // widget.productQuantity = int.parse(widget.myController.text);
      widget.onUpdateQuantity();
      setState(() {});
    });
    widget.productQuantity = int.parse(widget.myController.text);
    //  quantityController.text = 1.toString();
    super.initState();
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
          top: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5),
      child: Card(
        elevation: 5,
        child: Container(
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          Text(widget.productName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                                  color: Color(0xff515C6F)),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.2),
                          Spacer(),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 3,
                                  left: SizeConfig.blockSizeHorizontal * 1),
                              child: Text(
                                  widget.productPriceAfterDiscount ==
                                          widget.productPrice
                                      ? widget.productPrice.toString() + ' LE'
                                      : widget.productPriceAfterDiscount == null
                                          ? widget.productPrice.toString() +
                                              ' LE'
                                          : widget.productPriceAfterDiscount
                                                  .toString() +
                                              ' LE',
                                  // style: const TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      color: Color(0xff515C6F)),
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1))
                        ],
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 3,
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3),
                        child: Row(
                          children: [
                            Text(
                              widget.productCategory,
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                              // style: const TextStyle(color: Colors.blueGrey)
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                                  color: Color(0xff515C6F)),
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
                        height: SizeConfig.blockSizeVertical * 3.5,
                        child: Row(
                          children: [
                            Text(
                              widget.sizeSpecValue == ""
                                  ? ''
                                  : 'Size : ${widget.sizeSpecValue}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(widget.colorSpecValue == "" ? '' : ' , ',
                                style: const TextStyle(color: Colors.black)),
                            Text(widget.colorSpecValue == "" ? '' : 'Color : ',
                                style: const TextStyle(color: Colors.black)),
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
                            onTap: widget.onMinusQuantity,
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 7.5,
                              height: SizeConfig.blockSizeVertical * 7.5,
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * .5,
                                  bottom: SizeConfig.blockSizeVertical * 3),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Icon(Icons.minimize_outlined,
                                    size: SizeConfig.safeBlockHorizontal * 7,
                                    color: Color(0xff707070)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
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
                                  hintStyle:
                                      const TextStyle(color: Colors.black)),
                              controller: widget.myController,
                              onChanged: (value) {
                                // widget.myController.addListener((){
                                //   print("value: ${widget.myController.text}");
                                //   widget.productQuantity = int.parse(value);
                                //   print(widget.productQuantity);
                                //   setState(() {});
                                // });
                                // widget.onUpdateQuantity(widget.index,widget.productQuantity);
                                setState(() {
                                  widget.myController.text = value;
                                  widget.productQuantity =
                                      int.parse(widget.myController.text);
                                  widget.onUpdateQuantity(
                                      widget.index, widget.productQuantity);
                                });

                                // widget.onUpdateQuantity();
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onPlusQuantity,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.add,
                                size: SizeConfig.safeBlockHorizontal * 6,
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
                                Text("TOTAL",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                3.5),
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            1.1),
                                Text(
                                  widget.totalPrice.toStringAsFixed(2) + ' LE',
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1,
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
                      widget.totalAvailability < widget.productQuantity
                          ? Center(
                              child: Text(
                                  '${widget.totalAvailability}  items Available in Stock' ??
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
