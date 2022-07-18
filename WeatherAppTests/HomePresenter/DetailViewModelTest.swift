import XCTest
import Combine
import WeatherAppConnectivity
@testable import WeatherApp

final class HomePresenterTest: XCTestCase {
        
    func testShowLoadingView() throws {
        let presenter = createPresenter()
        
        let expectation = expectation(description: "Show loading view")
        
        var shown = false
        let cancellables = presenter
            .loadingViewStateObservable
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .shown = state {
                    shown = true
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(shown)
        cancellables.cancel()
    }
    
    func testHiddenLoadingView() throws {
        let presenter = createPresenter()
        presenter.viewDidLoad()
        let expectation = expectation(description: "Hide loading view")
        var hidden = false
        let cancellables = presenter
            .loadingViewStateObservable
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .hidden = state {
                    hidden = true
                    expectation.fulfill()
                }
            }

        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(hidden)
        cancellables.cancel()
    }

    func testWeatherObservable() throws {
        let presenter = createPresenter()
        presenter.viewDidLoad()
        let expectation = expectation(description: "Fetched weather")
        var weatherExpectation: Weather?
        let cancellables = presenter
            .weatherObservable
            .receive(on: DispatchQueue.main)
            .sink { weather in
                guard let weather = weather else { return }
                weatherExpectation = weather
                expectation.fulfill()
            }

        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(weatherExpectation)
        cancellables.cancel()
    }
    
    func createPresenter() -> HomePresenter {
        let requester = WeatherRequestSpy()
        return HomePresenter(interactor: HomeInteractor(connectivityManager: ConnectivityManager(weatherRequester: requester),
                                                        locationManager: LocationManagerSpy()))
    }
}
