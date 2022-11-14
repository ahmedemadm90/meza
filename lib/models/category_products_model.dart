class CategoryProductsModel {
  Data? data;

  CategoryProductsModel({this.data});

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  List<Products>? products;

  Data({this.id, this.name, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? categoryId;
  int? brandId;
  int? priceDiscount;
  int? discount;
  int? isPrecent;
  String? image;

  Products(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.categoryId,
        this.brandId,
        this.priceDiscount,
        this.discount,
        this.isPrecent,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    priceDiscount = json['priceDiscount'];
    discount = json['discount'];
    isPrecent = json['is_precent'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['priceDiscount'] = this.priceDiscount;
    data['discount'] = this.discount;
    data['is_precent'] = this.isPrecent;
    data['image'] = this.image;
    return data;
  }
}
