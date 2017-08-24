//
//  ViewController.swift
//  SearchDisplay
//
//  Created by Arun Sivakumar on 6/30/17.
//  Copyright © 2017 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchControllerDelegate {
    
    var searchController:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        configureSearchBar()
    }
    
    func configureSearchBar(){
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController2")

        
        
        let resultsController = controller
        self.searchController = UISearchController(searchResultsController: resultsController)
        
        self.searchController.delegate = self
//        self.searchController = UISearchController(searchResultsController: packagedSearchController())
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
//        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = false
    
        
    
        
        self.searchController.searchResultsUpdater = controller as? UISearchResultsUpdating
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        print("")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.isActive = true
        self.searchController.searchResultsController?.view.backgroundColor = .green
        self.searchController.view.backgroundColor = .blue
        
    }
    


    
//    func packagedSearchController() -> UIViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let searchResultsController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2 else {
//            fatalError("Unable to instatiate a SearchResultsViewController from the storyboard.")
//        }
//        
//        let searchController = UISearchController(searchResultsController: searchResultsController)
//        searchController.searchResultsUpdater = searchResultsController
//        searchController.searchBar.placeholder = NSLocalizedString("Enter keyword (e.g. iceland)", comment: "")
//        
//        let searchContainer = UISearchContainerViewController(searchController: searchController)
//        searchContainer.title = NSLocalizedString("Search", comment: "")
//        
//        let searchNavigationController = UINavigationController(rootViewController: searchContainer)
//        return searchNavigationController
//    }

}
