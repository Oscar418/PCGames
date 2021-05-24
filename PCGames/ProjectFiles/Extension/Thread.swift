import UIKit

extension UIViewController {
    func onMainThread(block:@escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
}
