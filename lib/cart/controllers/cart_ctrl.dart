import '../../import.dart';

class CartCtrl extends GetxController{
  List<ProductModel> products = <ProductModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadFirebaseData();
  }

  void loadFirebaseData() async {
    isLoading.value = true;

    try{
      final List<Map<String, dynamic>> productsList = await loadFirebaseDataCollection("products");
      products = ProductModel.productList(productsList);

      appDebugLog("products ${products}");

      await Future.delayed(Duration(seconds: 2));

      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }   
  }
}