import 'package:flutter/material.dart';
import 'package:weather_app/weather/screen_weather.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    goToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF676BD0),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/weather_image.png'),
              )),
            ),
          ),
        ));
  }

  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WeatherScreen(),
    ));
  }
}
