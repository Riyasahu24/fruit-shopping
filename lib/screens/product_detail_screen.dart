import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fruit_shop/lib/constant/toast.dart';
import 'package:fruit_shop/lib/services/product_service.dart';

class ProductDetailScreen extends StatefulWidget {
  String image;
  int index;
  bool isLike;
  ProductDetailScreen(
      {super.key,
      required this.index,
      required this.image,
      required this.isLike});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Map<String, dynamic>> products = ProductService().getProducts();
  int quantity = 1;
  List<Map<String, dynamic>> cartItems = [];

  List ProductImage = ["apple.png", "mango.png", "banana.png", "orange.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Row(
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * .45,
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child:
                  Image.asset("assets/images/${ProductImage[widget.index]}")),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        products[widget.index]["p_name"],
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      products[widget.index]["p_category"] == null
                          ? SizedBox()
                          : Text(
                              products[widget.index]["p_category"],
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("1 each"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .06,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue[50]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: Icon(Icons.add)),
                            Text(
                              "$quantity",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: quantity > 1
                                    ? () {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    : null,
                                icon: Icon(Icons.remove))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Rs",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            products[widget.index]["p_cost"].toString(),
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  products[widget.index]["p_details"] == null
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Description",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              products[widget.index]["p_details"],
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green)),
                        child: widget.isLike
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.green,
                                size: 40,
                              ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      products[widget.index]["p_availability"] == 0
                          ? Container(
                              height: MediaQuery.of(context).size.height * .08,
                              width: MediaQuery.of(context).size.height * .3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Center(
                                  child: Text(
                                "Out of Stock",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              )))
                          : GestureDetector(
                              onTap: () {
                                Map<String, dynamic> selectedProduct = {
                                  "p_name": products[widget.index]["p_name"],
                                  "p_id": products[widget.index]["p_id"],
                                  "quantity": quantity,
                                  "total_cost": products[widget.index]
                                          ["p_cost"] *
                                      quantity,
                                };
                                cartItems.add(selectedProduct);
                                print(Colors.green);
                                submitQunatity();
                                log("$cartItems");
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  width:
                                      MediaQuery.of(context).size.height * .3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          const Color.fromRGBO(76, 175, 80, 1)),
                                  child: Center(
                                      child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ))),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  submitQunatity() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Product details")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Product Name "),
                    Text(cartItems[widget.index]["p_name"])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantity "),
                    Text(cartItems[widget.index]["quantity"].toString())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Cost "),
                    Text(cartItems[widget.index]["total_cost"].toString())
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    cartItems.removeLast();
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    Constants.snackBarWidget(
                        "Quantity added successfully", Colors.indigo);
                    Navigator.pop(context);
                  },
                  child: Text("Submit"))
            ],
          );
        });
  }
}
