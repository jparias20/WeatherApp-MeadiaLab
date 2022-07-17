import UIKit
import WeatherAppConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ConnectivityManager()
        
        Task {
            do {
                let weather = try await manager.fetchWeather(latitute: 34.0194704, longitude: -118.4912273)
                print("Fetched weather: ", weather)
                imageView.downloadImage(iconName: weather.icon)
            } catch {
                print("Error fetching weather: ", error.localizedDescription)
            }
        }
        
    }


}

