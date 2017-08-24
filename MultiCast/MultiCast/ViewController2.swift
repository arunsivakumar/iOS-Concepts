//
// Created by Arun Sivakumar on 11/10/18.
// Copyright © 2018 Arun Sivakumar. All rights reserved.
// 

import Foundation

//
// Created by Arun Sivakumar on 11/10/18.
// Copyright © 2018 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, ServiceDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func serviceGotData() {
        // do nothing
        print("VC 2 Fetched")
    }
    
}

