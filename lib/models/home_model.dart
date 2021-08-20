class HomeModel {
  bool? status;
  Null message;
  Data? data;


  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners>? banners=[];
  List<Products>? products=[];


  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {

      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {

      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }
}

class Banners {
  int? id;
  String? image;


  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
