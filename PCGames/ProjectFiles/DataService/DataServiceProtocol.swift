import Foundation

protocol DataServiceProtocol {
    func get(with path: Path, city: String, completion: @escaping (Any?, Error?) -> Void)
}
