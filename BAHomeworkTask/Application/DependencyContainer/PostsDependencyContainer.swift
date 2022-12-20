//
//  PostsDependencyContainer.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 20.12.22.
//

import Foundation

final class PostsDependencyContainer {
    struct Dependencies {
        let postsRepository: PostsRepository
        let userDetailsRepository: UserDetailsRepository
        let decoder: JSONDecoder
        let dispatchGroup: DispatchGroup
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMoviesListViewController() -> PostsListViewController {
        let model = makePostsListViewModel()
        return PostsListViewController.create(with: model)
    }
    
    func makePostsListViewModel() -> PostsListViewModel {
        
        return PostsListViewModel(postsRepo: dependencies.postsRepository,
                           userDetailsRepo: dependencies.userDetailsRepository,
                           decoder: dependencies.decoder,
                           dispatchGroup: dependencies.dispatchGroup)
    }
}
