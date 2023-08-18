import '../../import.dart';

class SetLocationPage extends StatelessWidget {
  final CartCtrl _cartCtrl = Get.find<CartCtrl>();
  
  SetLocationPage({Key? key}) : super(key: key);
  
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
          appBar: AppBar(title: Text("Set Location")),         
          body: Obx(() =>
          _cartCtrl.isLoading.value ? 
          Center(child: CircularProgressIndicator())
          : _cartCtrl.isError.value ? 
          ErrorReloadWidget(action: _cartCtrl.loadLocalData)
          : Padding(
            padding :EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child: Container()
            
          ),
          )),
    );
  }
}