import '../../import.dart';

class CartCtrl extends GetxController{
  ProductsModel products = ProductsModel();
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

    ResponseModel responseModel = await readLocalFile("carts/api_carts");

    if(responseModel.error.message.isNotEmpty){
      isError.value = true;
    }
    else{
      products = ProductsModel.fromJson(responseModel.data);

      appSuccessLog(products.toString());
    }
    
    await Future.delayed(Duration(seconds: 5));

    isLoading.value = false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Not enabled = request users permission for location services
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}