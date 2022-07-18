import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
    
    var locationObservable: AnyPublisher<CurrentLocation?, Never> { get }
    
    func validateStatus()
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
    
    func validateStatus() {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        default:
            locationPublisher.send(nil)
            locationManager.requestAlwaysAuthorization()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationPublisher.value == nil, let currentLocation = locationManager.location else {

#if DEBUG
            let latitude = Float(34.0194704)
            let longitude = Float(-118.4912273)
            locationPublisher.send(CurrentLocation(latitude: latitude, longitude: longitude))
#endif
            
            return
        }
        
        let latitude = Float(currentLocation.coordinate.latitude)
        let longitude = Float(currentLocation.coordinate.longitude)
        
        locationPublisher.send(CurrentLocation(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("location didFailWithError: ", error.localizedDescription)
    }
}
