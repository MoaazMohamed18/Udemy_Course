class HomeModel {
  late bool status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }

}

// class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProductModel> products = [];
//
//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//
//     json['banners'].forEach((element) {
//       banners.add(element);
//     });
//     json['products'].forEach((element) {
//       products.add(element);
//     });
//   }
//
// }
class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = List<BannerModel>.from(
        json['banners'].map((element) => BannerModel.fromJson(element)),
      );
    }

    if (json['products'] != null) {
      products = List<ProductModel>.from(
        json['products'].map((element) => ProductModel.fromJson(element)),
      );
    }
  }
}


class BannerModel {
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}