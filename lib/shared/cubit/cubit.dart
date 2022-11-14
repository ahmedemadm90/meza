import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meza/models/bill_model.dart';
import 'package:meza/models/cart_model.dart';
import 'package:meza/models/categories_model.dart';
import 'package:meza/models/category_products_model.dart';
import 'package:meza/models/user_model.dart';
import 'package:meza/modules/myaccount_screen.dart';
import 'package:meza/modules/mybills_screen.dart';
import 'package:meza/modules/notifications_screen.dart';
import 'package:meza/modules/products_screen.dart';
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/network/remote/dio_helper.dart';
import 'package:meza/network/remote/endpoints.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/states.dart';

class MezaAppCubit extends Cubit<MezaAppStates> {
  MezaAppCubit() : super(MezaAppInitialState());
  static MezaAppCubit get(context) => BlocProvider.of(context);
  int currentindex = 3;
  bool isShown = true;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  List<Widget> screens = [
    ProfileScreen(),
    BillsScreen(),
    NotificationsScreen(),
    ProductsScrren()
  ];
  void chngeIsPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordToggleState());
  }

  UserModel? userModel;
  void userRegister({
    required String shop_name,
    required String phone,
    required String country,
    required String city,
    required String region,
    required String address,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'shop_name': shop_name,
      'phone': phone,
      'country': country,
      'city': city,
      'region': region,
      'address': address,
      'password': password,
    }).then((value) {
      emit(RegisterSuccessState());
      userModel = UserModel.fromJson(value.data);
      showToast(msg: '${userModel!.message}', state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(RegisterErrorState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  List categories = [];
  List products = [];
  List brands = [];
  void getData() {
    categories = [];
    products = [];
    brands = [];
    emit(GetDataLoadingState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      emit(GetDataSuccessState());
      myCart();
      categoriesModel = CategoriesModel.fromJson(value.data);
      categoriesModel!.categories!.forEach((category) {
        categories.add(category);
        category.products.forEach((product) {
          products.add(product);
        });
      });
    }).catchError((error) {
      emit(GetDataErrorState());
      print(error.toString());
    });
  }

  void changeCurrentIndex(index) {
    currentindex = index;
    emit(ChangeBottomNavbarState());
  }

  void userLogin({
    required String phone,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'phone': phone,
      'password': password,
    }).then((value) {
      if (value.statusCode == 200) {
        if (!value.data['success']) {
          emit(LoginErrorState());
          showToast(msg: '${value.data['message']}', state: ToastStates.ERROR);
        } else {
          emit(LoginSuccessState());
          showToast(
              msg: '${value.data['message']}', state: ToastStates.SUCCESS);
          userModel = UserModel.fromJson(value.data);
          CacheHelper.saveData(
              key: 'shop_name', value: userModel!.data!.shop_name);
          CacheHelper.saveData(key: 'phone', value: userModel!.data!.phone);
          CacheHelper.saveData(key: 'token', value: userModel!.data!.token);
        }
      } else {
        emit(LoginErrorState());
        showToast(msg: '${value.data['error']}', state: ToastStates.ERROR);
      }
    }).catchError((error) {
      emit(LoginErrorState());
      print(error.toString());
      showToast(msg: 'يرجي التأكد من ان حسابك مفعل', state: ToastStates.ERROR);
    });
  }

  void resetPassword({
    required String password,
  }) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(url: RESETPASSWORD, data: {
      'phone': CacheHelper.getData('phone'),
      'new_password': password,
      'confirm_password': password,
    }).then((value) {
      if (!value.data['success']) {
        emit(ResetPasswordErrorState());
        showToast(msg: '${value.data['message']}', state: ToastStates.ERROR);
        print('false');
      } else {
        emit(ResetPasswordSuccessState());
        showToast(msg: '${value.data['message']}', state: ToastStates.SUCCESS);
        userModel = UserModel.fromJson(value.data);
        CacheHelper.saveData(key: 'token', value: userModel!.data!.token);
      }
    });
  }

  CartModel? cartModel;
  List cart = [];
  var totalcost;
  var totalDiscount;
  var netTotal;
  void myCart() {
    cart = [];
    totalcost = 0;
    totalDiscount = 0;
    netTotal = 0;
    DioHelper.postData(url: MYCART).then((value) {
      emit(GetCartDataLoadingState());
      if (value.statusCode == 200) {
        emit(GetCartDataSuccessState());
        cartModel = CartModel.fromJson(value.data);
        totalDiscount = cartModel!.totalDiscount;
        totalcost = cartModel!.totalcost;
        netTotal = totalcost - totalDiscount;
        cartModel!.shoppingCart!.forEach((product) {
          cart.add(product);
        });
      }
    }).catchError((error) {
      emit(GetCartDataErrorState());
      print(error.toString());
    });
  }


  void addToCart({
    required int product_id,
    required String quantity,
  }) {
    emit(AddToCartLoadingState());
    DioHelper.postData(url: ADDTOCART, data: {
      'product_id': product_id,
      'quantity': quantity,
    }).then((value) {
      emit(AddToCartSuccessState());
      myCart();
      showToast(msg: 'تم الاضافة الى سله التسوق', state: ToastStates.SUCCESS);
      print('done');
    }).catchError((e) {
      emit(AddToCartErrorState());
      showToast(msg: 'حدث خطأ ما برجاء المحاولة فيما بعد', state: ToastStates.ERROR);
      print(e.toString());
    });
  }


  void updateCart({
    required int cart_id,
    required String quantity,
  }) {
    emit(UpdateCartLoadingState());
    DioHelper.postData(url:UPDATECART, data: {
      'cart_id': cart_id,
      'quantity':quantity,
    }).then((value) {
      emit(UpdateCartSuccessState());
      myCart();
      print('done');
    }).catchError((e) {
      myCart();
      emit(UpdateCartErrorState());
      print(e.toString());
    });
  }

  void removeFromCart({
    required int cart_id,
  }) {
    emit(RemoveFromCartLoadingState());
    DioHelper.postData(url: DELETEFROMCART, data: {
      'cart_id': cart_id,
    }).then((value) {
      emit(RemoveFromCartSuccessState());
      myCart();
      print('done');
    }).catchError((e) {
      myCart();
      emit(RemoveFromCartErrorState());
      print(e.toString());
    });
  }

  CategoryProductsModel? categoryProductsModel;
  List catProducts = [];
  void getCategoryProducts({required int catId}) {
    catProducts = [];
    emit(GetCategoryProductsLoadingState());
    DioHelper.getData(url: 'https://meza.meeza-app.com/api/v1/showBrand/${catId}').then((value) {
      emit(GetCategoryProductsSuccessState());
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      categoryProductsModel!.data!.products!.forEach((product) {
        catProducts.add(product);
      });
    }).catchError((error) {
      emit(GetCategoryProductsErrorState());
      print(error.toString());
    });
  }


  BillModel? billModel;
  void checkOut() {
    emit(CheckOutLoadingState());
    DioHelper.getData(url: CHECKOUT).then((value) {
      emit(CheckOutSuccessState());
      billModel = BillModel.fromJson(value.data);
      myCart();
    }).catchError((e) {
      myCart();
      emit(CheckOutErrorState());
      print(e.toString());
    });
  }
}
