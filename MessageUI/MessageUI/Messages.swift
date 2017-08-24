//
//  Messages.swift
//  MessageUI
//
//  Created by Arun on 4/19/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class Messages{
    
    var pastMessage = [JSQMessage]()
    
    
    init(pastMessages:[JSQMessage]){
        self.pastMessage = pastMessages
    }
    
    func checkPastLoadedHistory() -> Bool{
        
        if self.pastMessage.isEmpty{
            return true
        }else{
            return false
        }
    }
    
}
