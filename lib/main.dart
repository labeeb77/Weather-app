import 'package:flutter/material.dart';
import 'package:weather_app/weather/screen_splash.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderSide:const BorderSide(color: Color.fromARGB(255, 113, 212, 236)),
                  borderRadius: BorderRadius.circular(20)
                )
          )),
      home: const ScreenSplash(),
    );
  }
}
