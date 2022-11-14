class BillModel{
  int? id;
  int? vendor_id;
  var total_cost;
  var total_discount;
  int? status;
  BillModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    vendor_id = json['vendor_id'];
    total_cost = json['total_cost'];
    total_discount = json['total_discount'];
    status = json['status'];
  }
}