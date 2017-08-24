//
// Created by Arun Sivakumar on 20/2/19.
// Copyright © 2019 Arun Sivakumar. All rights reserved.
// 

import Foundation

//
// Created by Arun Sivakumar on 20/2/19.
// Copyright © 2019 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewControlle2: UIViewController {
    
    @IBAction func unwind(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Single.shared.printDetails()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

