class CartModel {
  List<ShoppingCart>? shoppingCart;
  var totalDiscount;
  var totalcost;

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['shoppingCart'] != null) {
      shoppingCart = <ShoppingCart>[];
      json['shoppingCart'].forEach((v) {
        shoppingCart!.add(new ShoppingCart.fromJson(v));
      });
    }
    totalDiscount = json['totalDiscount'];
    totalcost = json['totalcost'];
  }

}

class ShoppingCart {
  int? id;
  int? cartQuantity;
  var cartPrice;
  Product? product;

  ShoppingCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartQuantity = json['cart_quantity'];
    cartPrice = json['cart_price'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  var price;
  int? categoryId;
  int? brandId;
  int? priceDiscount;
  var discount;
  int? isPrecent;
  String? image;

  Product.fromJson(Map<String, dynamic> json) {
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
