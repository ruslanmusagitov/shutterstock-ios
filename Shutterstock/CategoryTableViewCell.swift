//
//  CategoryTableViewCell.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "CategoryTableViewCell"
    
    @IBOutlet weak var titleLabel : UILabel!
    
    var category : Category! {
        didSet {
            titleLabel.text = category.name
        }
    }
    
}
