//
//  ArticlesInRealm.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation
import RealmSwift

class ArticlesInRealm: ArticleDataModelProtocol {
    private let realm: Realm = {
        try! Realm()
    }()
    
    func create(eventModel: ArticleModel, completionHandler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.add(eventModel)
                completionHandler(true)
            }
        } catch {
            completionHandler(false)
        }
    }
    
    func saveAll(eventModel: [ArticleModel]) {
        try? self.realm.write { [weak self] in
            self?.realm.add(eventModel)
        }
    }
    
    func all() -> [ArticleModel] {
        let models = realm.objects(ArticleModel.self)
        return models.map { $0 }
    }
    
    
    func delete(eventModel: ArticleModel, completionHandler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.delete(eventModel)
                completionHandler(true)
            }
        } catch {
            completionHandler(false)
        }
    }
    
    func setFavorite(eventModel: ArticleModel) {
        var tempStatus = false
        
        guard let editedModel = realm.objects(ArticleModel.self).first(where: {$0.headline == eventModel.headline }) else {
            return
        }
        
        if !editedModel.isFavourite {
            tempStatus = true
        }
        
        try? realm.write {
            editedModel.isFavourite = tempStatus
        }
    }
}
