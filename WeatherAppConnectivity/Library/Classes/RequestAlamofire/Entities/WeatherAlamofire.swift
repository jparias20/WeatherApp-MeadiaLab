import Foundation

/*
 {
     "coord": {
         "lon": -118.4912,
         "lat": 34.0195
     },
     "weather": [
         {
             "id": 802,
             "main": "Clouds",
             "description": "scattered clouds",
             "icon": "03d"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 299.84,
         "feels_like": 301.7,
         "temp_min": 293.49,
         "temp_max": 313.28,
         "pressure": 1011,
         "humidity": 73
     },
     "visibility": 10000,
     "wind": {
         "speed": 6.69,
         "deg": 270
     },
     "clouds": {
         "all": 40
     },
     "dt": 1658092907,
     "sys": {
         "type": 1,
         "id": 5872,
         "country": "US",
         "sunrise": 1658062494,
         "sunset": 1658113496
     },
     "timezone": -25200,
     "id": 5393212,
     "name": "Santa Monica",
     "cod": 200
 }
*/

struct WeatherResultAlamofire: Decodable {
    
    let weather: [WeatherAlamofire]
    let main: WeatherMainAlamorife
    let wind: WeatherWindAlamofire
    let name: String
}

// MARK: - WeatherAlamofire
struct WeatherAlamofire: Decodable {
    let id: Int
    let description: String
    let icon: String
}

// MARK: - WeatherMainAlamorife
struct WeatherMainAlamorife: Decodable {
    let temp: Float
    let temp_min: Float
    let temp_max: Float
}

// MARK: - WeatherWindAlamofire
struct WeatherWindAlamofire: Decodable {
    let speed: Float
    let deg: Int
}
