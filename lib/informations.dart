import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_weather_flutter/weather_details.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class Information extends StatefulWidget {
  const Information({Key? key, required this.cityName}) : super(key: key);
  final String cityName;
  @override
  _InformationState createState() => _InformationState();
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

class _InformationState extends State<Information> {
  late Future<WeatherDetails> weatherDetails;
  @override
  void initState() {
    super.initState();
    weatherDetails = fetchWeather(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          toolbarHeight: 300,
          flexibleSpace: Image(
            image: AssetImage('assets/images/bg_sunny.jpg'),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: new Text(
            "Weather",
            style: TextStyle(fontSize: 40, color: Colors.black87),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),

        //body

        body: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.only(top: 80, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getWeatherInfo("cityName"),
                          SizedBox(height: 3),
                          _getWeatherInfo("dt"),
                          SizedBox(height: 5),
                          Row(children: [
                            _getWeatherInfo('icon'),
                            _getWeatherInfo("temp"),
                          ])
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _getWeatherInfo("description"),
                          SizedBox(height: 3),
                          _getWeatherInfo("tempMax"),
                          SizedBox(height: 5),
                          _getWeatherInfo("feelsLike")
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Previsional

              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Image.asset('assets/images/sunrise.jpg',
                                  height: 30),
                              margin: EdgeInsets.only(right: 10)),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Sunrise",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: _getWeatherInfo("sunrise"),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(children: [
                        Expanded(child: Divider(color: Colors.black)),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('assets/images/sunset.png',
                                height: 30),
                            margin: EdgeInsets.only(right: 13),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Sunset",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: _getWeatherInfo("sunset"),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(children: [
                        Expanded(child: Divider(color: Colors.black)),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('assets/images/wind.png',
                                height: 30),
                            margin: EdgeInsets.only(right: 13),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Wind",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: _getWeatherInfo("windSpeed"),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(children: [
                        Expanded(child: Divider(color: Colors.black)),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('assets/images/humidity.png',
                                height: 30),
                            margin: EdgeInsets.only(right: 13),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Humidity",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: _getWeatherInfo("humidity"),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(children: [
                        Expanded(child: Divider(color: Colors.black)),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset('assets/images/pressure.png',
                                height: 30),
                            margin: EdgeInsets.only(right: 13),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Text("Pressure",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: _getWeatherInfo("pressure"),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        ));
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
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.temp.toStringAsFixed(0) + '°C',
                style: TextStyle(fontSize: 36, color: Colors.black45),
                textAlign: TextAlign.left,
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
              return Text(
                snapshot.data!.tempMax.toStringAsFixed(0) +
                    '°C / ' +
                    snapshot.data!.tempMax.toStringAsFixed(0) +
                    '°C',
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

      case 'feelsLike':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
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
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.pressure.toString() + ' hPa',
                  style: TextStyle(color: Colors.black));
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
              return Text(snapshot.data!.humidity.toString() + ' %',
                  style: TextStyle(color: Colors.black));
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
              return Text(snapshot.data!.windSpeed.toStringAsFixed(1) + ' m/s',
                  style: TextStyle(color: Colors.black));
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
              return Text(
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.sunrise * 1000)),
                  style: TextStyle(color: Colors.black));
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
              return Text(
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.sunset * 1000)),
                  style: TextStyle(color: Colors.black));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        );
      case 'dt':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                DateFormat.E().add_yMMMMd().format(
                    DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data!.sunset * 1000)),
                style: TextStyle(fontSize: 15, color: Colors.grey[(500)]),
                textAlign: TextAlign.left,
              );
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
              return Text(
                snapshot.data!.description.toString(),
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

      case 'icon':
        return FutureBuilder<WeatherDetails>(
          future: weatherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(
                  'https://openweathermap.org/img/wn/${snapshot.data!.icon}@4x.png',
                  height: 70,
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
