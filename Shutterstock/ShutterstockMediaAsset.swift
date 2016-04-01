//
//  ShutterstockMediaAsset.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import Foundation
import UIKit

class ShutterstockMediaAsset: NSObject {
    var height : NSNumber!
    var width : NSNumber!
    var url : String!

    class func create(fromDictionary dict: [String : AnyObject]) -> ShutterstockMediaAsset {
        let object = ShutterstockMediaAsset()
        object.height = dict["height"] as? NSNumber
        object.width = dict["width"] as? NSNumber
        object.url = dict["url"] as? String
        return object
    }

    var size : CGSize {
        get {
            return CGSizeMake(CGFloat(width.floatValue), CGFloat(height))
        }
    }
}
