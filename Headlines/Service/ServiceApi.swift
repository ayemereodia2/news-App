//
//  ServiceApi.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

protocol ServiceApiProtocol {
    func loadAllFromApi(completion: @escaping (ServiceError?) -> Void)
}

class AlamofireApi: ServiceApiProtocol {
    
    
    private(set) lazy var realmDb:ArticleDataModelProtocol = {
        ArticlesInRealm()
    }()
    
    
    func loadAllFromApi(completion: @escaping (ServiceError?) -> Void) {
        AF.request(NetworkConstants.url, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
                
            case .success(let value):
                guard let json = value as? [String: Any],
                      let data = json["response"] as? [String: Any],
                      let results = data["results"] as? [[String: Any]] else {
                          
                          completion(ServiceError.parsingError)
                          return
                      }
                
                guard let articles = self?.extractArticle(payload: results),
                      let dataModel = self?.extractModel(articles: articles)
                else {
                    completion(ServiceError.parsingError)
                    return
                }
                
                self?.realmDb.saveAll(eventModel: dataModel)
                completion(nil)
                
            case .failure:
                completion(ServiceError.apiError)
                break
            }
        }
    }
    
    private func extractModel(articles: [Article]) -> [ArticleModel] {
        return articles.compactMap { ArticleModel.init(model: $0 )}
    }
    
    private func extractArticle(payload: [[String : Any]]) -> [Article] {
        return payload.compactMap { Article(dictionary: $0) }
        
    }
}


enum ServiceError: Error {
    case parsingError
    case apiError
}
