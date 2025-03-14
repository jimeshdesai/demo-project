import 'package:demoproject/utils/color.dart';
import 'package:demoproject/utils/routes/routes.dart';
import 'package:demoproject/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.light));
    return Builder(
      builder: (context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  background: AppColors.whiteColor,
                  seedColor: AppColors.blueColor,
                  brightness: Brightness.light),
              useMaterial3: false,
            ),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
