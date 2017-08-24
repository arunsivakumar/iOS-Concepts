//
// Created by Arun Sivakumar on 20/2/19.
// Copyright © 2019 Arun Sivakumar. All rights reserved.
// 

import Foundation
class Single{
    
    private init(){
        print("initialized")
    }
    static let shared = Single()
    
    func printDetails(){
        print("memory")
    }
    
    deinit {
        print("deinit")
    }
}
