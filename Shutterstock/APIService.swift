//
//  APIService.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    let authorizationHeader = ["Authorization" : "Basic MDU5OTIxNGRkZDFmNjA1ZjEzNTg6NDU2MGU4OTczYWY3N2ZiZTg4NTA4MzcyNDViNjI0ZGUyOWMwYmFmMw"]
    
    func fetchImages(category: Category, page: Int = 1, perPage: Int = 20, completion:([ShutterstockMedia]) -> Void) {
        Alamofire.request(.GET, "https://api.shutterstock.com/v2/images/search?category=\(category.id)&page=\(page)&perPage=\(perPage)", parameters: nil, encoding: .JSON, headers: authorizationHeader).responseJSON { response in
            var assets = [ShutterstockMedia]()
            if let dict = response.result.value as? [String : AnyObject] {
                if let array = dict["data"] as? [AnyObject] {
                    for dict in array {
                        let asset = ShutterstockMedia.create(fromDictionary: dict as! [String : AnyObject])
                        assets.append(asset)
                    }
                }
            }
            completion(assets)
        }
    }
    
    func fetchImages(withKeywords keywords: String, page: Int = 1, perPage: Int = 20, completion:([ShutterstockMedia]) -> Void) {
        Alamofire.request(.GET, "https://api.shutterstock.com/v2/images/search?query=\(keywords)&page=\(page)&perPage=\(perPage)", parameters: nil, encoding: .JSON, headers: authorizationHeader).responseJSON { response in
            var assets = [ShutterstockMedia]()
            if let dict = response.result.value as? [String : AnyObject] {
                if let array = dict["data"] as? [AnyObject] {
                    for dict in array {
                        let asset = ShutterstockMedia.create(fromDictionary: dict as! [String : AnyObject])
                        assets.append(asset)
                    }
                }
            }
            completion(assets)
        }
    }

    
    func fecthCategories(completion:(([Category]) -> Void)) {
        Alamofire.request(.GET, "https://api.shutterstock.com/v2/images/categories", parameters: nil, encoding: .JSON, headers: authorizationHeader).responseJSON { response in
            var categories = [Category]()
            if let dict = response.result.value as? [String : AnyObject] {
                if let array = dict["data"] as? [AnyObject] {
                    for dict in array {
                        let category = Category.create(fromDictionary: dict as! [String : AnyObject])
                        categories.append(category)
                    }
                }
            }
            completion(categories)
        }
    }
    
}