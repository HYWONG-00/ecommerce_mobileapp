import '../../import.dart';
import '../home.dart';

import 'dart:convert';

class HomeCtrl extends GetxController{
  List<BannerModel> banners = <BannerModel>[].obs;
  List<ProductModel> products = <ProductModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadLocalData();
    
    loadFirebaseData();
  }

  void loadLocalData() async {
    dynamic returned = json.decode(await rootBundle.loadString('assets/data/api_banner.json'));
    
    appDebugLog(returned);
  }

  void loadFirebaseData() async {
    isLoading.value = true;

    try{
      final List<Map<String, dynamic>> bannerList = await _loadDataCollection("banners");
      banners = BannerModel.bannerList(bannerList);

      final List<Map<String, dynamic>> productsList = await _loadDataCollection("products");
      products = ProductModel.productList(productsList);

      appDebugLog("banners ${banners}");
      appDebugLog("products ${products}");

      await Future.delayed(Duration(seconds: 2));

      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }   
  }

  Future<List<Map<String, dynamic>>> _loadDataCollection(String collectionName) async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    final List<Map<String, dynamic>> dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return dataList;
  }

}

