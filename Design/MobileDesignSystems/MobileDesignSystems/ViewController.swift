//
//  ViewController.swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIStackView!
    @IBOutlet weak var centerView: UIStackView!
    @IBOutlet weak var bottomView: UIStackView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        label1.set(style: .largeTitle)
        label2.set(style: .title3)
        
        label3.set(style: .callout)
        label4.set(style: .body)
        label5.set(style: .footnote)
        
        button1.set(style: .primaryDark)
        button2.set(style: .primaryLight)
        button3.set(style: .secondary)
        
        label1.text = "Page Title"
        label2.text = "Title"
        label3.text = "callout"
        label4.text = "This is all about mobile design system"
        label5.text = "footnote"

        bottomView.spacing = Spacing.get(.standard)
        let margin = Spacing.get(.standard2)
        
        let constraints = [
            
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
                  
            centerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            centerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
                        
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ]

        NSLayoutConstraint.activate(constraints)
        
    }
   
}


