import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/home_screen.dart';
import 'package:meza/modules/register_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  //const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MezaAppCubit, MezaAppStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          //showToast(msg: '${MezaAppCubit.get(context).userModel!.message}', state: ToastStates.SUCCESS);
          navigateAndReplace(context, HomeScreen());
        }
      },
      builder: (context, state) {
        var cubit = MezaAppCubit.get(context);
        final phone = TextEditingController();
        final password = TextEditingController();
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30.h,
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
                                IconlyBroken.login,
                                size: 130.sp,
                                color: HexColor('FBB911'),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              defaultFormField(
                                  controller: phone,
                                  keyType: TextInputType.phone,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "رقم التليفون مطلوب";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.phone),
                                  text: 'رقم الموبايل'),
                              SizedBox(
                                height: 2.h,
                              ),
                              defaultFormField(
                                  controller: password,
                                  isPassword: true,
                                  keyType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.trim().isEmpty) {
                                      return "كلمة المرور مطلوبة";
                                    }
                                    return null;
                                  },
                                  prefix: Icon(Icons.lock),
                                  text: 'كلمة المرور'),
                              SizedBox(
                                height: 2.h,
                              ),
                              ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => defaultBtn(
                                      background: HexColor('129399'),
                                      textColor: Colors.white,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                              phone: phone.text,
                                              password: password.text
                                          );
                                        }
                                      },
                                      text: 'تسجيل الدخول',
                                      isUpperCase: true),
                                  fallback: (context) => CircularProgressIndicator()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: (){
                                    navigateAndReplace(context, RegisterScreen());
                                  }, child: Text('سجل حساب جديد')),
                                  Text('تسجيل حساب جديد'),
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
