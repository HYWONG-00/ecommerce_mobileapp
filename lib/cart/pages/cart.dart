import '../../import.dart';

class CartPage extends StatelessWidget {
  final CartCtrl _cartCtrl = Get.find<CartCtrl>();
  CartPage({Key? key}) : super(key: key);
  
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
          ErrorReloadPageWidget(action: _cartCtrl.loadFirebaseData)
          : Padding(
            padding :EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  ProductWidget(products: _cartCtrl.products),
                  SizedBox(height: 16),            
                ],
              ),
            ),
          ),
          )),
    );
  }
}

class CartItemWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Row()
    );
  }
}