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
    @IBOutlet weak var searchBar : UISearchBar!
    
    var searchActive : Bool {
        get {
            return searchBar.text?.characters.count > 0
        }
    }
    
    var categories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filteredCategories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        APIService().fecthCategories { (array) in
            self.categories = array
        }
    }
}

extension CategoriesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            if filteredCategories.count == 0 {
                return 1
            }
            return filteredCategories.count
        }
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if searchActive && filteredCategories.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(NoCategoryTableViewCell.identifier) as! NoCategoryTableViewCell
            cell.titleLabel.text = "There is no categories with name \(searchBar.text!). Tap Search to find images with this keyword."
            return cell
        }

        var category : Category!
        if searchActive {
            category = filteredCategories[indexPath.row]
        } else {
            category = categories[indexPath.row]
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(CategoryTableViewCell.identifier) as! CategoryTableViewCell
        cell.category = category
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CategoryViewController") as? CategoryViewController {
            var category : Category!
            if searchActive {
                category = filteredCategories[indexPath.row]
            } else {
                category = categories[indexPath.row]
            }
            vc.category = category
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension CategoriesViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCategories = categories.filter( { (category: Category) -> Bool in
            return category.name.containsString(searchText)
        })
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text?.characters.count == 0 {
            return
        }
        searchForKeyword(searchBar)
    }
    
    @IBAction func searchForKeyword(sender : AnyObject) {
        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("QueryViewController") as? QueryViewController {
            vc.keyword = searchBar.text
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}