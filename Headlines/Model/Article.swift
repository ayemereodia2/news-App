//
//  Article.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation
import RealmSwift

struct Article {
    var headline: String = ""
    var body: String = ""
    var published: String = ""
    var rawImageURL: String?
    var isfavourite: Bool
    
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
}

extension Article {
    init(model: ArticleModel) {
        headline = model.headline
        body = model.body
        published = model.published
        rawImageURL = model.rawImageURL
        isfavourite = model.isFavourite
    }
}

class ArticleModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var headline: String
    @Persisted var body: String
    @Persisted var published: String
    @Persisted var rawImageURL: String?
    @Persisted var isFavourite: Bool
}

extension ArticleModel {
    convenience init(model: Article) {
        self.init()
        headline = model.headline
        body = model.body
        published = model.published
        rawImageURL = model.rawImageURL
        isFavourite = model.isfavourite
    }
}

extension Article {
    init?(dictionary: [String : Any]) {
        headline = dictionary["webTitle"] as? String ?? ""
        
        if let publicationDate = dictionary["webPublicationDate"] as? String {
            published = publicationDate
        }
        
        isfavourite = false

        guard let fields = dictionary["fields"] as? [String: String] else {
            return
        }
        
        body = fields["body"] ?? ""
        
        rawImageURL = fields["main"]?.url?.absoluteString ?? ""
    }
}

