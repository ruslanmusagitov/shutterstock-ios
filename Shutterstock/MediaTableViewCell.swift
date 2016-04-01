//
//  MediaCollectionViewCell.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
    
    static let identifier = "MediaTableViewCell"
    
    @IBOutlet weak var mediaImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    var media : ShutterstockMedia! {
        didSet {
            if let urlString = media.preview.url, url = NSURL(string: urlString) {
                mediaImageView.sd_setImageWithURL(url)
            }
            titleLabel.text = media.decscr
        }
    }
}
