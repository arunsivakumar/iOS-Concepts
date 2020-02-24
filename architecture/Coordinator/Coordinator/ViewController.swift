//
//  ViewController.swift
//  Coordinator
//
//  Created by Arun Sivakumar on 5/1/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: (Buying & AccountCreating)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buy(_ sender: UIButton) {
        coordinator?.buySubscription(to: 1)
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        coordinator?.createAccount()
    }
    
}

