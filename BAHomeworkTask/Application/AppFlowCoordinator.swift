//
//  AppFlowCoordinator.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 20.12.22.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDependencyContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDependencyContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let postsDependencyContainer = appDIContainer.makePostsDependencyContainer()
        let vc = postsDependencyContainer.makeMoviesListViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
