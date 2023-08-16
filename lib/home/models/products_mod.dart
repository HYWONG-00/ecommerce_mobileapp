import '../../import.dart';

class ProductModel {
  String image, title;
  double price, rating;

  ProductModel({
    this.image = "",
    this.title = "",
    this.price = 0.0,
    this.rating = 0.0,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : title = Data.toStr(json['title']),
        image =  Data.toStr(json['image']),
        price = Data.toDouble(json['price']),
        rating = Data.toDouble(json['rating']);

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