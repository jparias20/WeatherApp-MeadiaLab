import Foundation

extension Float {
    
    func formatTemperatureFromKelvinToCelsius() -> String {
        let celsius = self - 273.15
        let formatted = String(format: "%.0f", celsius)
        return "\(formatted)°"
    }
}
