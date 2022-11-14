import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:meza/modules/cart_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'dart:math' as math;

class BillsScreen extends StatelessWidget {
  //const BillsScreen({Key? key}) : super(key: key);
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildBillRow(),
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: 200,
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

  Widget buildProductRow() => Card(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('قيمة الفاتورة'),
              Spacer(),
              Text('تاريخ الفاتورة'),
            ],
          ),
          Row(
            children: [
              Text('نوع الفاتورة'),
              Spacer(),
              Text('حالتها'),
            ],
          ),
        ],
      ),
    ),
  );
  Widget buildBillRow() => Container(
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('قيمة الفاتورة'),
                      Spacer(),
                      Text('تاريخ الفاتورة'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('نوع الفاتورة'),
                      Spacer(),
                      Text('حالتها'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: HexColor('129399'),
                child: Text('الرقم',style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
