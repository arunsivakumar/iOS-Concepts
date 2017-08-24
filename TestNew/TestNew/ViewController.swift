//
//  ViewController.swift
//  TestNew
//
//  Created by Arun Sivakumar on 10/23/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Data"{
            if let ivc = (segue.destination.childViewControllers.last as? DataViewController){
                ivc.dataReceived = ((sender as AnyObject).currentTitle!)!
            }
        }
    }


}

extension UIViewController{
    
    var contentViewController:UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}
