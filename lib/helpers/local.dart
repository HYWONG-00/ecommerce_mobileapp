import '../import.dart';


Future<ResponseModel> readLocalFile(String filePath) async {
  ResponseModel responseModel = ResponseModel();
  try {
    String fileContent = await rootBundle.loadString("assets/data/${filePath}.json");

    // json.decode => return dynamic
    // Data.toMap => convert dynamic to Map<String, dynamic>
    responseModel = ResponseModel.fromJson(Data.toMap(json.decode(fileContent)));
    
    return responseModel;
  } catch (e) {
    appErrorLog("Error reading local file: $e");
    return responseModel;
  }
}


class ResponseModel {
  final Map<String, dynamic> data;
  final ResponseErrorModel error;

  ResponseModel({this.data = const {}, ResponseErrorModel? error})
    //when error is null, default = ResponseErrorModel()
    : error = error ?? ResponseErrorModel();

  ResponseModel.fromJson(Map<String, dynamic> json)
      : data = Data.toMap(json['data']),
        error = ResponseErrorModel.fromJson(Data.toMap(json['error']));
  
  @override
  String toString() {
    return "{ 'data': ${data} , 'error': ${error}}";
  }
}


//Google cloud JSON format
class ResponseErrorModel {
  final List<Map<String, dynamic>> errors;
  final int code;
  final String message;

  ResponseErrorModel(
      {this.code = 0, this.message = '', this.errors = const[]});

  ResponseErrorModel.fromJson(Map<String, dynamic> json)
      : code = Data.toInt(json['code']),
        message = Data.toStr(json['message']),
        errors = Data.toMapList(json['errors']);

  @override
  String toString() {
    return "{ 'code': ${code} , 'message': ${message}} , 'errors': ${errors}}";
  }
}
