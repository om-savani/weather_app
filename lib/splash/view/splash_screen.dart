import 'package:flutter/material.dart';

import '../../preferences/shr_helper.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ShrHelper shr = ShrHelper();
    shr.getIsFirstTime().then(
      (value) {
        if (value == false) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
          });
        } else {
          Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.pushReplacementNamed(context, AppRoutes.introPage);
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://holmogori.ru/media/resized/p3rN9L7HbGx2O8o_RqiQ25fllC70XY30pojdQSedctY/rs:fit:1024:768/aHR0cHM6Ly9ob2xt/b2dvcmkucnUvbWVk/aWEvcHJvamVjdF9t/b18xNjYvN2EvMjYv/MjgvZTkvMWMvNTcv/cm5pcnI1anR1ZDh2/eV9mcXp0ZnFrcnZk/cnNycTN2cGJ2b3Yx/X2J4bW9nOGxpcWhr/bGtudml1b3RibHZo/bGZrZGprODRvdW1k/dWloMXdqZndiYzQ4/ZWVydC5qcGc.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            const Text(
              'Get Weather Info',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
