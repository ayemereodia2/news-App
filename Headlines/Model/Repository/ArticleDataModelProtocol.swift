//
//  ArticleDataModelProtocol.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation

protocol ArticleDataModelProtocol {
    func create(eventModel: ArticleModel, completionHandler: @escaping (Bool)->Void)
    func all() -> [ArticleModel]
    func delete(eventModel: ArticleModel, completionHandler: @escaping (Bool)->Void)
    func setFavorite(eventModel: ArticleModel)
    func saveAll(eventModel: [ArticleModel]) 
}
