import Foundation
import Alamofire

// MARK: - Manager
final public class WeatherRequesterAlamofire {
    
    private var urlString: String {
        "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=d4277b87ee5c71a468ec0c3dc311a724"
    }
    
    public init() { }
}

// MARK: - WeatherRequesterProtocol
extension WeatherRequesterAlamofire: WeatherRequesterProtocol {
    
    public func fetchWeather(latitute: Float, longitude: Float) async throws -> Weather {
                
        let url = String(format: urlString, "\(latitute)", "\(longitude)")
        let response: WeatherResultAlamofire = try await AlamofireRequest.request(urlString: url)
        
        guard let weather = response.weather.first else { throw ErrorAPI.noData }
        let obj = Weather(weather: weather,
                          main: response.main,
                          wind: response.wind,
                          name: response.name)
        return obj
    }
}
