//
//  Networker.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 16.12.22.
//

import Foundation


class RequestWrapper {
    let apiResponseClass: DeserializableModel.Type
    init(apiResponseClass: DeserializableModel.Type) {
        self.apiResponseClass = apiResponseClass
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol{}

protocol  URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        let task = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
        return task as URLSessionDataTaskProtocol
    }
}


public protocol DataTransferService {
    func request(endpoint: Endpoint,
                 completion: @escaping  (_ dataResponse: Data?, _ error: NetworkError?, _ response: HTTPURLResponse?) -> Void)
}

final class Networker: DataTransferService {
    
    func request(endpoint: Endpoint,
                 completion: @escaping (_ dataResponse: Data?, _ error: NetworkError?, _ response: HTTPURLResponse?) -> Void) {
        
        let baseURL = URL(string: endpoint.baseUrl)
        
        if let relativeURL = URL(string: endpoint.endpoint, relativeTo: baseURL) {
            let urlRequest = urlRequestConfiguration(url: relativeURL, timeInterval: endpoint.timeoutInterval, methodType: endpoint.method, headers: endpoint.headerParameters)
            
            
            let task = session.dataTask(with: urlRequest) { (responseData, response, responseError) in
                var result: Data?
                var httpResponse: HTTPURLResponse?
                var networkError: NetworkError?
                
                defer {
                    completion(result, networkError, httpResponse)
                }
                if let error = responseError {
                    networkError = .generic("TASK ERROR: " + error.localizedDescription + "\n")
                }
                if let data = responseData {
                    result = data
                }
                if let httpURLResponse = response as? HTTPURLResponse {
                    httpResponse = httpURLResponse
                }
            }
            
            task.resume()
        } else {
            completion(nil, .notConnected, nil)
        }
    }
    
    
    
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    public lazy var headers: [String: String] = {
        return  ["Content-Type": "application/json"]
    }()
    
    private let baseString: String = "https://jsonplaceholder.typicode.com/"
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func urlRequestConfiguration(url: URL,
                                 timeInterval: Double,
                                 methodType: HTTPMethodType? = nil,
                                 headers: [String: String]? ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = timeInterval
        urlRequest.httpMethod = methodType?.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
}

public enum HTTPMethodType: String {
    case get = "GET"
}
