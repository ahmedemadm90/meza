class UserModel {
  bool? success;
  String? message;
  UserData? data;
  UserModel.fromJson(Map json) {
    success = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJSON(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? shop_name;
  String? phone;
  String? country;
  String? city;
  String? region;
  String? address;
  String? image;
  List<Order>? order;
  String? token;
  UserData.fromJSON(Map json) {
    id = json['id'];
    shop_name = json['shop_name'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    region = json['region'];
    address = json['address'];
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
    image = json['image'];
    token = json['token'];
  }
}
class Order {
  int? id;
  int? vendorId;
  int? totalCost;
  int? totalDiscount;
  int? status;
  String? date;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
      this.vendorId,
      this.totalCost,
      this.totalDiscount,
      this.status,
      this.date,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    totalCost = json['total_cost'];
    totalDiscount = json['total_discount'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['total_cost'] = this.totalCost;
    data['total_discount'] = this.totalDiscount;
    data['status'] = this.status;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
