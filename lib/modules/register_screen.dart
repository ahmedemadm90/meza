import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/login_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sizer/sizer.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  //const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          navigateAndReplace(context, LoginScreen());
        }
      },
      builder: (context, state) {
        var cubit = MezaAppCubit.get(context);
        final shop_name = TextEditingController();
        final phone = TextEditingController();
        final password = TextEditingController();
        final country = TextEditingController();
        final city = TextEditingController();
        final region = TextEditingController();
        final address = TextEditingController();
        final storephone = TextEditingController();

        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(150),
                        ),
                        color: HexColor('129399'),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo-004.jpg'))),
                  ),
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsetsDirectional.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBroken.addUser,
                                size: 65.sp,
                                color: HexColor('FBB911'),
                              ),
                              Text(
                                'تسجيل عميل جديد',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: HexColor('FBB911')),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: shop_name,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "أسم المحل مطلوب";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.museum),
                                  text: 'أسم المحل'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: phone,
                                  keyType: TextInputType.number,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty ||
                                        value.trim().length < 8) {
                                      return "برجاء أدخال رقم هاتف صحيح";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.phone),
                                  text: 'رقم الهاتف'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: password,
                                  keyType: TextInputType.text,
                                  isPassword: true,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "كلمة المرور مطلوبة";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.lock),
                                  text: 'كلمة المرور'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: country,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "الدولة مطلوبة";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.real_estate_agent),
                                  text: 'الدولة'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: city,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "المحافظة مطلوبة";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.location_city),
                                  text: 'المحافظة'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: region,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "المنطقة مطلوبة";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.location_city),
                                  text: 'المنطقة'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: address,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "عنوان المحل مطلوب";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.location_on),
                                  text: 'عنوان المحل'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultFormField(
                                  controller: storephone,
                                  keyType: TextInputType.number,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty ||
                                        value.trim().length < 8) {
                                      return "برجاء أدخال رقم هاتف صحيح";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.phone_android_outlined),
                                  text: 'رقم تليفون المحل'),
                              SizedBox(
                                height: 1.h,
                              ),
                              defaultBtn(
                                  background: HexColor('FBB911'),
                                  textColor: Colors.white,
                                  function: () {
                                    print('Upload');
                                  },
                                  isUpperCase: true,
                                  text: 'رفع صورة المحل'),
                              SizedBox(
                                height: 1.h,
                              ),
                              ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => defaultBtn(
                                      background: HexColor('129399'),
                                      textColor: Colors.white,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userRegister(
                                              shop_name: shop_name.text,
                                              region: region.text,
                                              phone: phone.text,
                                              password: password.text,
                                              city: city.text,
                                              address: address.text,
                                              country: country.text);
                                        }
                                      },
                                      text: 'تسجيل',
                                      isUpperCase: true),
                                  fallback: (context) => CircularProgressIndicator()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        navigateAndReplace(context, LoginScreen());
                                      },
                                      child: Text('قم بتسجيل الدخول')),
                                  Text('لديك حساب بالفعل'),
                                ],
                              ),
                            ],
                          ),
                        )),
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
