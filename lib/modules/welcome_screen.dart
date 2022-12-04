import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/login_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';

import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  //const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit,MezaAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(150),
                        ),
                        color: HexColor('129399'),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo-004.jpg'))),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image(
                          image: AssetImage('assets/images/card.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80.w,
                            child: defaultBtn(
                                textColor: Colors.white,
                                background: HexColor('129399'),
                                function: () {
                                  navigateAndReplace(context, LoginScreen());
                                },
                                isUpperCase: true,
                                text: 'تسجيل الدخول الي حسابك'),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.horizontal(),
                            ),
                            child: defaultBtn(
                              background: Colors.white,
                              function: () {
                                navigateAndReplace(context, RegisterScreen());
                              },
                              isUpperCase: true,
                              text: 'تسجيل حساب جديد',
                              textColor: HexColor('129399'),),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
