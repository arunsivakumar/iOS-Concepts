//
//  ViewController.swift
//  AnimateLabel
//
//  Created by Arun Sivakumar on 14/1/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let a = ["", "200 GB Data","500 GB data","Something new","Roaming Pack","Mobile Data", "CNY", "7", "8"]

    var animationHelper: AnimationHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationHelper = AnimationHelper(target: self, data: a, label: label)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) { [weak self] in
            self?.animationHelper = nil
        }
    }
}


class AnimationHelper {
    
    var label: UILabel?
    let data: [String]
    var target: UIViewController?
    var currentIndex = 0
    
    init(target: UIViewController, data: [String], label: UILabel) {
        self.data = data
        self.label = label
        self.target = target
        animate(text: "")
    }
    
    private func animate(text: String) {
        guard let label = label else { return }
        UIView.transition(with: label, duration: 2.0, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.label?.text = text

        }) { [weak self] (true) in
            guard let self = self else { return }
            self.currentIndex += 1
            if(self.currentIndex < self.data.count) {
                self.animate(text: self.data[self.currentIndex])
            }
        }
    }
    
    func cancelAnimation() {
        self.label?.layer.removeAllAnimations()
    }
}
