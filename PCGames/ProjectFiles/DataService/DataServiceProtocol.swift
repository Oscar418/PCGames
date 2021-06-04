import Foundation

protocol DataServiceProtocol {
    func get(with path: Path, gameID: String, completion: @escaping (Any?, Error?) -> Void)
}
