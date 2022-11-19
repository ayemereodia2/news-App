//
//  ContainerPagerCoordinator.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/04.
//  Copyright © 2022 Example. All rights reserved.
//

import UIKit

protocol ContainerPagerCoordinatorDelegate: AnyObject {
    func didFinishWithPagerViewCordinator(coordinator: Coordinator)
}

protocol ContainerPagerDelegate: AnyObject {}

class ContainerPagerCoordinator: BaseCoordinator {
    private let navigationcontroller: UINavigationController
    public weak var delegate: ContainerPagerCoordinatorDelegate?
    
    init(navigationcontroller:UINavigationController) {
        self.navigationcontroller = navigationcontroller
    }
    
    override func start() {
        if let controller = self.containerViewController {
            navigationcontroller.navigationBar.isHidden = true
            self.navigationcontroller.setViewControllers([controller], animated: false)
        }
    }
    
    lazy var containerViewController: ContainerPagerViewController? = {
        let api = AlamofireApi()
        let viewModel = ArticleViewModel(api: api)
        viewModel.coordinatorDelegate = self
        let controller =  ContainerPagerViewController(viewModel: viewModel)
        return controller
    }()
    
    var favouritesViewController: FavouritesViewController? {
        let controller = FavouritesViewController.initFromNib()
        controller.viewModel = FavouritesViewModel()
        return controller
    }
}

extension ContainerPagerCoordinator: MainViewCoordinatorDelegate {
    func didTapFavourites() {
        navigationcontroller.navigationBar.isHidden = false
        if let controller = self.favouritesViewController {
            self.navigationcontroller.present(controller, animated: true)
       }
    }
}
