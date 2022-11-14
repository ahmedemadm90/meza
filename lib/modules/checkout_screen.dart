import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meza/modules/home_screen.dart';
import 'package:meza/shared/components.dart';
import 'package:meza/shared/cubit/cubit.dart';
import 'package:meza/shared/cubit/states.dart';

class CheckOutScreen extends StatelessWidget {
  //const CheckOutScreen({Key? key}) : super(key: key);

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
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: ConditionalBuilder(
              condition: MezaAppCubit.get(context).billModel != null,
              builder: (context)=>Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(image: AssetImage('assets/images/checkOut.png')),
                    ),
                    Text('تم أستلام فاتورتك بنجاح',style: TextStyle(
                        fontSize: 35,
                        color: HexColor('129399')
                    ),),
                    myDivider(),
                    Text('رقم الفاتورة : ${MezaAppCubit.get(context).billModel!.id}',style: TextStyle(
                        fontSize: 15,
                        color: HexColor('129399')
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: HexColor('129399'),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          MezaAppCubit.get(context).checkOut();
                          navigateAndReplace(context, HomeScreen());
                        },
                        child: Text('العودة للتسوق',style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context)=>Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
