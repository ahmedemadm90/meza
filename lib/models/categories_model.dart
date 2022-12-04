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
  String? category_name;
  String? brand_name;
  int? brandId;
  String? mainMeasure;
  int? mainQuantity;
  String? subMeasure;
  int? subQuantity;
  var priceDiscount;
  var discount;
  var isPrecent;
  String? image;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brand_name = json['brand_name'];
    category_name = json['category_name'];
    price = json['price'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    mainMeasure = json['main_measure'];
    mainQuantity = json['main_quantity'];
    subMeasure = json['sub_measure'];
    subQuantity = json['sub_quantity'];
    priceDiscount = json['priceDiscount'];
    discount = json['discount'];
    isPrecent = json['is_precent'];
    image = json['image'];
  }
}
