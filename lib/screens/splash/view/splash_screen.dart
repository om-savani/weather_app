import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/utils/extentions/sizedbox_extention.dart';
import '../../../preferences/shr_helper.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    ShrHelper shr = ShrHelper();
    shr.getIsFirstTime().then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        final route =
            value == false ? AppRoutes.initialRoute : AppRoutes.introPage;
        Navigator.pushReplacementNamed(context, route);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(
                      'lib/assets/images/splash.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            30.h,
            Text(
              'Get Weather Info',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            20.h,
            const SpinKitWave(
              color: Colors.blueAccent,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
