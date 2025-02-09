import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/BMI_app/BMIScreen.dart';
import 'package:todo/News_app/cubit/cubit.dart';
import 'package:todo/News_app/layouts/news_layout.dart';
import 'package:todo/Shop_app/layouts/shop_layout.dart';
import 'package:todo/Shop_app/modules/login/shop_loginScreen.dart';
import 'package:todo/Shop_app/modules/onBoarding/onBoardingScreen.dart';
import 'package:todo/Social_app/cubit/cubit.dart';
import 'package:todo/Social_app/layout/social_layout.dart';
import 'package:todo/Social_app/modules/login/social_login.dart';
import 'package:todo/ToDo_app/cubit/cubit.dart';
import 'package:todo/ToDo_app/cubit/states.dart';
import 'package:todo/ToDo_app/layouts/todo_layout.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/network/local/cache_helper.dart';
import 'package:todo/shared/network/remote/dio_helper.dart';
import 'package:todo/shared/bloc/bloc_observer.dart';
import 'package:todo/shared/styles/themes.dart';
import 'Shop_app/cubit/cubit.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On Background Message');
  print(message.data.toString());
  showToast(text: 'On Background Message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  
  print('Token --> $token');

  FirebaseMessaging.onMessage.listen((event) {
    print('On Message');
    print(event.data.toString());
    showToast(text: 'On Message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('On Message Opened App');
    print(event.data.toString());
    showToast(text: 'On Message Opened App', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  Widget widget;
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }

  if(uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(isDark: isDark, startWidget: widget));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;
  MyApp({super.key, this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    // ToDo App => return MaterialApp only
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeMode(fromShared: isDark!),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget
          );
        },
      ),
    );
  }
}
