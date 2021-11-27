import Foundation
import Alamofire

public enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

struct GoogleSuggestParameters: Encodable {
    let output: String
    let q: String

}
public class GoogleSuggest {
    public init() {}
    public func getSuggestionsBy(query: String, completion: @escaping (Result<[String], NetworkError>) -> Void) -> Void {
        AF.request("https://www.google.com/complete/search",
                   method: .get,
                   parameters: GoogleSuggestParameters(output: "firefox", q: query)).response { response in
            switch response.result {
            case .success(let data):
                
                guard let s = String(data: data!, encoding: .shiftJIS),
                      let data = s.data(using: .utf8),
                      let jsonRoot = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any],
                      let jsonSuggestions = jsonRoot[1] as? [String] else {
                    return completion(.failure(.decodingError))
                }
                return completion(.success(jsonSuggestions))
            case .failure:
                return completion(.failure(.noData))
            }
        }
    }
}
