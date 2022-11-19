//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation

protocol ArticleLoadedDelegate: AnyObject {
    func hideLoadingView()
    func showLoadingView()
    func showFirstArticle(article: Article)
}

protocol MainViewCoordinatorDelegate: AnyObject {
    func didTapFavourites()
}

class ArticleViewModel {
    private(set) lazy var realmDb:ArticleDataModelProtocol = {
        ArticlesInRealm()
    }()
    
    private(set) lazy var pageCount: Int = {
        realmDb.all().count
    }()
    
    private let api: ServiceApiProtocol
    public weak var delegate: ArticleLoadedDelegate?
    public weak var coordinatorDelegate: MainViewCoordinatorDelegate?
    
    init(api: ServiceApiProtocol) {
        self.api = api
    }
    
    func intialLoad(completion: @escaping ()->Void) {
        self.delegate?.showLoadingView()
        api.loadAllFromApi { [weak self] error in
            guard let _ = error else {
                self?.delegate?.hideLoadingView()
                return
            }
        }
        
    }
    
    func checkifArticlesExist() -> Bool {
        return realmDb.all().isEmpty
    }
    
    func loadArticlesToMemory() -> [Article] {
        let loadArticles = realmDb.all()
        return loadArticles.map { Article(headline: $0.headline,
                                          body: $0.body.strippingTags ,
                                          published: $0.published,
                                          rawImageURL: $0.rawImageURL,
                                          isfavourite: $0.isFavourite) }
    }
    
    func loadArticlesToView(with index: Int) {
        let articles = loadArticlesToMemory()
        if articles.isEmpty {
            getAllArticles()
        } else {
            self.delegate?.showFirstArticle(article: articles[index])
        }
    }
    
    func fetchFirstArticle() {
        getOneArticle()
    }
    
    private func getAllArticles() {
//        if !checkifArticlesExist() {
//            loadArticlesToView(with: 0)
//            return
//        }

        delegate?.showLoadingView()
        api.loadAllFromApi { [weak self] error in
            guard let _ = error else {
                self?.delegate?.hideLoadingView()
                self?.getOneArticle()
                return
            }
            
            self?.delegate?.hideLoadingView()
        }
    }
    
    private func getOneArticle() {
        DispatchQueue.main.async {
            guard let article = self.realmDb.all().first else { return }
            let viewArticle = Article(headline: article.headline,
                                      body: article.body.strippingTags ,
                                      published: article.published, rawImageURL: article.rawImageURL, isfavourite: article.isFavourite)
            
            self.delegate?.showFirstArticle(article: viewArticle)
        }
    }
    
    func onTapFavourites() {
        coordinatorDelegate?.didTapFavourites()
    }
    
    func onLikeArticle(article: Article, index: Int) {
        let likedModel = ArticleModel(model: article)
        realmDb.setFavorite(eventModel: likedModel)
    }
}
