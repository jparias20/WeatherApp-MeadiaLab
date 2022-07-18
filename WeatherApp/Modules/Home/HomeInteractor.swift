import Foundation
import WeatherAppConnectivity
import Combine

protocol HomeInteractorProtocol {
    
    var weatherObservable: AnyPublisher<Weather?, Never> { get }
    
    func viewDidLoad()
}

final class HomeInteractor {
    
    private let connectivityManager: ConnectivityManagerProtocol
    private let locationManager: LocationManagerProtocol
    
    private let weatherPublisher = CurrentValueSubject<Weather?, Never>(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(connectivityManager: ConnectivityManagerProtocol = ConnectivityManager(),
         locationManager: LocationManagerProtocol = LocationManager()) {
        
        self.connectivityManager = connectivityManager
        self.locationManager = locationManager
        
        bind()
    }
}

private extension HomeInteractor {
    
    func bind() {
        locationManager
            .locationObservable
            .sink { [weak self] location in
                
                guard let location = location else { return }
                
                self?.fetchWeather(location: location)
            }
            .store(in: &cancellables)
        
    }
    
    func fetchWeather(location: CurrentLocation) {
        Task {
            do {
                let weather = try await connectivityManager.fetchWeather(latitute: location.latitude,
                                                                         longitude: location.longitude)
                weatherPublisher.send(weather)
            } catch {
                print("Error fetching weather: ", error.localizedDescription)
            }
        }
        return
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    
    var weatherObservable: AnyPublisher<Weather?, Never> {
        weatherPublisher.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        locationManager.validateStatus()
    }
}


