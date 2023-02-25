import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_repos/weather_model.dart';




import '../weather Api/weather_Api.dart';

final ValueNotifier<double> temperature = ValueNotifier<double>(0.0);

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _cityInputController = TextEditingController();
  Future<Weather?>? futureWeather;

  // String place = '';
  // String conditions = '';
  // String country = '';
  // String tempeC = '';
  // String tempeF = '';
  // String wHumidity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF676BD0),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: _cityInputController,
              decoration: InputDecoration(
                  hintText: 'Search a city',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        final city = _cityInputController.text;
                        // final result = await fetchWeather(city: city);

                        setState(() {
                          futureWeather = fetchWeather(city: city);

                          // place = result.name ?? 'not found';
                          // conditions = result.condition ?? '';
                          // country = result.country ?? '';
                          // tempeC = result.tempC ?? '';
                          // tempeF = result.tempF ?? '';
                          // wHumidity = result.humidity ?? '';
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
            ),

            // cupertino Textfield

            // CupertinoTextField(
            //   placeholder: ,

            // ),






            const SizedBox(
              height: 15,
            ),

            //futureBuilder

            FutureBuilder<Weather?>(
              future: futureWeather,
              builder: (context, snapshot) {
                log(futureWeather.toString());
                if (snapshot.hasData) {
                  final result = snapshot.data;

                  double tempDouble = double.parse(result!.tempC ?? "0.0");

                  temperature.value = tempDouble;

                  log(result.toString());
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${result.name}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${result.condition}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${result.country}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      //image
                      ValueListenableBuilder(
                        valueListenable: temperature,
                        builder: (context, double value, _) {
                          log('temp: ${temperature.value}');
                          return getImage(temperature.value);
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('Temp - C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                          Text('Temp - F',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                          Text('Humidity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${result.tempC}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${result.tempF}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${result.humidity}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        const Text(
                          'Search a city',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        Center(
                            child: Lottie.asset(
                          'assets/images/4802-weather-snow-sunny.json',
                          width: 250,
                          height: 250,
                          fit: BoxFit.fill,
                        )),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 200),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 230),
                    child: Text(
                      "Something went wrong!!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }

  // Widget myWeather(Weather weather) {
  //   return Column(
  //     children: [
  //       Text("${weather.name}"),
  //       Text("${weather.condition}"),
  //       Text("${weather.country}"),
  //       Text("${weather.tempC}"),
  //       Text("${weather.tempF}"),
  //       Text("${weather.humidity}")
  //     ],
  //   );
  // }

  Widget getImage(double temperature) {
    if (temperature < 10) {
      return Lottie.asset('assets/images/35743-weather-day-snow.json');
    } else if (temperature < 20) {
      return Lottie.asset('assets/images/50651-cloudy.json');
    } else if (temperature < 30) {
      return Lottie.asset('assets/images/4800-weather-partly-cloudy.json');
    } else if (temperature < 40) {
      return Lottie.asset('assets/images/82378-sunny-weather.json',
          height: 220);
    } else {
      return Lottie.asset('assets/images/82378-sunny-weather.json');
    }
  }
}
