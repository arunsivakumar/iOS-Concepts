//
//  ViewController.swift
//  unwind
//
//  Created by Arun Sivakumar on 10/4/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToPurchase(segue: UIStoryboardSegue){
        print(segue.identifier)
        if let identifier = segue.identifier{
            
            switch identifier {
                
            case "Selected":
                let VC = segue.source as? SelectTableViewController
                self.label.text = VC?.selectedName
            default:
                break
            }
            
        }
    }

    
    
}

