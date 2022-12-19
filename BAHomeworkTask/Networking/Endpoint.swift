//
//  Endpoint.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 19.12.22.
//

import Foundation

public class Endpoint {
    public let endpoint: String
    public let baseUrl: String
    public let method: HTTPMethodType
    public let headerParameters: [String: String]
    public var responseDecoder: ResponseDecoder
    public let timeoutInterval: Double
    
    init(endpoint: String,
         baseUrl: String,
         method: HTTPMethodType,
         headerParameters: [String: String] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder(),
         timeoutInterval: Double = 2.0) {
        self.endpoint = endpoint
        self.baseUrl = baseUrl
        self.method = method
        self.headerParameters = headerParameters
        self.responseDecoder = responseDecoder
        self.timeoutInterval = timeoutInterval
    }
}
