//
//  ViewController2.swift
//  SearchDisplay
//
//  Created by Arun Sivakumar on 6/30/17.
//  Copyright © 2017 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController2: UIViewController,UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        self.view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("appeared")
        self.view.backgroundColor = .green
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("disappeared")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
