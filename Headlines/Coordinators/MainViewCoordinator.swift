//
//  MainViewCoordinator.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didFinishMainViewCordinator(coordinator: Coordinator)
}

//class MainViewCoordinator: BaseCoordinator {
//    private let navigationcontroller: UINavigationController
//    public weak var delegate: MainCoordinatorDelegate?
//    
//    init(navigationcontroller:UINavigationController) {
//        self.navigationcontroller = navigationcontroller
//    }
//    
//    override func start() {
//        if let controller = self.mainViewController {
//            navigationcontroller.navigationBar.isHidden = true
//            self.navigationcontroller.setViewControllers([controller], animated: false)
//        }
//    }
//    
//    lazy var mainViewController: MainViewController? = {
////        let api = AlamofireApi()
////        let viewModel = ArticleViewModel(api: api)
////        viewModel.coordinatorDelegate = self
//        let controller =  MainViewController.initFromNib()
//        return controller
//    }()
//    
//    lazy var favouritesViewController: FavouritesViewController? = {
//        let controller = FavouritesViewController.initFromNib()
//        controller.viewModel = FavouritesViewModel()
//        return controller
//    }()
//}

//extension MainViewCoordinator: MainViewCoordinatorDelegate {
//    func didTapFavourites() {
//        navigationcontroller.navigationBar.isHidden = false
//        if let controller = self.favouritesViewController {
//            self.navigationcontroller.present(controller, animated: true)
//        }
//    }
//}

