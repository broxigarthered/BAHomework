//
//  UserDetailsRepository.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import Foundation

protocol UserDetailsRepository {
    func getUserDetails(id: Int,
                        decoder: JSONDecoder,
                        completion: @escaping (Result<UserDetailsDTO, NetworkError>) -> Void)
}
