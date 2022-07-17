import Alamofire

struct AlamofireRequest {
    
    static func request<T: Decodable>(urlString: String,
                                      method: HTTPMethod = .get,
                                      parameters: Parameters? = nil,
                                      headers: HTTPHeaders? = nil) async throws -> T {
                
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlString,
                       method: method,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                    break
                }
            }
        }
    }
}
