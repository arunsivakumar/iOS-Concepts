//
//  ViewController.swift
//  TestNew
//
//  Created by Arun Sivakumar on 10/23/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    var dataReceived:String?
    
    @IBOutlet weak var dataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataReceived = dataReceived{
            dataLabel.text = dataReceived
            self.navigationItem.title = dataReceived
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

