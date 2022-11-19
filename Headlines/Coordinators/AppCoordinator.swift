//
//  AppCoordinator.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController()
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        startMainFlow()
    }
    
    private func startMainFlow() {
        let pagerCoordinator = ContainerPagerCoordinator(navigationcontroller: self.rootViewController)
        pagerCoordinator.delegate = self
        store(coordinator: pagerCoordinator)
        pagerCoordinator.start()
    }
    
//    private func startMainFlow2() {
//        let mainCoordinator = MainViewCoordinator(navigationcontroller: self.rootViewController)
//        mainCoordinator.delegate = self
//        store(coordinator: mainCoordinator)
//        mainCoordinator.start()
//    }
}

//extension AppCoordinator: MainCoordinatorDelegate {
//    func didFinishMainViewCordinator(coordinator: Coordinator) {
//        self.free(coordinator: coordinator)
//    }
//}

extension AppCoordinator: ContainerPagerCoordinatorDelegate {
    func didFinishWithPagerViewCordinator(coordinator: Coordinator) {
        self.free(coordinator: coordinator)
    }
}
