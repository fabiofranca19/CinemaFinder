import Foundation

final class ServiceApi: Servicing {
    func execute<E: Decodable>(
        _ endpoint: ApiEndpoint,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        do {
            let request = try makeRequest(for: endpoint)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "DataError", code: -2, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(E.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}

private extension ServiceApi {
    func makeRequest(for endpoint: ApiEndpoint) throws -> URLRequest {
        guard var components = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true) else {
            throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
        }
        
        if let queryParameters = endpoint.queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw NSError(domain: "InvalidURLComponents", code: -1, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request = addHeaders(endpoint.headers, request)
        
        if let bodyParameters = endpoint.bodyParameters {
            request = try addBody(bodyParameters, request)
        }
        
        return request
    }
    
    func addHeaders(_ headers: [String: String]?,_ request: URLRequest) -> URLRequest {
        var modifiedRequest = request
        headers?.forEach { modifiedRequest.setValue($1, forHTTPHeaderField: $0) }
        return modifiedRequest
    }

    func addBody(_ parameters: [String: Any],_ request: URLRequest) throws -> URLRequest {
        var modifiedRequest = request
        modifiedRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        return modifiedRequest
    }
}
