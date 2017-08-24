//
// Created by Arun Sivakumar on 11/10/18.
// Copyright © 2018 Arun Sivakumar. All rights reserved.
// 

import Foundation
protocol ServiceDelegate {
    func serviceGotData()
}

class Service {
    
    var delegate = MulticastDelegate<ServiceDelegate>()
    
    func fetchData() -> Bool {
        // fetch Data and notify your delegates
        // Call your delegates
        delegate |> { delegate in
            delegate.serviceGotData()
        }
        return true
    }
}
