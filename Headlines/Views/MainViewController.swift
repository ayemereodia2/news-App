//
//  ViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    private var likedArticle:Article!
    @IBOutlet weak var favListButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var toggle = false
    private let viewModel:ArticleViewModel
    private let index: Int
    
    init(viewModel: ArticleViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadArticlesToView(with: index)
    }
    

    @IBAction func favouritesButtonPressed() {
        viewModel.onTapFavourites()
    }
    
    @IBAction func starButtonPressed() {
        viewModel.onLikeArticle(article: likedArticle, index: index)
        configureButton(!favButton.isSelected)
    }
    
    func toggleViewModes() {
        toggle = !toggle
        if toggle {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        
    }
}


extension MainViewController: ArticleLoadedDelegate {
     func configureButton(_ status: Bool) {
        if status {
            favButton.isSelected = true
            favButton.setBackgroundImage(UIImage(named: "favourite-on"), for: .selected)
        } else {
            favButton.setBackgroundImage(UIImage(named: "favourite-off"), for: .normal)
            favButton.isSelected = false
        }
    }
    
    func onLikedButtonTap(status: Bool) {
        configureButton(status)
    }
    
    func showFirstArticle(article: Article) {
        likedArticle = article
        onLikedButtonTap(status: likedArticle.isfavourite)
        headlineLabel.text = article.headline
        bodyLabel.text = article.body
        imageView.sd_setImage(with: article.imageURL)
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        favButton.isHidden = false
        favListButton.isHidden = false
    }
    
    func hideLoadingView() {
        activityIndicator.isHidden = true
        favButton.isHidden = false
        favListButton.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func showLoadingView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}
