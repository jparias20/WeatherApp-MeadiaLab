import UIKit

extension UIFont {
    
    @nonobjc class var description: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    @nonobjc class var title: UIFont {
        return UIFont.systemFont(ofSize: 42, weight: .semibold)
    }
}
