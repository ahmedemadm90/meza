import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/cart_screen.dart';
import 'package:meza/modules/welcome_screen.dart';
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          showToast(
              msg: '${MezaAppCubit.get(context).userModel!.message}',
              state: ToastStates.SUCCESS);
        }
        if (MezaAppCubit.get(context).categoriesModel == null) {
          MezaAppCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        var cubit = MezaAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'token');
                  CacheHelper.removeData(key: 'phone');
                  navigateAndReplace(context, WelcomeScreen());
                  showToast(
                      msg: 'تم تسجيل خروجك بنجاح', state: ToastStates.SUCCESS);
                },
                icon: Icon(IconlyBroken.logout,size: 40,)),
            actions: [
              IconButton(onPressed: () {
              }, icon: Icon(IconlyBroken.search,size: 40,)),
              // SizedBox(
              //   width: 1/4.w,
              // ),
              // IconButton(
              //   onPressed: () {
              //     navigateTo(context, MyCartScrren());
              //     MezaAppCubit.get(context).myCart();
              //   },
              //   icon: Stack(
              //     children: [
              //       Icon(Icons.shopping_cart_rounded,size: 40,),
              //       CircleAvatar(
              //         child: Text('${MezaAppCubit.get(context).cart.length}',style: TextStyle(
              //             fontSize: 8,
              //             fontWeight: FontWeight.bold
              //         ),),
              //         backgroundColor: Colors.white,
              //         radius: 8,
              //       ),
              //     ],
              //     alignment: AlignmentDirectional.topStart,
              //   ),
              // ),
            ],
          ),
          body: SafeArea(
            child: cubit.screens[cubit.currentindex],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: cubit.currentindex,
          //   onTap: (index) {
          //     cubit.changeCurrentIndex(index);
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //         icon: Icon(IconlyBroken.profile), label: 'حسابي'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.history), label: 'فواتيري'),
          //     BottomNavigationBarItem(
          //         icon: Stack(
          //           children: [
          //             Icon(Icons.shopping_cart_rounded,size: 40,),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: CircleAvatar(
          //                 child: Text('${MezaAppCubit.get(context).cart.length}',style: TextStyle(
          //                     fontSize: 8,
          //                     fontWeight: FontWeight.bold
          //                 ),),
          //                 backgroundColor: Colors.white,
          //                 radius: 8,
          //               ),
          //             ),
          //           ],
          //           alignment: AlignmentDirectional.topStart,
          //         ), label: 'سلتي'),
          //     BottomNavigationBarItem(
          //         icon: Icon(IconlyBroken.message), label: 'الأشعارات'),
          //     BottomNavigationBarItem(
          //         icon: Icon(IconlyBroken.home), label: 'المنتجات'),
          //   ],
          // ),
            bottomNavigationBar: ConvexAppBar(
              height: 7.h,
              backgroundColor: HexColor('129399'),
              initialActiveIndex: 4,
              items: [
                TabItem(icon: Icons.settings, title: 'الضبط'),
                TabItem(icon: Icons.document_scanner_outlined, title: 'فواتيري'),
                TabItem(icon: Icons.shopping_cart, title: 'سلتي'),
                TabItem(icon: Icons.notifications_active, title: 'اشعارات'),
                TabItem(icon: Icons.home, title: 'الرئيسية'),
              ],
              onTap: (int i) => cubit.changeCurrentIndex(i),
            )
        );
      },
    );
  }
}
