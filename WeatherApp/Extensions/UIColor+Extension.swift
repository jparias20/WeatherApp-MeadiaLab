import UIKit

extension UIColor {
    
    static var backgroundColor: UIColor {
        UIColor(named: "BackgroundColor") ?? UIColor()
    }
    
    static var loadingBackgroundColor: UIColor {
        UIColor(named: "LoadingBackgroundColor") ?? UIColor()
    }
}
