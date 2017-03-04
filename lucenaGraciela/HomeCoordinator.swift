//
//  HomeCoordinator.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    // MARK: - Initializers
    init() {
        rootViewController = UINavigationController()
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        let reddisListVM = RedditListAPIViewModel()
        let reddisListVC = RedditListViewController(viewModel: reddisListVM)
        navigationController.setViewControllers([reddisListVC], animated: true)
    }
}
