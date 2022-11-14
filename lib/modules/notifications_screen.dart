import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'dart:math' as math;

class NotificationsScreen extends StatelessWidget {
  //const NotificationsScreen({Key? key}) : super(key: key);
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
                  itemCount: 100,
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
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('محتوي الاشعار'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('تاريخ الاشعار'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
