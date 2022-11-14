class CategoriesModel {
  List<Category>? categories;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

}

class Category {
  int? id;
  String? name;
  List<Products> products=[];
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  var price;
  int? categoryId;
  int? brandId;
  int? priceDiscount;
  int? discount;
  int? isPrecent;
  String? image;

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
}
