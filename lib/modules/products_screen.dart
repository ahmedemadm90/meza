import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {
        if (MezaAppCubit.get(context).categoriesModel == null) {
          MezaAppCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        List<TextEditingController> QtyControllers = [];
        return RefreshIndicator(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider(
                    items: [
                      Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/slider1.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/slider2.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/slider3.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/slider4.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 200,
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
                            itemBuilder: (context, index) => buildCategoryItem(
                                MezaAppCubit.get(context).categories[index],
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
        );
      },
    );
  }

  Widget buildProductRow(product, controller, context, state) => Card(
        child: Container(
          width: double.infinity,
          height: 30.h,
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
                    style: TextStyle(fontSize: 20.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.description}',
                    style: TextStyle(fontSize: 10.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.price} ج م',
                    style: TextStyle(fontSize: 15.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    width: 62.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            var currentvalue = int.parse(controller.text);
                            if (currentvalue <= 0) {
                              showToast(
                                  msg: 'القيمة خطأ', state: ToastStates.ERROR);
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
                          icon: Icon(CupertinoIcons.cart_badge_plus,
                              color: Colors.green,size: 25.sp,),
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
                            }else{
                              showToast(
                                  msg: 'القيمة خطأ', state: ToastStates.ERROR);
                            }
                          },
                          isUpperCase: true,
                          text: 'أضف الي السلة',
                          width: 40.w,
                          height: 5.h,
                          textColor: Colors.white,
                          background: HexColor('129399'),
                        ),
                      ],
                    ),
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.all(8),
                height: 30.h,
                width: 30.w,
                child:FadeInImage(
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
      );
  Widget buildCategoryItem(category, context) => GestureDetector(
    child: Container(
      height: 50,
      padding: EdgeInsets.all(15),
      child: Text(
        '${category.name}',
        style:
        Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(.5),
          borderRadius: BorderRadius.circular(10)),
    ),
    onTap: (){
      MezaAppCubit.get(context).getCategoryProducts(catId: category.id);
      navigateTo(context, CategoryScreen());
    },
  );
}
