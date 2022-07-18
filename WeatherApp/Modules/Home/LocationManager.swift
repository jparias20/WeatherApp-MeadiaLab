import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
    
    var locationObservable: AnyPublisher<CurrentLocation?, Never> { get }
}

struct CurrentLocation {
    
    let latitude: Float
    let longitude: Float
}

final class LocationManager: NSObject {
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    
    private let locationPublisher = CurrentValueSubject<CurrentLocation?, Never>(nil)
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

// MARK: - LocationManagerProtocol
extension LocationManager: LocationManagerProtocol {
    
    var locationObservable: AnyPublisher<CurrentLocation?, Never> {
        locationPublisher.eraseToAnyPublisher()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        validateStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationPublisher.value == nil, let location = locations.last else { return }
        fetchedLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location didFailWithError: ", error.localizedDescription)
    }
}

private extension LocationManager {
    
    func validateStatus() {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            guard let location = locationManager.location else { return }
            fetchedLocation(location: location)
        default:
            locationPublisher.send(nil)
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func fetchedLocation(location: CLLocation) {
        let latitude = Float(location.coordinate.latitude)
        let longitude = Float(location.coordinate.longitude)
        
        locationPublisher.send(CurrentLocation(latitude: latitude, longitude: longitude))
    }
}
