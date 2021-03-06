//
//  CategoryViewController.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let perPage = 20

    @IBOutlet weak var loadMoreButton : UIButton!
    
    @IBOutlet weak var tableView : UITableView!
    
    var category : Category! {
        didSet {
            title = category.name
        }
    }
    
    var apiService = APIService()
    
    var media = [ShutterstockMedia]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages(1)
    }
    
    func fetchImages(page: Int) {
        setLoadingState()
        apiService.fetchImages(category, page: page, perPage: perPage) { (images) in
            self.media.appendContentsOf(images)
            self.tableView.reloadData()
            self.setLoadedState()
        }
    }
}

extension CategoryViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MediaTableViewCell.identifier) as! MediaTableViewCell
        cell.media = media[indexPath.item]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let width = CGRectGetWidth(tableView.frame)
        let mediaObject = media[indexPath.item]
        let aspect = CGFloat(mediaObject.aspect.floatValue)
        let height = width / aspect
        return height
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return loadMoreButton
    }
    
    @IBAction func loadMoreSelected(sender : AnyObject) {
        let page = media.count / perPage + 1
        fetchImages(page)
    }
    
    func setLoadingState() {
        loadMoreButton.setTitle("Loading...", forState: .Normal)
        loadMoreButton.enabled = false
    }
    
    func setLoadedState() {
        self.loadMoreButton.setTitle("Load More", forState: .Normal)
        self.loadMoreButton.enabled = true
    }
}