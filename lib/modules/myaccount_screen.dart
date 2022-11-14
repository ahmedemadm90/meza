import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/cart_screen.dart';
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${CacheHelper.getData('shop_name')} :  اهلا بيك',
                  style: TextStyle(
                    fontFamily: 'Janna',
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${CacheHelper.getData('phone')} :  رقم تليفونك',
                  style: TextStyle(
                    fontFamily: 'Janna',
                    fontSize: 25,
                  ),
                ),
                myDivider(),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('تعديل كلمة المرور',style: TextStyle(
                        fontSize: 18.sp,
                      ),),
                      SizedBox(width: 2.w,),
                      Icon(IconlyBroken.edit),
                    ],
                  ),
                  onTap: (){
                    navigateTo(context, MyCartScrren());
                  },
                )
                // Card(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Column(
                //         mainAxisSize: MainAxisSize.min,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Text(
                //             '${CacheHelper.getData('shop_name')}',
                //             style: TextStyle(
                //               fontFamily: 'Janna',
                //               fontSize: 25,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 15,
                //           ),
                //           Text(
                //             '${CacheHelper.getData('phone')}',
                //             textAlign: TextAlign.end,
                //             style: TextStyle(
                //               fontFamily: 'Janna',
                //               fontSize: 20,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // TextButton(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'تعديل كلمة المرور',
                //         style: TextStyle(
                //             fontFamily: 'Roboto',
                //             fontSize: 25,
                //             color: Colors.black
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Icon(Icons.reset_tv_rounded,color: Colors.black,),
                //     ],
                //   ),
                //   onPressed: () {
                //
                //   },
                // ),
                // GestureDetector(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'نسيت كلمة المرور',
                //         style: TextStyle(
                //           fontFamily: 'Roboto',
                //           fontSize: 25,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Icon(Icons.foggy),
                //     ],
                //   ),
                //   onTap: () {
                //     print('Logout');
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

}