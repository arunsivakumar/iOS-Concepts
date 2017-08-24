//
//  StructuredMessage.swift
//  MessageUI
//
//  Created by Arun on 4/27/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class StructuredMessage: NSObject, JSQMessageMediaData {
    
//    var sender: String?
    var productName = ""
    var price = 0.0
    var productAttribute = ""
    var productImage = UIImage()

    @objc func mediaView() -> UIView {
        return self.createView()
    }
    
    @objc func mediaPlaceholderView() -> UIView! {
        return self.createView()
    }
    
    @objc func mediaViewDisplaySize() -> CGSize {
        return self.constantFrame().size
    }
    
    @objc func mediaHash() -> UInt {
        return 1
    }
    
    func createView() -> UIView {
        let view = UIView(frame: self.constantFrame())
        
//         let view = UIView(frame: CGRect(x: -30, y: 0, width: 450, height: 100))
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
        
        var imageView: UIImageView!
        imageView = UIImageView(frame: CGRect(x: -80, y: 5, width: 300, height: 90))
//        imageView.image = UIImage(named:"Product")
        imageView.image = self.productImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        
        var overlayImageView: UIImageView!
        overlayImageView = UIImageView(frame: CGRect(x: -30, y: 0, width: 450, height: 100))
//        overlayImageView.image = imageView.image
        overlayImageView.image = self.productImage
        overlayImageView.tintColor = UIColor.blackColor()
        overlayImageView.contentMode = UIViewContentMode.ScaleAspectFill
        overlayImageView.alpha = 0.25
        view.addSubview(overlayImageView)
        
        let button   = UIButton(frame: CGRectMake(150, 65, 80, 30))
        button.backgroundColor = UIColor.clearColor()
        button.setTitle("$\(self.price)", forState: UIControlState.Normal)
        button.setTitleColor(UIColor(red:37.0/255.0,green:199.0/255.0,blue:255.0/255.0,alpha : 1.0), forState: .Normal)
        button.addTarget(self, action: #selector(StructuredMessage.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:37.0/255.0,green:199.0/255.0,blue:255.0/255.0,alpha : 1.0).CGColor
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        view.addSubview(button)
        
        let productLabel = UILabel(frame: CGRectMake(150, 0, 200, 45))
//        productLabel.text = "Men's Nike Roshe One NM Flyknit"
        productLabel.text = self.productName
        productLabel.textColor = UIColor.whiteColor()
        productLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        productLabel.lineBreakMode = .ByWordWrapping
        productLabel.numberOfLines = 0
        view.addSubview(productLabel)
        
        let productDetailLabel = UILabel(frame: CGRectMake(150, 40, 200, 25))
//        productDetailLabel.text = "Black/White/Cool Grey/Dark Grey"
        
        productDetailLabel.text = self.productAttribute
        productDetailLabel.textColor = UIColor.whiteColor()
        productDetailLabel.font =  UIFont(name: "HelveticaNeue", size: 12)
        productDetailLabel.lineBreakMode = .ByWordWrapping
        productDetailLabel.numberOfLines = 0
        view.addSubview(productDetailLabel)
        
        //        let label = UILabel(frame: self.constantFrame())
        //        label.text = " [offline]"
        //        label.textColor = UIColor.blueColor()
        //        view.addSubview(label)
        return view
    }
    
    func constantFrame() -> CGRect {
        return CGRectMake(0,0,600,100)
    }
    
    func pressed(sender: UIButton!) {
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();
    }
}