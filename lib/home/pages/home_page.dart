import '../../import.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await AuthCtrl().signOut();
  }

  Widget heading (String title, Function linkaction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WTextWidget(title,
            fontSize: 15, fontWeight: 7),
        GestureDetector(
          onTap: () {
            linkaction();
          },
          child: WTextWidget("See All",
              fontSize: 11, fontWeight: 7, color: primary1),
        ),
      ],
    );
  }

  Widget categoryWidget(String title) {
    return Column(
      children: [
        Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              color: Color(0xFFE4F3EA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.food_bank)
            )
          ),
        SizedBox(height: 8),
        WTextWidget(title, fontSize: 13)
      ],
    );
  }



  Widget ProductWidget({required List<ProductModel> products}){
    return Container(
      height: 220,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 16),
              child: Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        products[index].image,
                        width: deviceWidth * 0.4,
                        height: 120,
                        fit: BoxFit.cover, // This ensures the image covers the entire area
                      ),
                    ),
                    SizedBox(height: 8),
                    WTextWidget(products[index].title, fontSize: 14, fontWeight: 7),
                    SizedBox(height: 8),
                    Expanded(child: WTextWidget("RM ${products[index].price.toStringAsFixed(2)}", fontSize:12, fontWeight: 7, color: Colors.redAccent)),
                    WTextWidget("${products[index].rating.toStringAsFixed(0)} reviews", fontSize: 10),

                  ],
                )
                    ),
            );}
        ),
    );
  }
  
  
  Widget BannerWidget({required List<BannerModel> banners}){
    return CarouselSlider(
        options: CarouselOptions(
          height: 180.0,
          enableInfiniteScroll: false,
          viewportFraction: 0.9,
          enlargeCenterPage: false,//large->small
          disableCenter: true,
        ),
        items: banners.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(right: 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                        banner.link,
                        fit: BoxFit.cover, // This ensures the image covers the entire area
                  ),
                )
              );
            },
          );
        }).toList(),
      );
      
      // Do not use 
      // NotificationListener<ScrollNotification>(
      //   onNotification: (notification) {
      //     if (notification is ScrollEndNotification && notification.metrics.axis == Axis.horizontal) {
      //       scrollToNextImage();
      //     }
      //     return false;
      //   },
      //   child: ListView.builder(
      //     controller: _scrollController,
      //     scrollDirection: Axis.horizontal,
      //     itemCount: banners.length,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: EdgeInsets.only(right: 16),
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(10.0),
      //           child: GestureDetector(
      //             onTap: (){
      //               _scrollController.animateTo(
      //                 (index * (deviceWidth * 0.8 + 16)) +
      //                 (deviceWidth * 0.8 + 16 / 2) - (MediaQuery.of(context).size.width / 2),
      //                 duration: Duration(milliseconds: 500),
      //                 curve: Curves.easeInOut,
      //               );
      //             },
      //             child: Image.network(
      //               width: deviceWidth * 0.8,
      //               banners[index].link,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );
  }
  @override
  Widget build(BuildContext context) {
    final HomeCtrl _homeCtrl = Get.find<HomeCtrl>();
    deviceHeight = context.height;
    deviceWidth = context.width;

    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: Text("Home"), actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CartPage());
                },
                icon: Icon(Icons.shopping_cart_outlined)),
            IconButton(onPressed: signOut, icon: Icon(Icons.logout))
          ]),
          
          body: Obx(() =>
          _homeCtrl.isLoading.value ? 
          Center(child: CircularProgressIndicator())
          : _homeCtrl.isError.value ? 
          ErrorReloadWidget(action: _homeCtrl.loadFirebaseData)
          : Container(
            padding: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                  child: WInputTextWidget(
                    TextEditingController(),
                    hintText: "Search Product By",
                    iconAfter: Icons.search,
                  ), 
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        SizedBox(height: 16),
                        BannerWidget(banners: _homeCtrl.banners),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                          child: Column(
                            children: [
                              heading("Categories", () {
                                // Get.to(CartScreen(), binding: BindingsBuilder(() {
                                //   Get.put(CartCtrl());
                                // }));
                              }),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(flex: 1, child: categoryWidget("Foods")),
                                  Expanded(flex: 1, child: categoryWidget("Gift")),
                                  Expanded(flex: 1, child: categoryWidget("Fashion ")),
                                  Expanded(flex: 1, child: categoryWidget("Gadget")),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(onPressed: 
                                    () {}, icon: Icon(Icons.arrow_forward))
                                  )
                                ],
                              ),
                              SizedBox(height: 16),
                              heading("Feature products", () {
                                // Get.to(CartScreen(), binding: BindingsBuilder(() {
                                //   Get.put(CartCtrl());
                                // }));
                              }),
                              SizedBox(height: 8),
                              ProductWidget(products: _homeCtrl.products),
                              SizedBox(height: 16),
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          )),
    );
  }
}


// This is used to directly get live data from the firebase
// BAD: it keeps refresh each time u do an action
//          FutureBuilder<QuerySnapshot>(
//             future: FirebaseFirestore.instance.collection('banners').get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               }
//               final documents = snapshot.data?.docs ?? [];
//               return Container(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: documents.length,
//                   itemBuilder: (context, index) {
//                     final data = documents[index].data() as Map<String, dynamic>;
//                     final text = data['title'];
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8)
//                       ),
//                       child: Image.network(data['link']),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
