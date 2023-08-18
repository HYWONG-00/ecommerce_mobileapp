import '../../import.dart';

class CartPage extends StatelessWidget {
  final CartCtrl _cartCtrl = Get.find<CartCtrl>();
  CartPage({Key? key}) : super(key: key);
  
  Widget CardWidget({required String title, required Widget content}){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: WTextWidget(title, fontWeight: 7, fontSize: 15),
          ),
          Divider(thickness: 0.8),
          content,
          SizedBox(height: 8),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: Text("Cart")),         
          body: Obx(() =>
          _cartCtrl.isLoading.value ? 
          Center(child: CircularProgressIndicator())
          : _cartCtrl.isError.value ? 
          ErrorReloadWidget(action: _cartCtrl.loadLocalData)
          : Padding(
            padding: EdgeInsets.only(top: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardWidget(title: "Order Summary", content: Column(                  
                    children: List.generate(_cartCtrl.products.products.length, (index) => CartItemWidget(product: _cartCtrl.products.products[index])),
                  )),
                  SizedBox(height: 10),
                  CardWidget(title: "Eco-friendly options", content: Column(                  
                    children: [
                      
                    ],
                  )),
                  
                ],
              ),
            ),
          ),
          )),
    );
  }
}

class CartItemWidget extends StatelessWidget{
  final ProductModel product;

  CartItemWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFE4F3EA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(255, 80, 215, 134), width: 2.0),
              ),
              child: AspectRatio(
                aspectRatio: 1, // Set the aspect ratio to 1:1
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover, // Choose the desired BoxFit to fit the image within the container
                ),
              )
          ),
        ),     
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WTextWidget(product.title, fontWeight: 7),
                        WTextWidget(product.description),
                        SizedBox(height: 8),
                        WInkWellWidget(
                          (){
                            Get.to(() => ProductPage(id: product.id), binding: BindingsBuilder(() {
                              Get.put<ProductCtrl>(ProductCtrl());
                            }));


                          }, 
                          content: WTextWidget("Edit", fontWeight: 7, color: primary1)
                        )
                      ],
                    ),
                  ),
                  WInkWellWidget(
                    (){}, 
                    content: WTextWidget(product.price.toStringAsFixed(2), fontWeight: 7)
                  )
                ],
              ),
              SizedBox(height: 16),
              Divider(height: 0, thickness: 1),
              
            ],
          ),
        )
      ],
    );
  }
}