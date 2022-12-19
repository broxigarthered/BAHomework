////
////  NetworkService.swift
////  BAHomeworkTask
////
////  Created by Nikolay N. Dutskinov on 15.12.22.
////
//
//import Foundation
//
//public protocol NetworkService {
//    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
//
//    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> Void
//}
//
//public protocol Requestable {
//    var endpoint: String { get }
//    var baseUrl: String { get }
////    var isFullPath: Bool { get }
//    var method: HTTPMethodType { get }
//    var headerParameters: [String: String] { get }
//
//    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
//}
//
//extension Requestable {
//   private func url(with config: NetworkConfigurable) throws -> URL {
//        let urlString = baseUrl.appending(endpoint)
//        let urlComponents = URLComponents(string: urlString)
//        guard let url = urlComponents?.url else { throw NetworkError.invalidURL }
//        return url
//    }
//
//    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
//
//        let url = try self.url(with: config)
//        var urlRequest = URLRequest(url: url)
//        var allHeaders: [String: String] = config.headers
//        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
//
////        let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
////        if !bodyParameters.isEmpty {
////            urlRequest.httpBody = encodeBody(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding)
////        }
//        urlRequest.httpMethod = method.rawValue
//        urlRequest.allHTTPHeaderFields = allHeaders
//        return urlRequest
//    }
//}
//

//
//public protocol NetworkConfigurable {
//    var baseURL: URL { get }
//    var headers: [String: String] { get }
//
//    // TODO: Check if needed
//    var queryParameters: [String: String] { get }
//}
//
////public enum NetworkError: Error {
////    case error(statusCode: Int, data: Data?)
////    case notConnected
////    case invalidURL
////    case generic(String)
////}
////
////extension NetworkError: CustomStringConvertible {
////    public var description: String {
////        switch self {
////        case .error(let statusCode, _):
////            return("Fetching data from server failed with status code \(statusCode))")
////        case .notConnected:
////            return("Could not connect to server")
////        case .invalidURL:
////            return ("The url was invalid.")
////        case .generic(let string):
////            return ("An error occured: \(string)")
////        }
////    }
////}
//
//public protocol Cancellable {
//    func cancel()
//}
//
//public protocol NetworkCancellable {
//    func cancel()
//}
//
//class RepositoryTask: Cancellable {
//    var networkTask: NetworkCancellable?
//    var isCancelled: Bool = false
//
//    func cancel() {
//        networkTask?.cancel()
//        isCancelled = true
//    }
//}
