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
    widget.myController.addListener((){
      print("value: ${widget.myController.text}");
      widget.productQuantity = int.parse(widget.myController.text);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * .24,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(widget.imgUrl)
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            widget.productName,
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.3,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.productPrice.toString() + ' LE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.1,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: widget.onMinusQuantity,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    .07,
                                height:
                                    MediaQuery.of(context).size.height *
                                        .07,
                                padding:
                                    EdgeInsets.only(right: 5, bottom: 17),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.minimize_outlined,
                                    size: 25,
                                    color: Color(0xff707070),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              width:
                                  MediaQuery.of(context).size.width * .09,
                              child: TextField(
                                controller: widget.myController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.productQuantity.toString(),
                                  hintStyle: const TextStyle(color: Colors.black)
                                ),
                                onChanged: (value) {
                                  widget.myController.addListener((){
                                    print("value: ${widget.myController.text}");
                                    widget.productQuantity = int.parse(value);
                                    print(widget.productQuantity);
                                    setState(() {});
                                  });
                                  setState(() {
                                    widget.productQuantity = int.parse(widget.myController.text);
                                    widget.myController.text = value;
                                  });
                                // widget.onUpdateQuantity();
                                },
                                onSubmitted: (value) {
                                  widget.myController.addListener((){
                                    print("value: ${widget.myController.text}");
                                    widget.productQuantity = int.parse(value);
                                    setState(() {});
                                  });
                                  widget.productQuantity = int.parse(value);
                                  widget.myController.text = value;
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
                                    size: 25,
                                    color: Color(0xff707070),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15,left: 35),
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
                                    TextStyle(color: Color(0xff3A559F)),
                              )
                            ],
                          ),
                        )
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
