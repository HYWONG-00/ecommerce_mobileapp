import '../../import.dart';
import '../home.dart';

class HomeCtrl extends GetxController{
  List<BannerModel> banners = <BannerModel>[].obs;
  List<ProductModel> products = <ProductModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //loadLocalData();
    
    loadFirebaseData();
  }

  void loadLocalData() async {
    dynamic returned = json.decode(await rootBundle.loadString('assets/data/api_banner.json'));
    
    appDebugLog(returned);
  }

  void loadFirebaseData({String? filter}) async {
    isLoading.value = true;

    try{
      final List<Map<String, dynamic>> bannerList = await loadFirebaseDataCollection("banners");
      banners = BannerModel.bannerList(bannerList);

      final List<Map<String, dynamic>> productsList = await loadFirebaseDataCollection("products");
      products = ProductModel.productList(productsList);

      appDebugLog("banners ${banners}");
      appDebugLog("products ${products}");

      await Future.delayed(Duration(seconds: 2));

      isLoading.value = false;

    } catch (e) {
      appErrorLog("Error occurs: $e");
      isLoading.value = false;
      isError.value = true;
    }   
  }



}

