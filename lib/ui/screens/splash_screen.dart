import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_new/ui/screens/login_page.dart';
import 'package:task_manager_new/ui/utils/asset_paths.dart';
import '../widgets/screen_background.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  
  Future<void>_moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ScreenBackground(child: Center(
            child: SvgPicture.asset(AssetPaths.logoSVG,
            height: 50,
                ),
          )));
  }
}
