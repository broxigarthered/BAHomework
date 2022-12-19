//
//  UserDetailsViewModel.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import Foundation

protocol UserDetailsViewModelInput {
    func viewDidLoad()
}

protocol UserDetailsViewModelOutput {
    var userDetail: Observable<UserDetailsDTO?> { get }
    var error: Observable<String> { get }
}

protocol UserDetailsViewModelInputOutput: UserDetailsViewModelInput, UserDetailsViewModelOutput { }


final class UserDetailsViewModel: UserDetailsViewModelInputOutput {

    let userDetail: Observable<UserDetailsDTO?> = Observable(.none)
    let error: Observable<String> = Observable("")
    
    var output: PostsListViewModelOutput?
    private let userDetailsRepo: UserDetailsRepository
    private let decoder: JSONDecoder
    
    init (userDetailsRepo: UserDetailsRepository, decoder: JSONDecoder) {
        // todo: networker protocol &
        self.userDetailsRepo = userDetailsRepo
        self.decoder = decoder
    }
    
}

// MARK: - PostsListViewModelInput
extension UserDetailsViewModel {
    func viewDidLoad() {
        // TODO: Call the service
        userDetailsRepo.getUserDetails(id: 1, decoder: decoder) { result in
            switch result {
            case .success(let response):
                self.userDetail.value = response
                print(response)
            case .failure(_):
                print("kor")
            }
        }
    }
}
