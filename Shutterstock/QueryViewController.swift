//
//  QueryViewController.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import UIKit

class QueryViewController: CategoryViewController {
    var keyword : String! {
        didSet {
            title = keyword
        }
    }
    
    override func fetchImages(page: Int) {
        setLoadingState()
        apiService.fetchImages(withKeywords: keyword, page: page, perPage: perPage) { (images) in
            self.media.appendContentsOf(images)
            self.tableView.reloadData()
            self.setLoadedState()
        }
    }
}
