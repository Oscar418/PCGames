import Foundation
import UIKit

extension UILabel {
    func addStrikeThrough(text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "R\(text)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }
}
