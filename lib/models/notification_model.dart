class NotificationModel {
  List<Data>? data;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  OrderId? order;
  int? type;
  String? createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order_id'] != null
        ? new OrderId.fromJson(json['order_id'])
        : null;
    type = json['type'];
    createdAt = json['created_at'];
  }
}

class OrderId {
  int? id;
  int? vendorId;
  int? totalCost;
  int? totalDiscount;
  int? status;
  String? date;
  String? createdAt;
  String? updatedAt;

  OrderId(
      {this.id,
        this.vendorId,
        this.totalCost,
        this.totalDiscount,
        this.status,
        this.date,
        this.createdAt,
        this.updatedAt});

  OrderId.fromJson(Map<String, dynamic> json) {
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
