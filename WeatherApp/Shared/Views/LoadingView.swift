import UIKit

final class LoadingView: BaseView {
    
    enum State {
        case shown
        case hidden
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    init(in parentView: UIView) {
        super.init()
        backgroundColor = .loadingBackgroundColor
        
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor),
            leftAnchor.constraint(equalTo: parentView.leftAnchor),
            rightAnchor.constraint(equalTo: parentView.rightAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func hide() {
        isHidden = true
        removeFromSuperview()
    }
}
