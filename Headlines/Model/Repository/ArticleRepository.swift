//
//  ArticleRepository.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getAllArticles() -> [Article]
}

class ArticleRepository: ArticleRepositoryProtocol {
    
    private let realmDb: ArticleDataModelProtocol
    
    init(realmDb: ArticleDataModelProtocol) {
        self.realmDb = realmDb
    }
    
    func getAllArticles() -> [Article] {
        realmDb.all().map {Article.init(model: $0)}
    }
}
