//
//  APIEndpoints.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 19.12.22.
//

import Foundation
struct APIEndpoints {
    static func getPosts() -> Endpoint {
        return Endpoint(endpoint: "posts",
                        baseUrl: "https://jsonplaceholder.typicode.com/",
                        method: .get)
    }
    
    static func getUserDetails(for userId: Int) -> Endpoint {
        return Endpoint(endpoint: "users/\(userId)",
                        baseUrl: "https://jsonplaceholder.typicode.com/",
                        method: .get)
    }
}
