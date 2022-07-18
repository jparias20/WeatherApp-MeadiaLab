import Foundation
import Combine
@testable import WeatherApp

final class LocationManagerSpy: LocationManagerProtocol {
    
    private let locationPublisher = CurrentValueSubject<CurrentLocation?, Never>(CurrentLocation(latitude: 0, longitude: 0))
    
    var locationObservable: AnyPublisher<CurrentLocation?, Never> {
        locationPublisher.eraseToAnyPublisher()
    }
    
    func validateStatus() {
        
    }
}
