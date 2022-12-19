//
//  PostsListViewModel.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 15.12.22.
//

import Foundation

protocol PostsListViewModelInput {
    func viewDidLoad()
    func didRefresh()
}

protocol PostsListViewModelOutput {
    var posts: Observable<[PostViewModel]> { get }
    var error: Observable<String> { get }
}

protocol PostsListViewModelInputOutput: PostsListViewModelInput, PostsListViewModelOutput { }


final class PostsListViewModel: PostsListViewModelInputOutput {
    
    let posts: Observable<[PostViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    
    var output: PostsListViewModelOutput?
    private let postsRepo: PostsRepository
    private let userDetailsRepo: UserDetailsRepository
    private let decoder: JSONDecoder
    private let dispatchGroup: DispatchGroup
    
    init (postsRepo: PostsRepository, userDetailsRepo: UserDetailsRepository, decoder: JSONDecoder, dispatchGroup: DispatchGroup) {
        self.postsRepo = postsRepo
        self.decoder = decoder
        self.userDetailsRepo = userDetailsRepo
        self.dispatchGroup = dispatchGroup
    }
}

extension PostsListViewModel {
    
    private func getPosts() {
        postsRepo.getPosts(decoder: decoder) { result in
            switch result {
            case .success(let posts):
                
                var postsViewModel: [PostViewModel] = []
                
                for post in posts {
                    self.dispatchGroup.enter()
                    self.getUserDetails(postId: post.userId, completion: { userDetail in
                        postsViewModel.append(PostViewModel(name: userDetail.name, postTitle: post.title))
                        self.dispatchGroup.leave()
                    })
                }
                
                self.dispatchGroup.notify(queue: .main) {
                    self.posts.value = postsViewModel
                }
            case .failure(let networkError):
                self.error.value = networkError.description
            }
        }
    }
    
    private func getUserDetails(postId: Int, completion: @escaping (UserDetailsDTO) -> Void) {
        self.userDetailsRepo.getUserDetails(id: postId, decoder: self.decoder) { result in
            switch result {
            case .success(let userDetails):
                completion(userDetails)
            case .failure(let networkError):
                self.error.value = networkError.description
                break
            }
        }
    }
}

// MARK: - PostsListViewModelInput
extension PostsListViewModel {
    func viewDidLoad() {
        getPosts()
    }
    
    func didRefresh() {
        getPosts()
    }
}

// MARK: - View's model
struct PostViewModel {
    let name: String
    let postTitle: String
}
