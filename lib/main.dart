import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashon_app/Feature/Home/presentation/home.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/eroor_page.dart';
import 'package:fashon_app/Feature/Login/manger/login_cubit.dart';
import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
import 'package:fashon_app/core/blocobserve.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/local/cache_Helper.dart';
import 'package:fashon_app/core/remote/dio_helper.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fancy_cart/fancy_cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  // await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();

  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // var box = await Hive.openBox('testBox');

  // box.put('name', 'David');
  // Use cubits...
  Future.delayed(const Duration(seconds: 5), () {
    FlutterNativeSplash.remove();
  });

  Widget? start;

  TOKEN = CacheHelper.getData(key: "Token") ?? '';
  UID = CacheHelper.getData(key: "UID") ?? 0;
  print("Token Is _________---------_____ $TOKEN");
  print("UID Is _________---------_____ $UID");

  if (TOKEN == '') {
    start = const LoginPage();
  } else {
    start = const Homepage();
  }
  initializeFancyCart(
    child: MyApp(
      start: start,
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.start});
  Widget start;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            // HomeCubit.get(context).getProfile(Token: TOKEN!);
            return HomeCubit();
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return LoginCubit();
          },
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Siu',
              // fontFamily: GoogleFonts.openSans(),
              useMaterial3: true,
              primaryColor: Colors.blue,

              // Define the default brightness and colors.
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                // ···
                brightness: Brightness.light,
              ),
            ),
            home: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.data == ConnectivityResult.none
                    ? const EroorPage()
                    : start;
              },
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
