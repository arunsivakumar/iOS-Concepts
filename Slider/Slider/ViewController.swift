//
//  ViewController.swift
//  Slider
//
//  Created by Arun Sivakumar on 11/9/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slider.addTarget(self, action: #selector(ViewController.valueChanged(_:)), for: .valueChanged)
       
        label.text = "Hello"
        slider.addSubview(label)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(_ sender: UISlider) {
//        label.text = "\(slider.value)"
        self.label.center = CGPoint(x: CGFloat(self.slider.value)*self.slider.bounds.size.width, y:40);
        

        
    }

}

