import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meza/modules/welcome_screen.dart';
import 'package:meza/shared/bloc_observer.dart';
import 'package:meza/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';

import 'modules/home_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'shared/cubit/cubit.dart';
import 'shared/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  String? token = CacheHelper.getData('token');
  if (token != null) {
    widget = HomeScreen();
  } else {
    widget = WelcomeScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MezaAppCubit()..getData(),
        child: BlocConsumer<MezaAppCubit, MezaAppStates>(
          listener: (context, state) => {},
          builder: (context, state) => Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: startWidget,
            );
          },),
        ));
  }
}

