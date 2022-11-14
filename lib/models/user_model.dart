class UserModel{
  bool? success;
  String? message;
  UserData? data;
  UserModel.fromJson(Map json){
    success = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJSON(json['data']): null;
  }
}
class UserData{
  int? id;
  String? shop_name;
  String? phone;
  String? country;
  String? city;
  String? region;
  String? address;
  String? image;
  String? token;
  UserData.fromJSON(Map json){
    id = json['id'];
    shop_name = json['shop_name'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    region = json['region'];
    address = json['address'];
    image = json['image'];
    token = json['token'];
  }
}