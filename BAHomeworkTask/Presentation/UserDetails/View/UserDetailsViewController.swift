//
//  UserDetailsViewController.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import UIKit

class UserDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Create details screen
        
        let session = URLSession.shared
        let networker = Networker(session: session)
        let defaultPostsRepo = DefaultUserDetailsRepository(networker: networker)
        let decoder = JSONDecoder()
        let viewModel = UserDetailsViewModel(userDetailsRepo: defaultPostsRepo, decoder: decoder)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: PostsListViewModel) {
        
        viewModel.posts.observe(on: self) { _ in
// TODO: refresh the view
//            print(ud)
        }
    }
    



}
