//
// Created by Arun Sivakumar on 22/2/19.
// Copyright © 2019 Arun Sivakumar. All rights reserved.
// 

import UIKit

class Mem{
    init(){
        print("Mem Created")
    }
}


class Test{
   
    static let a = Mem();
    
    func printTest(){
        print("before print")
        print(Test.a)
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        
        let test = Test()
        print("test created")

        test.printTest()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

