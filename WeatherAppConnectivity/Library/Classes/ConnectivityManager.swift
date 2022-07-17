import Foundation
import Alamofire

// MARK: - Protocol
public protocol ConnectivityManagerProtocol {
    
    func fetchWeather(latitute: Float, longitude: Float) async throws -> Weather
}

// MARK: - Manager
public class ConnectivityManager {
    
    private let weatherRequester: WeatherRequesterProtocol
    
    public init(weatherRequester: WeatherRequesterProtocol = WeatherRequesterAlamofire()) {
        self.weatherRequester = weatherRequester
    }
}

// MARK: - ConnectivityManagerProtocol
extension ConnectivityManager: ConnectivityManagerProtocol {
    
    public func fetchWeather(latitute: Float, longitude: Float) async throws -> Weather {
        return try await weatherRequester.fetchWeather(latitute: latitute, longitude: longitude)
    }
}
