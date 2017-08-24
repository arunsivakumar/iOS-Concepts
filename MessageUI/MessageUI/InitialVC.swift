//
//  InitialVC.swift
//  MessageUI
//
//  Created by Arun on 4/21/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit
import Kingfisher
import JSQMessagesViewController
import Parse
import Bolts

class InitialVC: UIViewController {
    
    var storedMessages = [JSQMessage]()
    
    let maximumDifferenceDateforOldMessages = 6
    
    
    override func viewDidLoad() {
//        addImagesFromSmooch()
    }
    
    
    override func viewWillAppear(animated: Bool) {

//        addImagesFromSmooch()
    }
    
    
    
    @IBAction func showMessages(sender: UIButton) {
        
         self.performSegueWithIdentifier("ShowMessages", sender: self)
    }
    
    
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
        
        if(segue.sourceViewController .isKindOfClass(ViewController)){
           
            let view:ViewController = segue.sourceViewController as! ViewController
            self.storedMessages = view.messages
            print(storedMessages)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowMessages") {
            //            let noteViewController = segue.destinationViewController as! NoteDisplayViewController
            //            noteViewController.note = selectedNote
            
            let viewController = segue.destinationViewController as! ViewController
            
            if storedMessages.isEmpty{
//#                self.addMessagesFromSmooch()
            }
//#            viewController.historyMessages = self.storedMessages
        }
    }
    
    
    
    func addImagesFromSmooch(){
        
        let messageHistory = Smooch.conversation().messages
        
        for m in messageHistory {
            let message = m as! SKTMessage
            
            let dateDifference =  HelperClass.offsetFromDays(message.date)

            if (dateDifference <= maximumDifferenceDateforOldMessages){
                
                if message.mediaUrl != nil{
                    //                print("URL-")
                    //                print(message.mediaUrl)
                    let receivedImageView = UIImageView()
                    
                    let url = NSURL(string: message.mediaUrl)

                    receivedImageView.kf_setImageWithURL(url!)

                }
            }
        }
    }
    
//    func setup() {
//        
//        //        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
//        //        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
//        
//        self.senderId = "Me"
//        self.senderDisplayName = "Me"
//    }
//    
    
    func addMessagesFromSmooch(){
        
        self.storedMessages = [JSQMessage]()
        
        let messageHistory = Smooch.conversation().messages
        
        for m in messageHistory {
            let message = m as! SKTMessage
            
            let dateDifference =  HelperClass.offsetFromDays(message.date)
            
            if (dateDifference <= maximumDifferenceDateforOldMessages){
                
                var sender = ""
                if message.isFromCurrentUser == false{
                    sender = "Server"
                }else{
                    sender = "Me"
                }
                
                // 1. Structured Message
                if message.text.rangeOfString("###$$$") != nil && message.text != "###$$$"{
                    print(message.text)
                    let listingID = message.text.stringByReplacingOccurrencesOfString("###$$$", withString: "")
                    self.addStructuredMessage(listingID,sender: sender,loadHistory: true)
                    
                }
                    // 2. Picture
                else if message.mediaUrl != nil{
                    
                    let receivedImageView = UIImageView()
                    let url = NSURL(string: message.mediaUrl)
                    receivedImageView.kf_setImageWithURL(url!)
                    let photoMessage = JSQPhotoMediaItem.init(image: receivedImageView.image)
                    
                    let newMessage = JSQMessage.init(senderId: sender, senderDisplayName: sender, date: message.date, media: photoMessage)
                    self.storedMessages += [newMessage]
                    
                    //                }else if message.text == "###$$$"{
                    //                    let structuredMsg = StructuredMessage() // It's my custom class inherited from JSQMessageMediaData
                    //                    let message = JSQMessage(senderId: sender, displayName: sender, media: structuredMsg)
                    //                    self.storedMessages += [message]
                    
                    // 3. Text
                }else{
                    let newMessage = JSQMessage.init(senderId: sender, senderDisplayName: sender, date: message.date, text: message.text)
                    self.storedMessages += [newMessage]
                }
            }
        }
        
//        self.reloadMessagesView()
    }
    
    
    func addStructuredMessage(listingID: String,sender:String,loadHistory:Bool){
        
        print("listingID -")
        print(listingID)
        
        let listingDB = PFQuery(className:"ListingDB")
        listingDB.whereKey("objectId", equalTo: listingID)
        listingDB.includeKey("productName")
        
        do {
            let object = try listingDB.getFirstObject()
            
            let price = object["price"] as! Double
            print("price - \(price)")
            
            let productName = object.objectForKey("productName")!.objectForKey("genesis")! as? String
//            let productImage = object.objectForKey("productName")!.objectForKey("productImage0")! as? PFFile
            let productImage = object.objectForKey("productImage")!.objectForKey("productImage") as? PFFile
            
            let productImageView = UIImageView()
            
            var url = NSURL(string: (productImage?.url)!)
            
            let attributes = object["attributes"] as! NSDictionary
            print("arributes - \(attributes)")
            
            var combinedAttribute = ""
            for (_,value) in attributes{
                combinedAttribute += (value as! String)
                
            }
            
            productImageView.kf_setImageWithURL(NSURL(string: (productImage?.url)!)!,
                                                placeholderImage: nil,
                                                optionsInfo: nil,
                                                progressBlock: { (receivedSize, totalSize) -> () in
                                                    print("Download Progress: \(receivedSize)/\(totalSize)")
                },
                                                completionHandler: { (image, error, cacheType, imageURL) -> () in
                                                    print("Downloaded and set!")
                                                    let structuredMsg = StructuredMessage()
                                                    structuredMsg.price = price
                                                    structuredMsg.productName = productName!
                                                    structuredMsg.productAttribute = combinedAttribute
                                                    structuredMsg.productImage = productImageView.image!
                                                    let message = JSQMessage(senderId: sender, displayName: sender, media: structuredMsg)
                                                    self.storedMessages += [message]
//                                                    if !loadHistory{
////                                                        self.finishReceivingMessageAnimated(true)
//                                                    }
                }
            )
            //            print(result)
        } catch {
            print(error)
        }
        
        
        //        listingDB.getFirstObjectInBackgroundWithBlock { (object, error) in
        //            if error == nil{
        //                let price = object!["price"] as! Double
        //                print("price - \(price)")
        //
        //                let productName = object!.objectForKey("productName")!.objectForKey("genesis")! as? String
        //                let productImage = object!.objectForKey("productName")!.objectForKey("productImage0")! as? PFFile
        //
        //                let productImageView = UIImageView()
        //
        //                var url = NSURL(string: (productImage?.url)!)
        //
        //                let attributes = object!["attributes"] as! NSDictionary
        //                print("arributes - \(attributes)")
        //
        //                var combinedAttribute = ""
        //                for (_,value) in attributes{
        //                     combinedAttribute += (value as! String)
        //
        //                }
        //
        //                productImageView.kf_setImageWithURL(NSURL(string: (productImage?.url)!)!,
        //                    placeholderImage: nil,
        //                    optionsInfo: nil,
        //                    progressBlock: { (receivedSize, totalSize) -> () in
        //                        print("Download Progress: \(receivedSize)/\(totalSize)")
        //                    },
        //                    completionHandler: { (image, error, cacheType, imageURL) -> () in
        //                        print("Downloaded and set!")
        //                        let structuredMsg = StructuredMessage()
        //                        structuredMsg.price = price
        //                        structuredMsg.productName = productName!
        //                        structuredMsg.productAttribute = combinedAttribute
        //                        structuredMsg.productImage = productImageView.image!
        //                        let message = JSQMessage(senderId: sender, displayName: sender, media: structuredMsg)
        //                        self.storedMessages += [message]
        ////                        if !loadHistory{
        //                            self.finishReceivingMessageAnimated(true)
        ////                        }
        //                    }
        //                )
        //                
        //            }else{
        //                print("No Data")
        //            }
        //        }
    }



}
