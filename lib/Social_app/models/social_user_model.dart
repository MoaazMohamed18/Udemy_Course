class SocialUserModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? uId;
  late String? image;
  late String? cover;
  late String? bio;
  late bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified
});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }
}