import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/login_page.dart';
import 'package:task_manager_new/ui/screens/main_nav_bar_folder.dart';
import 'package:task_manager_new/ui/screens/sign_up.dart';
import 'package:task_manager_new/ui/screens/splash_screen.dart';
import 'package:task_manager_new/ui/screens/update_profile.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey <NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            helperStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            )
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          ),
        ),
      ),
      initialRoute: '/SplashScreen',
      routes: {
        '/SplashScreen':(_) => SplashScreen(),
        '/Login':(_) => LoginPage(),
        '/SignUp':(_) => SignUp(),
        '/NavBar':(_) => MainNavBarFolder(),
        '/UpdateProfile':(_) => UpdateProfile(),

      },
    );
  }
}
