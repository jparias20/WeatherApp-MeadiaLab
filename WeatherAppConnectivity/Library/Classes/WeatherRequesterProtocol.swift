import Foundation

// MARK: - Protocol
public protocol WeatherRequesterProtocol {
    
    func fetchWeather(latitute: Float, longitude: Float) async throws -> Weather
}
