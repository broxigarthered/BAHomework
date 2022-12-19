//
//  PostsRepository.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import Foundation

protocol PostsRepository {
    func getPosts(decoder: JSONDecoder,
                  completion: @escaping (Result<[PostDTO], NetworkError>) -> Void)
}
