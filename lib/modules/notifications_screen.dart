import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

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
        return RefreshIndicator(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConditionalBuilder(
                condition: state is! GetNotificationsLoadingState,
                builder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildBillRow(
                              MezaAppCubit.get(context).notifications[index]),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemCount:
                              MezaAppCubit.get(context).notifications.length,
                        ),
                      ],
                    ),
                fallback: (context) => Container(
                      height: 100.h,
                      width: 100.w,
                      child: Center(
                        child: Text('لا يوجد'),
                      ),
                    )),
          ),
          onRefresh: () async {
            Future.delayed(Duration(seconds: 5));
            MezaAppCubit.get(context).getData();
          },
        );
      },
    );
  }

  Widget buildBillRow(notification) => Container(
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${notification.order.id} '),
                          Text('تم اصدار الفاتورة رقم '),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${notification.order.createdAt}'),
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
