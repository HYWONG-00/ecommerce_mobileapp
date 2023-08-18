import '../../import.dart';

class ProductsModel {
  List<ProductModel> products;

  ProductsModel({
    this.products = const <ProductModel>[]
  });

  ProductsModel.fromJson(Map<String, dynamic> json)
      : products = ProductModel.productList(Data.toMapList(json['products']));
}

class ProductModel {
  int id;
  String image, title, description;
  double price, rating;
  List<ChoiceModel> choices;

  ProductModel({
    this.id = 0,
    this.image = "",
    this.title = "",
    this.description = "",
    this.price = 0.0,
    this.rating = 0.0,
    this.choices = const[]
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = Data.toInt(json['id']),
        title = Data.toStr(json['title']),
        image =  Data.toStr(json['image']),
        description =  Data.toStr(json['description']),
        price = Data.toDouble(json['price']),
        rating = Data.toDouble(json['rating']),
        choices = ChoiceModel.choiceModel(Data.toMapList(json['choices']));

  @override
  String toString() {
    // TODO: implement toString
    return "{'title' : ${title}, 'image' : ${image}, 'price' : ${price}, 'rating' : ${rating}}";
  }

  static List<ProductModel> productList(List data) {
    final List<ProductModel> list = <ProductModel>[];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(ProductModel.fromJson(v));
        }
      }
    }
    return list;
  }
} 

class ChoiceModel {
  //type = 1 = radio button (ignore max_select)
  //type = 2 = checkbox (read max_select)
  int id, type, max_select;
  String title;
  List<OptionModel> options;

  ChoiceModel({
    this.id = 0,
    this.type = 0,
    this.max_select = 0,
    this.title = "",  
    this.options = const [],
  });

  ChoiceModel.fromJson(Map<String, dynamic> json)
      : id =  Data.toInt(json['id']), 
        type =  Data.toInt(json['type']), 
        max_select =  Data.toInt(json['max_select']), 
        title = Data.toStr(json['title']),
        options = OptionModel.optionModel(json['options']);

  static List<ChoiceModel> choiceModel(List data) {
    final List<ChoiceModel> list = <ChoiceModel>[];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(ChoiceModel.fromJson(v));
        }
      }
    }
    return list;
  }

}


class OptionModel {
  //type = 1 = radio button (ignore max_select)
  //type = 2 = checkbox (read max_select)
  int id;
  String title;
  double price;

  OptionModel({
    this.id = 0,
    this.title = "",  
    this.price = 0.0,
  });

  OptionModel.fromJson(Map<String, dynamic> json)
      : id =  Data.toInt(json['id']), 
        title = Data.toStr(json['title']),
        price = Data.toDouble(json['price']);

  static List<OptionModel> optionModel(List data) {
    final List<OptionModel> list = <OptionModel>[];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(OptionModel.fromJson(v));
        }
      }
    }
    return list;
  }
}