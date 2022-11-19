//
//  ContainerPagerViewController.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/04.
//  Copyright © 2022 Example. All rights reserved.
//

import UIKit

class ContainerPagerViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()
    
    var activityView:UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .gray)
        return activityView
    }()
    
    private var indexMax = 0
    private var pageCount = 0
    
    private let viewModel:ArticleViewModel
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        view.backgroundColor = .white
        
        addChild(pageController)
        view.addSubview(pageController.view)
        
        setupPagerLayout()
        
        viewModel.delegate = self
        viewModel.intialLoad { }
    }
    
    func loadPageCount() {
        pageCount = viewModel.pageCount
    }
    
    fileprivate func setupPagerLayout() {
        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
    }
    
    private func GenerateArticlePage(with indexTag: Int) -> MainViewController? {
        // Create a new view controller and pass suitable data.
        let vc = MainViewController(viewModel: viewModel, index: indexTag)
        return vc
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        indexMax -= 1
        
        if indexMax >= 0 {
            return GenerateArticlePage(with: indexMax)
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        indexMax += 1
        if indexMax <= pageCount {
            return GenerateArticlePage(with: indexMax)
        } else {
            return nil
        }
    }
}


extension ContainerPagerViewController: ArticleLoadedDelegate {
    func hideLoadingView() {
        hideActivityIndicator()
        loadPageCount()
        pageController.setViewControllers([GenerateArticlePage(with: indexMax)!], direction: .forward, animated: false)
    }

    func showLoadingView() {
        showActivityIndicator()
    }
    
    func showFirstArticle(article: Article) {}
    
    func showActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    func hideActivityIndicator(){
        activityView.stopAnimating()
    }
}
