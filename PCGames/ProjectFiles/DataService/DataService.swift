import Foundation
import Alamofire

class DataService: DataServiceProtocol {
    let baseURL = "https://www.cheapshark.com/api/1.0"
    
    func get(with path: Path, gameID: String, completion: @escaping (Any?, Error?) -> Void) {
        var url = String()
        url = gameID == "" ? "\(self.baseURL)\(path.rawValue)" : "\(self.baseURL)\(path.rawValue)?id=\(gameID)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
            switch (response.result) {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
