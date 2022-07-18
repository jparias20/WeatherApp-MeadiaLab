import Foundation
import WeatherAppConnectivity
@testable import WeatherApp

final class WeatherRequestSpy: WeatherRequesterProtocol {
    
    // MARK: - WeatherSpy
    struct WeatherSpy: Decodable {
        
        let weather: [WeatherResultSpy]
        let main: WeatherMainSpy
        let wind: WeatherWindSpy
        let name: String
    }
    
    // MARK: - WeatherResultSpy
    struct WeatherResultSpy: Decodable {
        let id: Int
        let description: String
        let icon: String
    }
    
    // MARK: - WeatherMainSpy
    struct WeatherMainSpy: Decodable {
        let temp: Float
        let temp_min: Float
        let temp_max: Float
    }
    
    // MARK: - WeatherWindSpy
    struct WeatherWindSpy: Decodable {
        let speed: Float
        let deg: Int
    }
    
    func fetchWeather(latitute: Float = 0, longitude: Float = 0) async throws -> Weather {
        let obj: WeatherSpy = JSONHelper.loadJson(fileName: "Weather")
        let weather = obj.weather.first!
        
        let temperature = WeatherTemperature(temp: obj.main.temp,
                                             tempMin: obj.main.temp_min,
                                             tempMax: obj.main.temp_max)
        
        let wind = WeatherWind(speed: obj.wind.speed,
                               deg: obj.wind.deg)
        return Weather(id: weather.id,
                       description: weather.description,
                       icon: weather.icon,
                       temperature: temperature,
                       wind: wind,
                       name: obj.name)
    }
}


