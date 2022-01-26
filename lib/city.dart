import 'dart:convert';

import 'package:app_weather_flutter/informations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_weather_flutter/weather_details.dart';

class CityView extends StatefulWidget {
  CityView({Key? key}) : super(key: key);

  @override
  _CityViewState createState() => _CityViewState();
}

Future<WeatherDetails> fetchWeather(String cityName) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=97eb7d1ddf6b81b092cf2d15f3d5fd7c&lang=fr'));

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

class _CityViewState extends State<CityView> {
  late Future<WeatherDetails> weatherDetailsA;
  late Future<WeatherDetails> weatherDetailsP;
  late Future<WeatherDetails> weatherDetailsB;

  @override
  void initState() {
    super.initState();
    weatherDetailsA = fetchWeather("Abidjan");
    weatherDetailsP = fetchWeather("Paris");
    weatherDetailsB = fetchWeather("Bruxelles");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "Liste des Villes",
            style: TextStyle(fontSize: 30, color: Colors.yellow),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/bg_cloudy.jpg"),
            fit: BoxFit.fill,
          )),
          padding: EdgeInsets.only(top: 80, left: 5, right: 10),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                          child: _getWeatherInfo('icon', weatherDetailsA)),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abidjan',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 3),
                            _getWeatherInfo(
                              'tempMax',
                              weatherDetailsA,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: _getWeatherInfo('temp', weatherDetailsA)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Information(cityName: "Abidjan")),
                  );
                },
              ),

              //Paris
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                          child: _getWeatherInfo('icon', weatherDetailsB)),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bruxelles',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 3),
                            _getWeatherInfo('tempMax', weatherDetailsB)
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: _getWeatherInfo('temp', weatherDetailsB)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Information(cityName: "Bruxelles")),
                  );
                },
              ),

//Brussel
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                          child: _getWeatherInfo('icon', weatherDetailsP)),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Paris',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 3),
                            _getWeatherInfo('tempMax', weatherDetailsB)
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: _getWeatherInfo('temp', weatherDetailsB)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Information(cityName: "Paris")),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget _getWeatherInfo(String info, Future<WeatherDetails> wd) {
    switch (info) {
      case 'id':
        return FutureBuilder<WeatherDetails>(
          future: wd,
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
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.cityName,
                style: TextStyle(fontSize: 30, color: Colors.black),
                textAlign: TextAlign.left,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'temp':
        return FutureBuilder<WeatherDetails>(
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.temp.toStringAsFixed(0) + '°C',
                style: TextStyle(fontSize: 40, color: Colors.black),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'tempMin':
        return FutureBuilder<WeatherDetails>(
          future: wd,
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
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.tempMax.toStringAsFixed(0) +
                    '°C / ' +
                    snapshot.data!.tempMax.toStringAsFixed(0) +
                    '°C',
                style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                textAlign: TextAlign.left,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'feelsLike':
        return FutureBuilder<WeatherDetails>(
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                "Ressentie : " +
                    snapshot.data!.feelsLike.toStringAsFixed(0) +
                    "°C",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                textAlign: TextAlign.right,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'pressure':
        return FutureBuilder<WeatherDetails>(
          future: wd,
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
          future: wd,
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
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //return Text(snapshot.data!.windSpeed.toStringAsFixed(1));
              return Text(snapshot.data!.windSpeed.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );

      case 'icon':
        return FutureBuilder<WeatherDetails>(
          future: wd,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(
                  'https://openweathermap.org/img/wn/${snapshot.data!.icon}@4x.png',
                  height: 80,
                  color: Colors.yellow);
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
