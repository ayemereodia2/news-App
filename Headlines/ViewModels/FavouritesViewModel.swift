//
//  FavouritesViewModel.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation
import UIKit

protocol FavouritesViewModelProtocol: AnyObject {
    func fetchfavourites()
    func item(at indexPath: IndexPath) -> Article
    var articles: [Article] { get }
    func formatDate(dateString: String) -> String?
    func searchTable(query: String)
}

protocol FavouritesViewModelDelegate: AnyObject {
    func reloadTable()
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    private(set) var articles = [Article]()
    
    private(set) lazy var realmDb:ArticleDataModelProtocol = {
        ArticlesInRealm()
    }()
    
    public weak var delegate: FavouritesViewModelDelegate?
    
    init() {
        fetchfavourites()
    }
    
    func fetchfavourites() {
        let modelFavourites = realmDb.all().filter({$0.isFavourite == true })
        articles = modelFavourites.map { Article(model: $0 )}
        delegate?.reloadTable()
    }
    
    func searchTable(query: String) {
        if query.isEmpty {
            fetchfavourites()
        } else {
            articles = articles.map({ $0 }).filter ({
                $0.headline.lowercased().contains(query.lowercased())})
            delegate?.reloadTable()
            
        }
    }
    
    func item(at indexPath: IndexPath) -> Article {
        articles[indexPath.row]
    }
    
    func formatDate(dateString: String) -> String? {
        let cleanDate = dateString
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: "Z", with: "")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        dateFormatterGet.dateStyle = .short
        return cleanDate
    }
}
