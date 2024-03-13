import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_shop/lib/screens/product_category.dart';
import 'package:fruit_shop/lib/screens/product_detail_screen.dart';
import 'package:fruit_shop/lib/services/product_service.dart';
// import 'package:carousel_slider/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List carouselImages = [
    "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4",
    "https://www.fruitsmith.com/pub/media/mageplaza/blog/post/o/n/one_seed_fruits.png",
    "https://media.post.rvohealth.io/wp-content/uploads/2020/09/fruit-still-life-732x549-thumbnail.jpg"
  ];

  List productImages = [
    "https://i.pinimg.com/474x/82/42/aa/8242aae1c7ce75cd6175d7282894096c.jpg",
    "https://5.imimg.com/data5/SELLER/Default/2023/9/344928632/OW/RQ/XC/25352890/yellow-mango.jpeg",
    "https://www.shutterstock.com/image-photo/bunch-bananas-isolated-on-white-600nw-99478112.jpg",
    "https://st.depositphotos.com/2204074/3871/i/450/depositphotos_38713749-stock-photo-orange.jpg"
  ];

  List categories = ["All", "Premium", "Tamilnadu"];

  List<Map<String, dynamic>> products = ProductService().getProducts();
  List<Map<String, dynamic>> filteredProducts = ProductService().getProducts();

  late List<bool> isLikedList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLikedList = List.generate(products.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Explore Your favorite Fruit!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search your favorite fruit",
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * .1,
                        child: IconButton(
                            onPressed: () {
                              myMenu();
                            },
                            icon: Icon(Icons.filter_list)))
                  ],
                ),
              ),

      
             
              // CarouselSlider.builder(
              //   options: CarouselOptions(
              //     height: 200,
              //     aspectRatio: 16 / 9,
              //     viewportFraction: 0.7,
              //     enableInfiniteScroll: true,
              //     reverse: false,
              //     autoPlay: true,
              //     autoPlayInterval: const Duration(seconds: 3),
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enlargeCenterPage: true,
              //     enlargeFactor: 0.3,
              //     scrollDirection: Axis.horizontal,
              //   ),
              //   itemCount: carouselImages.length,
              //   itemBuilder:
              //       (BuildContext context, int itemIndex, int pageViewIndex) =>
              //           ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: Image.network(
              //       carouselImages[itemIndex],
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "All Product",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: MediaQuery.of(context).size.height * .6,
                child: GridView.builder(
                  itemCount: productImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ProductDetailScreen(
                                      index: index,
                                      image: productImages[index],
                                      isLike: isLikedList[index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Image.network(
                                    productImages[index],
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    right: 5,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isLikedList[index] =
                                                !isLikedList[index];
                                          });
                                        },
                                        icon: isLikedList[index]
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: Colors.green,
                                              )))
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade200,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    products[index]['p_name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_box,
                                        size: 30,
                                        color: Colors.green,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  myMenu() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Select Category")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, categories[1]);
                    },
                    child: Text(categories[1])),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, categories[2]);
                    },
                    child: Text(categories[2]))
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text("Back"))
            ],
          );
        });

    if (result != null) {
      // Filter the products based on the selected category
      setState(() {
        filteredProducts = products
            .where((product) => product['p_category'] == result)
            .toList();
      });
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => CategoryScreen(
            category: result,
            filteredProducts: filteredProducts,
          ),
        ),
      );
    }
  }
}
