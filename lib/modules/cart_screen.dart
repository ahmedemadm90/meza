import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/checkout_screen.dart';
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';

class MyCartScrren extends StatelessWidget {
  //const MyCartScrren({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
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
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text('سلة التسوق'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ConditionalBuilder(
                    condition: state is! UpdateCartLoadingState,
                    builder: (context) => ConditionalBuilder(
                        condition: MezaAppCubit.get(context).cart.length != 0,
                        builder: (context) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        QtyControllers.add(
                                            new TextEditingController());
                                        QtyControllers[index].text =
                                            '${MezaAppCubit.get(context).cart[index].cartQuantity}';
                                        return buildProductRow(
                                          MezaAppCubit.get(context).cart[index],
                                          QtyControllers[index],
                                          QtyControllers[index].text,
                                          context,
                                          state,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 5,
                                          ),
                                      itemCount: MezaAppCubit.get(context)
                                          .cart
                                          .length),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: Container(
                                    height: 25.h,
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text('كـــاش'),
                                              Spacer(),
                                              Text('طريقة الدفع'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  'ج م ${MezaAppCubit.get(context).totalDiscount}'),
                                              Spacer(),
                                              Text('الخــــصم'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  'ج م ${MezaAppCubit.get(context).totalcost}'),
                                              Spacer(),
                                              Text(
                                                'أجمالـــي الفاتــــورة',
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          myDivider(),
                                          Row(
                                            children: [
                                              Text(
                                                  'ج م ${MezaAppCubit.get(context).netTotal}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Spacer(),
                                              Text('قيمــة الفاتورة',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: HexColor('129399'),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                MezaAppCubit.get(context)
                                                    .checkOut();
                                                navigateTo(
                                                    context, CheckOutScreen());
                                              },
                                              child: Text(
                                                'اطلــــب',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                        fallback: (context) => Center(
                              child: Text(
                                'سلة التسوق خاصتك فارغة',
                                style: TextStyle(fontSize: 25),
                              ),
                            )),
                    fallback: (context) => Container(
                          height: 100.h,
                          width: 100.w,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'برجاء الأنتظار جاري تنفيذ طلبك',
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                CircularProgressIndicator()
                              ],
                            ),
                          ),
                        )),
              ),
              onRefresh: () async {
                Future.delayed(Duration(seconds: 5));
                MezaAppCubit.get(context).myCart();
              },
            ),
          ),
        );
      },
    );
  }

  // Widget buildProductRow(cartItem, controller, qty, context, state) => Card(
  //       child: Container(
  //         width: double.infinity,
  //         height: 33.h,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     '${cartItem.product.name}',
  //                     style: TextStyle(fontSize: 12.sp),
  //                     maxLines: 2,
  //                     textAlign: TextAlign.end,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   SizedBox(
  //                     height: 2.sp,
  //                   ),
  //                   Text(
  //                     '${cartItem.product.description}',
  //                     style: TextStyle(fontSize: 8.sp),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   SizedBox(
  //                     height: 2.sp,
  //                   ),
  //                   Row(
  //                     children: [
  //                       IconButton(
  //                         onPressed: () => showDialog<String>(
  //                           context: context,
  //                           builder: (BuildContext context) => AlertDialog(
  //                             contentPadding: EdgeInsets.zero,
  //                             titlePadding: EdgeInsets.zero,
  //                             title: Container(
  //                               color: HexColor('129399'),
  //                               child: Padding(
  //                                 padding: EdgeInsets.all(1.h),
  //                                 child: Text(
  //                                   'تأكيد حذف منتج',
  //                                   textAlign: TextAlign.end,
  //                                   style: TextStyle(color: Colors.white),
  //                                 ),
  //                               ),
  //                             ),
  //                             content: Container(
  //                               padding: EdgeInsets.all(10),
  //                               width: double.infinity,
  //                               child: Text(
  //                                 'هل انت متأكد من الحذف',
  //                                 textAlign: TextAlign.end,
  //                               ),
  //                             ),
  //                             actions: [
  //                               Row(
  //                                 children: [
  //                                   Container(
  //                                     child: MaterialButton(
  //                                       onPressed: () {
  //                                         Navigator.pop(context);
  //                                       },
  //                                       child: Text(
  //                                         'الغاء',
  //                                         style: TextStyle(color: Colors.white),
  //                                       ),
  //                                     ),
  //                                     decoration: BoxDecoration(
  //                                         color: HexColor('D9534F'),
  //                                         borderRadius:
  //                                             BorderRadiusDirectional.circular(
  //                                                 10)),
  //                                   ),
  //                                   Spacer(),
  //                                   Container(
  //                                     child: MaterialButton(
  //                                       onPressed: () {
  //                                         MezaAppCubit.get(context)
  //                                             .removeFromCart(
  //                                           cart_id: cartItem.id,
  //                                         );
  //                                         Navigator.pop(context);
  //                                       },
  //                                       child: Text(
  //                                         'تأكيد',
  //                                         style: TextStyle(color: Colors.white),
  //                                       ),
  //                                     ),
  //                                     decoration: BoxDecoration(
  //                                         color: HexColor('129399'),
  //                                         borderRadius:
  //                                             BorderRadiusDirectional.circular(
  //                                                 10)),
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         icon: Icon(
  //                           CupertinoIcons.delete_solid,
  //                           color: Colors.red,
  //                         ),
  //                       ),
  //                       Spacer(),
  //                       Text(
  //                         'الكمية : ${cartItem.cartQuantity}',
  //                         style: TextStyle(fontSize: 10.sp),
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ],
  //                   ),
  //                   Text(
  //                     'القيمة : ${cartItem.product.price * cartItem.cartQuantity} ج م',
  //                     style: TextStyle(fontSize: 10.sp),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   Text(
  //                     '${cartItem.product.price} ج م',
  //                     style: TextStyle(fontSize: 15.sp),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   Container(
  //                     width: 62.w,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         IconButton(
  //                           onPressed: () {
  //                             var currentvalue = int.parse(controller.text);
  //                             if (currentvalue <= 0) {
  //                               showToast(
  //                                   msg: 'القيمة خطأ',
  //                                   state: ToastStates.ERROR);
  //                             } else {
  //                               currentvalue = currentvalue - 1;
  //                               controller.text = currentvalue.toString();
  //                             }
  //                           },
  //                           icon: Icon(
  //                             CupertinoIcons.cart_badge_minus,
  //                             color: Colors.red,
  //                             size: 25.sp,
  //                           ),
  //                         ),
  //                         Spacer(),
  //                         defaultCartQtyField(
  //                           controller: controller,
  //                           keyType: TextInputType.number,
  //                           validate: () {},
  //                         ),
  //                         Spacer(),
  //                         IconButton(
  //                           onPressed: () {
  //                             var currentvalue = int.parse(controller.text);
  //                             currentvalue = currentvalue + 1;
  //                             controller.text = currentvalue.toString();
  //                           },
  //                           icon: Icon(
  //                             CupertinoIcons.cart_badge_plus,
  //                             color: Colors.green,
  //                             size: 25.sp,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: EdgeInsetsDirectional.only(top: 1.h),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         defaultBtn(
  //                           function: () {
  //                             MezaAppCubit.get(context).updateCart(
  //                                 cart_id: cartItem.id,
  //                                 quantity: controller.text);
  //                           },
  //                           isUpperCase: true,
  //                           text: 'تعديل',
  //                           width: 40.w,
  //                           height: 5.h,
  //                           textColor: Colors.white,
  //                           background: HexColor('129399'),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.all(8),
  //               height: 30.h,
  //               width: 30.w,
  //               child: FadeInImage(
  //                 image: NetworkImage('${cartItem.product.image}'),
  //                 placeholder: AssetImage('assets/images/logo-004.jpg'),
  //                 imageErrorBuilder: (context, error, stackTrace) => Container(
  //                   margin: EdgeInsets.all(10),
  //                   decoration: BoxDecoration(
  //                       color: HexColor('129399'),
  //                       borderRadius: BorderRadius.circular(15)),
  //                   child:
  //                       Image(image: AssetImage('assets/images/logo-004.jpg')),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  Widget buildProductRow(cartItem, controller, qty, context, state) =>
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
                      '${cartItem.product.name}',
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      '${cartItem.product.description}',
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
                            '${cartItem.product.brand_name}',
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
                            '${cartItem.product.category_name}',
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
                      condition: (cartItem.product.discount != 0),
                      builder: (context) => ConditionalBuilder(
                        condition: (cartItem.product.isPrecent != 0),
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${cartItem.product.price} ج م',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            Text(
                              '${cartItem.product.price - num.parse(cartItem.product.priceDiscount.toStringAsFixed(3))} ج م',
                              style: TextStyle(fontSize: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        fallback: (context) =>Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${cartItem.product.price} ج م',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            ConditionalBuilder(
                                condition: (cartItem.product.priceDiscount is int),
                                builder: (context)=>Text(
                                  '${cartItem.product.price - cartItem.product.discount} ج م',
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                fallback: (context)=>Text(
                                  '${cartItem.product.price - num.parse(cartItem.product.priceDiscount)} ج م',
                                  style: TextStyle(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${cartItem.product.price} ج م',
                            style: TextStyle(
                              fontSize: 12.sp,),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الكمية المطلوبة : ${cartItem.cartQuantity}',
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      condition: cartItem.product.discount != 0,
                      builder: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          ConditionalBuilder(
                              condition: (cartItem.product.priceDiscount is String),
                              builder: (context)=>Text(
                            'القيمة الأجمالية : ${cartItem.cartQuantity * (cartItem.product.price - num.parse(cartItem.product.priceDiscount))} ج م ',
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                              fallback: (context)=>Text(
                            'القيمة الأجمالية : ${cartItem.cartQuantity * (cartItem.product.price - cartItem.product.priceDiscount)} ج م ',
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                      fallback: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Text(
                            'القيمة الأجمالية : ${cartItem.cartQuantity * cartItem.product.price}  ج م',
                            style: TextStyle(
                              fontSize: 10.sp,
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
                              }else{
                                if(currentvalue == 1){
                                  showToast(msg: 'لا يمكن طلب اقل من وحدة واحدة من المنتج', state: ToastStates.ERROR);
                                }else{
                                  currentvalue = currentvalue - 1;
                                  controller.text = currentvalue.toString();
                                }
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
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  titlePadding: EdgeInsets.zero,
                                  title: Container(
                                    color: HexColor('129399'),
                                    child: Padding(
                                      padding: EdgeInsets.all(1.h),
                                      child: Text(
                                        'تأكيد حذف منتج',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  content: Container(
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    child: Text(
                                      'هل انت متأكد من الحذف',
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Container(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'الغاء',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: HexColor('D9534F'),
                                              borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10)),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: MaterialButton(
                                            onPressed: () {
                                              MezaAppCubit.get(context)
                                                  .removeFromCart(
                                                cart_id: cartItem.id,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'تأكيد',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: HexColor('129399'),
                                              borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            isUpperCase: true,
                            text: 'حذف',
                            width: 20.w,
                            // height: 5.h,
                            textColor: Colors.white,
                            background: HexColor('D9534F'),
                          ),
                          Spacer(),
                          defaultBtn(
                            function: () {
                              if (controller.text != '0') {
                                print(CacheHelper.getData('token'));
                                MezaAppCubit.get(context).updateCart(
                                    cart_id: cartItem.id,
                                    quantity: controller.text);
                              } else {
                                showToast(
                                    msg: 'القيمة خطأ',
                                    state: ToastStates.ERROR);
                              }
                            },
                            isUpperCase: true,
                            text: 'تعديل',
                            width: 20.w,
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
                  height: 50.w,
                  child: FadeInImage(
                    image: NetworkImage('${cartItem.product.image}'),
                    placeholder: AssetImage('assets/images/logo-004.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: HexColor('129399'),
                          borderRadius: BorderRadius.circular(15)),
                      child: FittedBox(
                        child: Image(
                          image: AssetImage('assets/images/logo-004.jpg'),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                      ),
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
                        Text('أسم المنتج : ${cartItem.product.name}'),
                        Text('الوصف : ${cartItem.product.description}'),
                        Text('الوصف : ${cartItem.product.description}'),
                        Text('الشركة المصنعة : ${cartItem.product.brand_name}'),
                        Text('القسم : ${cartItem.product.category_name}'),
                        ConditionalBuilder(
                          condition: (cartItem.product.priceDiscount != 0),
                          builder: (context) => ConditionalBuilder(
                            condition: (cartItem.product.isPrecent != 0),
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${cartItem.product.price} ج م',
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
                                  'السعر : ${cartItem.product.price - num.parse(cartItem.product.priceDiscount.toStringAsFixed(3))} ج م',
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
                                  '${cartItem.product.price} ج م',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.lineThrough),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Text(
                                  'السعر : ${cartItem.product.price - num.parse(cartItem.product.priceDiscount)} ج م',
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
                                'السعر : ${cartItem.product.price} ج م',
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
}
