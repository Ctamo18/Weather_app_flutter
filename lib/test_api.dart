import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_weather_flutter/weather_details.dart';
import 'package:intl/intl.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({Key? key}) : super(key: key);

  @override
  _ApiTestState createState() => _ApiTestState();
}

Future<WeatherDetails> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Abidjan&units=metric&appid=97eb7d1ddf6b81b092cf2d15f3d5fd7c'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather info');
  }
}

class _ApiTestState extends State<ApiTest> {
  late Future<WeatherDetails> weatherDetails;
  @override
  void initState() {
    super.initState();
    weatherDetails = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_rounded, color: Colors.white),
        title: Text(
          "API Test",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _getWeatherInfo("sunrise"),
      ),
    );
  }

  Widget _getWeatherInfo(String info) {
    switch (info) {
      case 'id':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.id.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'cityName':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.cityName);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'temp':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.temp.toStringAsFixed(0));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'tempMin':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.tempMin.toStringAsFixed(0));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'tempMax':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.tempMax.toStringAsFixed(0));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'feelsLike':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.feelsLike.toStringAsFixed(0));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'pressure':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.pressure.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'humidity':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.humidity.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'windSpeed':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.windSpeed.toStringAsFixed(1));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'sunrise':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(DateFormat.Hm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.sunrise * 1000)));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'sunset':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(DateFormat.Hm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.sunset * 1000)));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'timezone':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.timezone.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'description':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.description.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'icon':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(
                  'https://openweathermap.org/img/wn/${snapshot.data!.icon}@4x.png');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      default:
        return const CircularProgressIndicator();
    }
  }
}
