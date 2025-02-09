class ShopLoginModel {
  late bool status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  late String name;
  late String email;
  late String phone;
  int? points;
  int? credit;
  late String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.password,
  //   this.phone,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}