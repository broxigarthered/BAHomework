//
//  DefaultPostsRepository.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import Foundation

final class DefaultPostsRepository: PostsRepository {
    
        private let networker: DataTransferService
    
        init(networker: DataTransferService) {
            self.networker = networker
        }
    
    
    func getPosts(decoder: JSONDecoder, completion: @escaping(Result<[PostDTO], NetworkError>) -> Void) {

        let endpoint = APIEndpoints.getPosts()
        
        networker.request(endpoint: endpoint) { dataResponse, error, response in
            if let data = dataResponse,
               let response = response {
                if response.statusCode == 200 {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let posts = try decoder.decode([PostDTO].self, from: data)
                        completion(.success(posts))
                    } catch {
                        let networkError = NetworkError.invalidData
                        completion(.failure(networkError))
                    }
                } else {
                    if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
