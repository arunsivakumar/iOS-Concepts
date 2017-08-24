//
// Created by Arun Sivakumar on 11/1/19.
// Copyright © 2019 Arun Sivakumar. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hc: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func expand(_ sender: Any) {
        hc.constant = 400
        
    }
    
}

