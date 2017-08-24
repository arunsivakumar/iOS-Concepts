//
//  StructuredCell.swift
//  MessageUI
//
//  Created by Arun on 4/19/16.
//  Copyright © 2016 Arun. All rights reserved.
//


import UIKit

class StructuredCell: UICollectionViewCell {
    
    let messageLabel: UILabel = UILabel()
    
    private let bubbleImageView = UIImageView()
    
    private let botImageConstant:CGFloat = 40.0
    
    private let botImageView = UIImageView()
    
    var imageView: UIImageView!
    //    private let userImageView = UIImageView()
    
    //
    //    private var outgoingConstraint: NSLayoutConstraint!
    //    private var incomingConstraint: NSLayoutConstraint!
    
    //7
    
    
    
    private var outgoingConstraints: [NSLayoutConstraint]!
    private var incomingConstraints: [NSLayoutConstraint]!
    
    override init(frame: CGRect) {
   
            super.init(frame: frame)
    
//    override init(style: UICollectionViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView.image = UIImage(named:"User")
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
        
//        let messageWindowSize = contentView.frame.width * (1 / 3)
//        
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        //  #### messagefont
//        messageLabel.textColor = UIColor.whiteColor()
//        messageLabel.font = UIFont.systemFontOfSize(14)
//        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(bubbleImageView)
//        bubbleImageView.addSubview(messageLabel)
//        
//        botImageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(botImageView)
//        
//        messageLabel.centerXAnchor.constraintEqualToAnchor(bubbleImageView.centerXAnchor).active = true
//        //        messageLabel.leftAnchor.constraintEqualToAnchor(bubbleImageView.leftAnchor).active = true
//        messageLabel.centerYAnchor.constraintEqualToAnchor(bubbleImageView.centerYAnchor).active = true
//        
//        bubbleImageView.widthAnchor.constraintEqualToAnchor(messageLabel.widthAnchor, constant:30).active = true
//        //        bubbleImageView.heightAnchor.constraintEqualToAnchor(messageLabel.heightAnchor).active = true
//        //7
//        bubbleImageView.heightAnchor.constraintEqualToAnchor(messageLabel.heightAnchor, constant:20).active = true
//        
//        //        bubbleImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
//        //        bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
//        
//        //        outgoingConstraint = bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor)
//        //        incomingConstraint = bubbleImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor)
//        //7
//        outgoingConstraints = [
//            botImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -5),
//            bubbleImageView.trailingAnchor.constraintEqualToAnchor(botImageView.leadingAnchor),
//            //            bubbleImageView.leadingAnchor.constraintGreaterThanOrEqualToAnchor(contentView.centerXAnchor)
//            bubbleImageView.leadingAnchor.constraintGreaterThanOrEqualToAnchor(contentView.leadingAnchor, constant: messageWindowSize)
//        ]
//        
//        incomingConstraints = [
//            botImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 5),
//            bubbleImageView.leadingAnchor.constraintEqualToAnchor(botImageView.trailingAnchor),
//            //            bubbleImageView.trailingAnchor.constraintLessThanOrEqualToAnchor(messageWindowSize)
//            bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -messageWindowSize)
//        ]
//        
//        
//        //        let image = UIImage(named: "MessageBubble")?.imageWithRenderingMode(.AlwaysTemplate)
//        //        bubbleImageView.tintColor = UIColor.blueColor()
//        //        bubbleImageView.image = image
//        
//        
//        bubbleImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor, constant: 10).active = true
//        bubbleImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor, constant: -10).active = true
//        
//        //        botImageView.topAnchor.constraintEqualToAnchor(bubbleImageView.topAnchor, constant: 0).active = true
//        botImageView.bottomAnchor.constraintEqualToAnchor(bubbleImageView.bottomAnchor, constant: 0).active = true
//        
//        messageLabel.textAlignment = .Left
//        messageLabel.numberOfLines = 0
//        
//        //botImageView.image = UIImage(named:"Loop")
//        
//        //        botImageView.layer.frame.height = 50.
//        
//        //        userImageView.image = UIImage(named:"Loop")
//        //
//        //        botImageView.widthAnchor.constraintEqualToAnchor(messageLabel.widthAnchor, constant:20).active = true
//        //        botImageView.heightAnchor.constraintEqualToAnchor(messageLabel.heightAnchor, constant:20).active = true
//        botImageView.widthAnchor.constraintEqualToConstant(botImageConstant).active = true
//        botImageView.heightAnchor.constraintEqualToConstant(botImageConstant).active = true
//        botImageView.layer.cornerRadius = botImageConstant/2
//        botImageView.clipsToBounds = true
//        
//        //        botImageView.centerYAnchor.constraintEqualToAnchor(bubbleImageView.centerYAnchor)
//        //        botImageView.layer.frame.width = 12.0
//        
//        //        var frm: CGRect = botImageView.frame
//        //        botImageView.frame = CGRectMake(5,frm.origin.y, 15, 15)
//        //        botImageView.image = UIImage(named:"Loop")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func incoming(incoming: Bool) {
//        if incoming {
//            
//            
//            //7
//            //            incomingConstraint.active = true
//            //            outgoingConstraint.active = false
//            NSLayoutConstraint.deactivateConstraints(outgoingConstraints)
//            NSLayoutConstraint.activateConstraints(incomingConstraints)
//            botImageView.image = UIImage(named:"Loop")
//            bubbleImageView.image = bubble.incoming
//        } else {
//            
//            //7
//            //            incomingConstraint.active = false
//            //            outgoingConstraint.active = true
//            NSLayoutConstraint.deactivateConstraints(incomingConstraints)
//            NSLayoutConstraint.activateConstraints(outgoingConstraints)
//            botImageView.image = UIImage(named:"User")
//            bubbleImageView.image = bubble.outgoing
//        }
//    }
}

//let bubble = makeBubble()
//
//func makeBubble() -> (incoming: UIImage, outgoing: UIImage) {
//    let image = UIImage(named: "MessageBubble")!
//    
//    let insetsIncoming = UIEdgeInsets(top: 17, left: 26.5, bottom: 17.5, right: 21)
//    let insetsOutgoing = UIEdgeInsets(top: 17, left: 21, bottom: 17.5, right: 26.5)
//    
//    //7
//    // rendering mode .AlwaysTemplate doesn't work when changing the orientation
//    // ### change color to looplist color
//    let outgoing = coloredImage(image, red: 37/255, green: 199/255, blue: 255/255, alpha: 1).resizableImageWithCapInsets(insetsOutgoing)
//    
//    let flippedImage = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: UIImageOrientation.UpMirrored)
//    
//    let incoming = coloredImage(flippedImage, red: 143/255, green: 143/255, blue: 143/255, alpha: 1).resizableImageWithCapInsets(insetsIncoming)
//    
//    return (incoming, outgoing)
//}
//
//func coloredImage(image: UIImage, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIImage! {
//    let rect = CGRect(origin: CGPointZero, size: image.size)
//    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
//    let context = UIGraphicsGetCurrentContext()
//    image.drawInRect(rect)
//    
//    CGContextSetRGBFillColor(context, red, green, blue, alpha)
//    CGContextSetBlendMode(context, CGBlendMode.SourceAtop)
//    CGContextFillRect(context, rect)
//    let result = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    
//    return result
//}

