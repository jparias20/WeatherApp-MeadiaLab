import UIKit
import Combine
import WeatherAppConnectivity

protocol HomePresenterProtocol {
    
    var weatherObservable: AnyPublisher<Weather?, Never> { get }
    var loadingViewStateObservable: AnyPublisher<LoadingView.State, Never> { get }
    
    func show() -> UINavigationController
    func viewDidLoad()
}

final class HomePresenter {
    
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    private let loadingViewStatePublisher = CurrentValueSubject<LoadingView.State, Never>(.shown)
    private let weatherPublisher = CurrentValueSubject<Weather?, Never>(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: HomeInteractorProtocol = HomeInteractor(), router: HomeRouterProtocol = HomeRouter()) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    var loadingViewStateObservable: AnyPublisher<LoadingView.State, Never> {
        loadingViewStatePublisher.eraseToAnyPublisher()
    }
    
    var weatherObservable: AnyPublisher<Weather?, Never> {
        weatherPublisher.eraseToAnyPublisher()
    }
    
    func show() -> UINavigationController {
        router.show(presenter: self)
    }
    
    func viewDidLoad() {
        bind()
        interactor.viewDidLoad()
    }
}

private extension HomePresenter {
    
    func bind() {
        interactor
            .weatherObservable
            .sink { [weak self] weather in
                self?.weatherPublisher.send(weather)
                self?.loadingViewStatePublisher.send(weather == nil ? .shown : .hidden)
            }
            .store(in: &cancellables)
    }
}
