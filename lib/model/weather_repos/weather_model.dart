
class Weather {
  final String? name;
  final String? condition;
  final String? country;
  final String? tempC;
  final String? tempF;
  final String? humidity;

  Weather({
     this.name, this.condition, this.country, this.tempC, this.tempF, this.humidity});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['location']['name'].toString(),
      condition: json['current']['condition']['text'].toString(),
      country: json['location']['country'].toString(),
      tempC: json['current']['temp_c'].toString(),
      tempF: json['current']['temp_f'].toString(),
      humidity: json['current']['humidity'].toString(),

    );
  }
}

