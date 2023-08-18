import '../../import.dart';

class ProductCtrl extends GetxController {
  ProductModel product = ProductModel();
  RxString location = "".obs;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  

  @override
  void onInit() {
    super.onInit();

    loadLocalData();
  }

  void loadLocalData() async {
    isLoading.value = true;

    ResponseModel responseModel = await readLocalFile("products/api_product");

    if(responseModel.error.message.isNotEmpty){
      isError.value = true;
    }
    else{
      //isError.value = true;
      product = ProductModel.fromJson(responseModel.data);
      appSuccessLog(product);
    }
    
    await Future.delayed(Duration(seconds: 2));

    isLoading.value = false;
  }

  void changeSelection({required int optionid, String? selected_option, List<String>? selected_options}) {
    appDebugLog("optionid ${optionid}, selected_option ${selected_option}, selected_options ${selected_options}");
  }
}