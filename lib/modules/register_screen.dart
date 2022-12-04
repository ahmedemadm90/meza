import 'dart:developer';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/home_screen.dart';
import 'package:meza/modules/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/network/remote/dio_helper.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

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
        final shopName = TextEditingController();
        final phone = TextEditingController();
        final password = TextEditingController();
        final country = TextEditingController(text: 'مصر');
        final city = TextEditingController(text: 'الأسكندرية');
        final region = TextEditingController();
        final address = TextEditingController();
        final storephone = TextEditingController();
        final ImagePicker _picker = ImagePicker();
        File? file;
        String? fileName;

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
                                fontSize: 20.sp, color: HexColor('FBB911')),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          defaultFormField(
                              controller: shopName,
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
                            height: 2.h,
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
                            height: 2.h,
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
                            height: 2.h,
                          ),
                          defaultFormField(
                              controller: country,
                              keyType: TextInputType.text,
                              isClickable: false,
                              validate: (String? value) {
                                if (value!.trim().isEmpty) {
                                  return "الدولة مطلوبة";
                                }
                                return null;
                              },
                              prefix: Icon(Icons.real_estate_agent),
                              text: 'الدولة'),
                          SizedBox(
                            height: 2.h,
                          ),
                          defaultFormField(
                              controller: city,
                              isClickable: false,
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
                            height: 2.h,
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
                            height: 2.h,
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
                            height: 2.h,
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
                            height: 2.h,
                          ),
                          defaultBtn(
                              background: HexColor('FBB911'),
                              textColor: Colors.white,
                              function: () async {
                                FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                                  type: FileType.image
                                );
                                if (result != null) {
                                  file = File(result.files.single.path ?? " ");
                                  fileName =
                                      file!.path.split('/').last;
                                }else{
                                  showToast(msg: 'صورة المحل مطلوبة', state: ToastStates.ERROR);
                                  return null;
                                }
                              },
                              isUpperCase: true,
                              text: 'رفع صورة المحل'),
                          SizedBox(
                            height: 2.h,
                          ),
                          ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => defaultBtn(
                                  background: HexColor('129399'),
                                  textColor: Colors.white,
                                  function: () async {
                                    var dio = Dio();
                                    if (file != null) {
                                      FormData data = FormData.fromMap({
                                        'shop_name': shopName.text,
                                        'phone': phone.text,
                                        'country': country.text,
                                        'city': city.text,
                                        'region': region.text,
                                        'address': address.text,
                                        'password': password.text,
                                        'image': await MultipartFile.fromFile(
                                            file!.path,
                                            filename: fileName),
                                      });
                                      var response = await dio.post('https://www.meza.meeza-app.com/api/v1/users/register',data: data,onSendProgress: (int sent,int total){
                                        print ('$sent, $total');
                                      });
                                      if(response.data['success'] == true){
                                        navigateAndReplace(context, LoginScreen());
                                        showToast(msg: 'تم التسجيل بنجاح برجاء تسجيل الدخول للمتابعة', state: ToastStates.SUCCESS);
                                      }else{
                                        showToast(msg: 'فشل التسجيل برجاء مراجعة البانات واعادة المحاولة فيما بعد', state: ToastStates.ERROR);
                                      }
                                    }
                                  },
                                  text: 'تسجيل',
                                  isUpperCase: true),
                              fallback: (context) =>
                                  CircularProgressIndicator()),
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
