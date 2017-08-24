//
//  ViewController.swift
//  Debouncer
//
//  Created by Arun Sivakumar on 2/20/17.
//  Copyright © 2017 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let debouncedFunction = Debouncer(delay: 0.40) {
            print("delayed printing")
        }
        
        debouncedFunction.call()
        debouncedFunction.call()
        debouncedFunction.call()
        debouncedFunction.call()
        debouncedFunction.call()
        
        print("Hello")
        print("Test")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

