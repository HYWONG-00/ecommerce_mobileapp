import '../../import.dart';

class BannerModel {
  String link, title;

  BannerModel({
    this.link = "",
    this.title = "",
  });

  BannerModel.fromJson(Map<String, dynamic> json)
      : link = Data.toStr(json['link']),
        title = Data.toStr(json['title']);

  @override
  String toString() {
    // TODO: implement toString
    return "{'link' : ${link}, 'title' : ${title}}";
  }

  static List<BannerModel> bannerList(List data) {
    final List<BannerModel> list = <BannerModel>[];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(BannerModel.fromJson(v));
        }
      }
    }
    return list;
  }
} 