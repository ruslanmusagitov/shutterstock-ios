//
//  Category.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import Foundation

class Category: NSObject {
    var id : String!
    var name : String!
    
    class func create(fromDictionary dict: [String : AnyObject]) -> Category {
        let object = Category()
        object.id = dict["id"] as? String
        object.name = dict["name"] as? String
        return object
    }

}
