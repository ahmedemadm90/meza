import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:meza/modules/cart_screen.dart';
import 'package:meza/modules/category_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

class ProductsScrren extends StatelessWidget {
  //const ProductsScrren({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<TextEditingController> QtyControllers = [];
        return Scaffold(
          key: scaffoldKey,
          body: RefreshIndicator(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/slider1.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/slider2.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/slider3.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/slider4.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/slider5.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          height: 25.h,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal)),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Row(
                      children: [
                        Text('data')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 7.h,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  buildCategoryItem(
                                      MezaAppCubit.get(context)
                                          .categories[index],
                                      context),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 2.w,
                                  ),
                              itemCount:
                                  MezaAppCubit.get(context).categories.length),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          QtyControllers.add(
                              new TextEditingController(text: '0'));
                          return buildProductRow(
                              MezaAppCubit.get(context).products[index],
                              QtyControllers[index],
                              context,
                              state);
                        },
                        separatorBuilder: (context, inde) => SizedBox(
                              height: 5,
                            ),
                        itemCount: MezaAppCubit.get(context).products.length),
                  ),
                ],
              ),
            ),
            onRefresh: () async {
              Future.delayed(Duration(seconds: 5));
              MezaAppCubit.get(context).getData();
            },
          ),
        );
      },
    );
  }

  Widget buildProductRow(product, controller, context, state) =>
      GestureDetector(
        child: Card(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.name}',
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      '${product.description}',
                      style: TextStyle(fontSize: 8.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            '${product.brand_name}',
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          padding: EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                              color: HexColor('129399'),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Spacer(),
                        Container(
                          child: Text(
                            '${product.category_name}',
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          padding: EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                              color: HexColor('129399'),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      condition: (product.priceDiscount != 0),
                      builder: (context) => ConditionalBuilder(
                        condition: (product.isPrecent != 0),
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${product.price} ج م',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            Text(
                              '${product.price - num.parse(product.priceDiscount.toStringAsFixed(3))} ج م',
                              style: TextStyle(fontSize: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        fallback: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${product.price} ج م',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            ConditionalBuilder(
                              condition: (product.priceDiscount is int),
                              builder: (context) => Text(
                                '${product.price - product.priceDiscount} ج م',
                                style: TextStyle(fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              fallback: (context) => Text(
                                '${product.price - num.parse(product.priceDiscount)} ج م',
                                style: TextStyle(fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      fallback: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${product.price} ج م',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              var currentvalue = int.parse(controller.text);
                              if (currentvalue <= 0) {
                                showToast(
                                    msg: 'القيمة خطأ',
                                    state: ToastStates.ERROR);
                              } else {
                                currentvalue = currentvalue - 1;
                                controller.text = currentvalue.toString();
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 25.sp,
                            ),
                          ),
                          Spacer(),
                          defaultQtyField(
                            controller: controller,
                            keyType: TextInputType.number,
                            validate: () {},
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              var currentvalue = int.parse(controller.text);
                              currentvalue = currentvalue + 1;
                              controller.text = currentvalue.toString();
                            },
                            icon: Icon(
                              CupertinoIcons.cart_badge_plus,
                              color: Colors.green,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultBtn(
                            function: () {
                              if (controller.text != '0') {
                                MezaAppCubit.get(context).addToCart(
                                    product_id: product.id,
                                    quantity: controller.text);
                              } else {
                                showToast(
                                    msg: 'القيمة خطأ',
                                    state: ToastStates.ERROR);
                              }
                            },
                            isUpperCase: true,
                            text: 'أضف الي السلة',
                            width: 40.w,
                            // height: 5.h,
                            textColor: Colors.white,
                            background: HexColor('129399'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                  ],
                )),
                Container(
                  margin: EdgeInsets.all(8),
                  width: 25.w,
                  height: 25.h,
                  child: FadeInImage(
                    image: NetworkImage('${product.image}'),
                    placeholder: AssetImage('assets/images/logo-004.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: HexColor('129399'),
                          borderRadius: BorderRadius.circular(15)),
                      child: Image(
                          image: AssetImage('assets/images/logo-004.jpg')),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          scaffoldKey.currentState!.showBottomSheet((context) {
            return Container(
              width: 100.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Container(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أسم المنتج : ${product.name}'),
                        Text('الوصف : ${product.description}'),
                        Text('الوصف : ${product.description}'),
                        Text('الشركة المصنعة : ${product.brand_name}'),
                        Text('القسم : ${product.category_name}'),
                        ConditionalBuilder(
                          condition: (product.priceDiscount != 0),
                          builder: (context) => ConditionalBuilder(
                            condition: (product.isPrecent != 0),
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${product.price} ج م',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.lineThrough),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Text(
                                  'السعر : ',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.lineThrough),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'السعر : ${product.price - num.parse(product.priceDiscount.toStringAsFixed(3))} ج م',
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            fallback: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  '${product.price} ج م',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.lineThrough),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Text(
                                  'السعر : ${product.price - num.parse(product.priceDiscount)} ج م',
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'السعر : ${product.price} ج م',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        },
      );
  Widget buildCategoryItem(category, context) => GestureDetector(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            '${category.name}',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(.5),
              borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () {
          MezaAppCubit.get(context).getCategoryProducts(catId: category.id);
          navigateTo(context, CategoryScreen());
        },
      );
}
