//
//  AsyncPhotoMediaItem.swift
//  MessageUI
//
//  Created by Arun on 4/20/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import Kingfisher

class AsyncPhotoMediaItem: JSQPhotoMediaItem {
    var asyncImageView: UIImageView!
    
    override init!(maskAsOutgoing: Bool) {
        super.init(maskAsOutgoing: maskAsOutgoing)
    }
    
    init(withURL url: NSURL) {
        super.init()
       asyncImageView.kf_setImageWithURL(url)
    
    }
    
    override func mediaView() -> UIView! {
        return asyncImageView
    }
    
    override func mediaViewDisplaySize() -> CGSize {
        return asyncImageView.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}