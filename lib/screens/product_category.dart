import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  List<Map<String, dynamic>> filteredProducts;
  String category;
  CategoryScreen(
      {super.key, required this.filteredProducts, required this.category});

  List productImages = [
    "https://i.pinimg.com/474x/82/42/aa/8242aae1c7ce75cd6175d7282894096c.jpg",
    "https://5.imimg.com/data5/SELLER/Default/2023/9/344928632/OW/RQ/XC/25352890/yellow-mango.jpeg",
    "https://st.depositphotos.com/2204074/3871/i/450/depositphotos_38713749-stock-photo-orange.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          "All ${category} products",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                children: [
                  Image.network(
                      filteredProducts[index]["p_name"] == "Apple"
                          ? productImages[0]
                          : filteredProducts[index]["p_name"] == "Orange"
                              ? productImages[2]
                              : productImages[1],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredProducts[index]["p_name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Price: \$${filteredProducts[index]["p_cost"]}",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        "Details: ${filteredProducts[index]["p_details"] ?? ""}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
