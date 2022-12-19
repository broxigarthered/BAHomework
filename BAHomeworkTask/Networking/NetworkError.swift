//
//  NetworkError.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 16.12.22.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case invalidURL
    case generic(String)
    case invalidData
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .error(let statusCode, _):
            return("Fetching data from server failed with status code \(statusCode))")
        case .notConnected:
            return("Could not connect to server. No internet connection.")
        case .invalidURL:
            return ("The url was invalid.")
        case .generic(let string):
            return ("An error occured: \(string)")
        case .invalidData:
            return "Couldn't parse data."
        }
    }
}
