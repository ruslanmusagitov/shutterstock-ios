//
//  ShutterStockAsset.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import Foundation

class ShutterstockMedia: NSObject {
    var aspect : NSNumber!

    var smallThumb : ShutterstockMediaAsset!
    var largeThumb : ShutterstockMediaAsset!
    var preview : ShutterstockMediaAsset!
    
    var contributor : String!
    var decscr : String!
    var id : String!
    var imageType : String!
    var mediaType : String!
    
    class func create(fromDictionary dict: [String : AnyObject]) -> ShutterstockMedia {
        let object = ShutterstockMedia()
        object.aspect = dict["aspect"] as? NSNumber
        if let assetsDict = dict["assets"] as? [String : AnyObject] {
            object.smallThumb = ShutterstockMediaAsset.create(fromDictionary: assetsDict["small_thumb"] as! [String : AnyObject])
            object.largeThumb = ShutterstockMediaAsset.create(fromDictionary: assetsDict["large_thumb"] as! [String : AnyObject])
            object.preview = ShutterstockMediaAsset.create(fromDictionary: assetsDict["preview"] as! [String : AnyObject])
        }
        object.contributor = dict["contributor"] as? String
        object.decscr = dict["description"] as? String
        object.id = dict["id"] as? String
        object.imageType = dict["image_type"] as? String
        object.mediaType = dict["media_type"] as? String
        return object
    }
}
