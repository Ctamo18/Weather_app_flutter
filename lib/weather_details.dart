class WeatherDetails {
  final int id;

  final dynamic temp;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic feelsLike;
  final int pressure;
  final int humidity;
  final dynamic windSpeed;
  final int sunrise;
  final int sunset;
  final int timezone;
  final int dt;

  final String description;
  final String icon;

  final String cityName;

  WeatherDetails(
      {required this.id,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.feelsLike,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.sunrise,
      required this.sunset,
      required this.timezone,
      required this.description,
      required this.icon,
      required this.cityName,
      required this.dt});

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
        id: json['id'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        feelsLike: json['main']['feels_like'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset'],
        timezone: json['timezone'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
        cityName: json['name'],
        dt: json['dt']);
  }
}





/* Exemple de résultat d'un appel de l'API :
{
  "coord":{"lon":-0.1257,"lat":51.5085},
  "weather":[
    {"id":802,
    "main":"Clouds",
    "description":"scattered clouds",
    "icon":"03d"
    }
  ],
  "base":"stations",
  "main":{
    "temp":4.69,
    "feels_like":4.69,
    "temp_min":2.06,
    "temp_max":8.16,
    "pressure":1038,
    "humidity":93
  },
  "visibility":10000,
  "wind":{
    "speed":1.03,
    "deg":90
  },
  "clouds":{"all":40},
  "dt":1642506026,
  "sys":{"type":2,"id":2019646,"country":"GB","sunrise":1642492606,"sunset":1642523074},
  "timezone":0,
  "id":2643743,
  "name":"London",
  "cod":200
}
*/
