import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartItem extends StatefulWidget {
   final String productName,
      imgUrl,
      productCategory;
   int productQuantity,totalAvailability;
  final double totalPrice, productPrice;
   var myController = TextEditingController();
  final VoidCallback onDelete;
  final VoidCallback onPlusQuantity;
  final VoidCallback onMinusQuantity;
   final VoidCallback onUpdateQuantity;

  CartItem(
      {Key key,
      this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.totalAvailability,
        this.myController,
      this.totalPrice,
      this.productQuantity,
      this.onDelete,
      this.onMinusQuantity,
        this.onUpdateQuantity,
      this.onPlusQuantity}): super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    // widget.myController.addListener((){
    //   print("value: ${widget.myController.text}");
    //   widget.productQuantity = int.parse(widget.myController.text);
    //   setState(() {});
    // });
    widget.productQuantity = int.parse(widget.myController.text);
    quantityController.text = 1.toString();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5,bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(widget.imgUrl,fit: BoxFit.fitHeight))
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.productName,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.3
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8,left: 8),
                          child: Text(
                            widget.productPrice.toString() + ' LE',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        widget.productCategory,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.1,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Size : 34 , Color : Red'),
                        IconButton(icon: Icon(Icons.delete,size: MediaQuery.of(context).size.width * 0.08,color: Colors.red), onPressed: widget.onDelete)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: widget.onMinusQuantity,
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                .075,
                            height:
                                MediaQuery.of(context).size.height *
                                    .075,
                            padding:
                                EdgeInsets.only(right: 5, bottom: 17),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.minimize_outlined,
                                size: MediaQuery.of(context).size.width * 0.07,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          width:
                              MediaQuery.of(context).size.width * .09,
                          child: TextFormField(
                            controller: widget.myController,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 7),
                              border: InputBorder.none,
                              hintText: widget.productQuantity.toString(),
                              hintStyle: const TextStyle(color: Colors.black)
                            ),
                            onChanged: (value) {
                              // widget.myController.addListener((){
                              //   print("value: ${widget.myController.text}");
                              //   widget.productQuantity = int.parse(value);
                              //   print(widget.productQuantity);
                              //   setState(() {});
                              // });
                              setState(() {
                                widget.myController.text = value;
                                widget.productQuantity = int.parse(widget.myController.text);
                              });
                            // widget.onUpdateQuantity();
                            },
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(right: 5, left: 10),
                          child: GestureDetector(
                            onTap: widget.onPlusQuantity,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.add,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8,left: 8),
                          child: Column(
                            children: [
                              Text(
                                  "TOTAL",
                                  textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor *
                                      .8
                              ),
                              Text(
                                widget.totalPrice.toString() + ' LE',
                                textScaleFactor: MediaQuery.of(context)
                                    .textScaleFactor *
                                    1,
                                style:
                                const TextStyle(color: Color(0xff3A559F)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    widget.totalAvailability < widget.productQuantity ? Center(child: Text('${widget.totalAvailability}  items Available in Stock' ?? '',style: const TextStyle(color: Colors.red,fontSize: 10))) : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
