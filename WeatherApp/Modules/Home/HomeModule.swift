import UIKit

final class HomeModule {
    
    private let presenter: HomePresenter
    
    init() {
        self.presenter = HomePresenter()
    }
}

extension HomeModule {
    
    func show() -> UINavigationController {
        return presenter.show()
    }
}
