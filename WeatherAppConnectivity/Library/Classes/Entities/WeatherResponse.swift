import Foundation

// MARK: - Weather
public struct Weather {
    
    public let id: Int
    public let description: String
    public let icon: String
    
    public let temperature: WeatherTemperature
    public let wind: WeatherWind
    public let name: String
    
    init(weather: WeatherAlamofire,
         main: WeatherMainAlamorife,
         wind: WeatherWindAlamofire,
         name: String) {
        
        self.id = weather.id
        self.description = weather.description
        self.icon = weather.icon
        
        self.temperature = WeatherTemperature(temperature: main)
        self.wind = WeatherWind(wind: wind)
        
        self.name = name
    }
    
    public init(id: Int, description: String, icon: String, temperature: WeatherTemperature, wind: WeatherWind, name: String) {
        self.id = id
        self.description = description
        self.icon = icon
        self.temperature = temperature
        self.wind = wind
        self.name = name
    }
}

// MARK: - WeatherTemperature
public struct WeatherTemperature {
    
    public let temp: Float
    public let tempMin: Float
    public let tempMax: Float
    
    init(temperature: WeatherMainAlamorife) {
        self.temp = temperature.temp
        self.tempMin = temperature.temp_min
        self.tempMax = temperature.temp_max
    }
    
    public init(temp: Float, tempMin: Float, tempMax: Float) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
    }
}

// MARK: - WeatherWindAlamofire
public struct WeatherWind {
    
    public let speed: Float
    public let deg: Int
    
    init(wind: WeatherWindAlamofire) {
        self.speed = wind.speed
        self.deg = wind.deg
    }
    
    public init(speed: Float, deg: Int) {
        self.speed = speed
        self.deg = deg
    }
}
