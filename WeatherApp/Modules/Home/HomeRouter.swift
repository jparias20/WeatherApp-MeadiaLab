import UIKit

protocol HomeRouterProtocol {
    
    func show(presenter: HomePresenterProtocol) -> UINavigationController
}

final class HomeRouter {
    
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    
    func show(presenter: HomePresenterProtocol) -> UINavigationController {
        let viewController = HomeViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
