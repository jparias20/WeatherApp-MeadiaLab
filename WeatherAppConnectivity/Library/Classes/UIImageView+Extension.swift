import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    public func downloadImage(iconName: String) {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        AF.request("https://openweathermap.org/img/wn/\(iconName)@2x.png").responseImage { response in
            if case .success(let image) = response.result {
                DispatchQueue.main.async { [weak self] in
                    activityIndicator.isHidden = true
                    activityIndicator.removeFromSuperview()
                    self?.image = image
                }
            }
        }
    }
}
