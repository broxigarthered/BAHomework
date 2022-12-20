//
//  AppDIContainer.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 20.12.22.
//

import Foundation

final class AppDependencyContainer {
    
    private lazy var session = URLSession.shared
    lazy var networker = Networker(session: session)
    lazy var postsRepository = DefaultPostsRepository(networker: networker)
    lazy var usersRepository = DefaultUserDetailsRepository(networker: networker)
    lazy var decoder = JSONDecoder()
    lazy var dispatchGroup = DispatchGroup()
    
    func makePostsDependencyContainer() -> PostsDependencyContainer {
        let dependencies = PostsDependencyContainer.Dependencies(postsRepository: postsRepository,
                                                                 userDetailsRepository: usersRepository,
                                                                 decoder: decoder,
                                                                 dispatchGroup: dispatchGroup)
        return PostsDependencyContainer(dependencies: dependencies)
    }
}
