import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/shared/colors.dart';
import 'package:sizer/sizer.dart';

Widget defaultBtn({
  double width = double.infinity,
  double height = 50.0,
  Color background = defaultColor,
  Color textColor = defaultColor,
  required Function function,
  required bool isUpperCase,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          return function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: textColor),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadiusDirectional.circular(10.0),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyType,
  void Function(String? value)? onSubmitFunction,
  void Function(String value)? onChange,
  void Function()? onTab,
  void Function()? suffixPressed,
  required Function validate,
  bool isPassword = false,
  bool isClickable = true,
  //required String label,
  required Icon prefix,
  IconData? sufix,
  required String text,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.solid,
          ),
        ),
        labelText: text,
        prefixIcon: prefix,
        suffixIcon: sufix != null
            ? IconButton(
                icon: Icon(sufix),
                onPressed: suffixPressed,
              )
            : null,
      ),
      obscureText: isPassword,
      onTap: onTab,
      onChanged: onChange,
      enabled: isClickable,
      keyboardType: keyType,
      validator: (value) {
        return validate(value);
      },
    );
Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.black,
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndReplace(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.redAccent;
      break;
    case ToastStates.WARNING:
      color = Colors.yellowAccent;
      break;
  }
  return color;
}

// Widget defaultQtyField({
//   required TextEditingController controller,
//   required TextInputType keyType,
//   required Function validate,
// }) =>
//     Container(
//       width: 10.w,
//       height: 5.h,
//       decoration: BoxDecoration(
//         border: Border.all(),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextFormField(
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly
//         ],
//         controller: controller,
//         keyboardType: keyType,
//         validator: (value) {
//           return validate(value);
//         },
//         enabled: false,
//       ),
//     );
Widget defaultQtyField(
        {required TextEditingController controller,
        required TextInputType keyType,
        required Function validate,
        String? qty}) =>
    Container(
      width: 15.w,
      height: 6.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3, color: HexColor('129399')),
        ),
      ),
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.sp),
        validator: (value) {
          return validate(value);
        },
      ),
    );
Widget defaultCartQtyField({
  required TextEditingController controller,
  required TextInputType keyType,
  required Function validate,
  String? qty,
}) =>
    Container(
      width: 15.w,
      height: 6.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3, color: HexColor('129399')),
        ),
      ),
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.sp),
        validator: (value) {
          return validate(value);
        },
      ),
    );
