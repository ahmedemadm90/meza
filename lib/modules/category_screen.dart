import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  //const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<TextEditingController> QtyControllers = [];
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: RefreshIndicator(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConditionalBuilder(
                        condition: state is! GetCategoryProductsLoadingState,
                        builder: (context) => ConditionalBuilder(
                            condition: MezaAppCubit.get(context)
                                .catProducts
                                .isNotEmpty,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  QtyControllers.add(
                                      new TextEditingController(text: '0'));
                                  return buildProductRow(
                                      MezaAppCubit.get(context)
                                          .catProducts[index],
                                      QtyControllers[index],
                                      context,
                                      state);
                                },
                                separatorBuilder: (context, inde) => SizedBox(
                                      height: 5,
                                    ),
                                itemCount: MezaAppCubit.get(context)
                                    .catProducts
                                    .length),
                            fallback: (context) => Container(
                                  width: 100.w,
                                  height: 75.h,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'لاتوجد اي منتجات بهذا القسم',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        Image(image: AssetImage('assets/images/404.png')),
                                        defaultBtn(function: (){
                                          Navigator.pop(context);
                                        }, isUpperCase: true, text: 'الرجوع',textColor: Colors.white,width: 25.w,background: HexColor('129399'))
                                      ],
                                    ),
                                  ),
                                )),
                        fallback: (context) => Container(
                          width: 100.w,
                          height: 75.h,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onRefresh: () async {
                Future.delayed(Duration(seconds: 5));
                MezaAppCubit.get(context).getData();
              },
            ),
          ),
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
                child: FadeInImage(
                  image: NetworkImage('${product.image}'),
                  placeholder: AssetImage('assets/images/logo-004.jpg'),
                  imageErrorBuilder: (context, error, stackTrace) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: HexColor('129399'),
                        borderRadius: BorderRadius.circular(15)),
                    child:
                        Image(image: AssetImage('assets/images/logo-004.jpg')),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
