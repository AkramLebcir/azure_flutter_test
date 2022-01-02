import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/features/accounts_list/presentation/bloc/accounts_list_bloc.dart';
import 'core/features/accounts_list/presentation/cubit/view/view_cubit.dart';
import 'core/features/accounts_list/presentation/view/accounts_list_detail_page.dart';
import 'core/features/accounts_list/presentation/view/accounts_list_page.dart';
import 'core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'core/features/auth/presentation/view/auth_screen.dart';
import 'injection_container.dart';
import 'shared/common/common.dart';
import 'shared/utils/app_bloc_observer.dart';
import 'shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // final storage = await HydratedStorage.build(
  //   storageDirectory: await getApplicationDocumentsDirectory(),
  // );

  Bloc.observer = AppBlocObserver();
  await init();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // runZonedGuarded(
  //   () {
  runApp(MyApp());
  configLoading();
  //   },
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorPalettes.lightAccent
    ..backgroundColor = ColorPalettes.green
    ..indicatorColor = ColorPalettes.lightAccent
    ..textColor = ColorPalettes.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => inject<AuthBloc>()..add(AppLoaded()),
          ),
          BlocProvider(
            create: (context) => inject<AccountsListBloc>(),
          ),
          BlocProvider(
            create: (context) => inject<ViewCubit>(),
          ),
        ],
        child: ResponsiveSizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            navigatorKey: inject<Navigation>().navigatorKey,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            theme: Themes.lightTheme,
            // darkTheme: Themes.darkTheme,
            initialRoute: "/",
            routes: {
              '/': (BuildContext ctx) => const Shell(),
              'detail': (BuildContext ctx) => const AccountsListDetailPage(),
            },
          );
        }));
  }
}
