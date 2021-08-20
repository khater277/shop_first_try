class CategoriesModel {
  bool? status;
  Null message;
  Data? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<CategoryData>? categoryDetails=[];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        categoryDetails!.add(new CategoryData.fromJson(v));
      });
    }
  }
}

class CategoryData {
  int? id;
  String? name;
  String? image;


  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
