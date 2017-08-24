//
//  UITableView+Scroll.swift
//  WhaleTalk
//
//  Created by Arun on 4/11/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToBottom() {
//        self.scrollToRowAtIndexPath(NSIndexPath(forRow: self.numberOfRowsInSection(0)-1, inSection: 0), atScrollPosition: .Bottom, animated: true)
    
    //11
//        if self.numberOfRowsInSection(0) > 0{
//            self.scrollToRowAtIndexPath(NSIndexPath(forRow: self.numberOfRowsInSection(0)-1, inSection: 0), atScrollPosition: .Bottom, animated: true)
//        }
        //12
        if self.numberOfSections > 1{
            let lastSection = self.numberOfSections - 1
            self.scrollToRowAtIndexPath(NSIndexPath(forRow:self.numberOfRowsInSection(lastSection) - 1, inSection: lastSection), atScrollPosition: .Bottom, animated: true)
        } else if self.numberOfSections == 1 && self.numberOfRowsInSection(0) > 0 {
            self.scrollToRowAtIndexPath(NSIndexPath(forRow: self.numberOfRowsInSection(0)-1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        }                 

    }
}