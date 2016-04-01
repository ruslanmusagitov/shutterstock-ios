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
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    var media : ShutterstockMedia! {
        didSet {
            if let urlString = media.preview.url, url = NSURL(string: urlString) {
                activityIndicator.startAnimating()
                activityIndicator.hidden = false
                mediaImageView.sd_setImageWithURL(url, completed: { (image, error, cacheType, url) in
                    self.activityIndicator.stopAnimating()
                })
            }
            titleLabel.text = media.decscr
        }
    }
}
