//
//  CategoriesViewController.swift
//  Shutterstock
//
//  Created by Ruslan Musagitov on 01/04/16.
//  Copyright © 2016 Synergy. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var categories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        
        APIService().fecthCategories { (array) in
            self.categories = array
        }
    }
}

extension CategoriesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CategoryTableViewCell.identifier) as! CategoryTableViewCell
        cell.category = categories[indexPath.item]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ViewController, let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            vc.category = categories[indexPath.row]
        }
    }
    
}