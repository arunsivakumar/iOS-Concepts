//
//  ViewController.swift
//  MessageUI
//
//  Created by Arun on 4/13/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit
import Alamofire
import JSQMessagesViewController
import AlamofireImage
import SDWebImage
import Kingfisher
import Parse
import Bolts

class ViewController: JSQMessagesViewController,SKTConversationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {


    // Oldese Message date - 2 months 60 days
    let maximumDifferenceDateforOldMessages = 6
    
    var imageView: UIImageView!
    
    var downloadedImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    var selectedImage:UIImage = UIImage()
    
    var dateEnabled:Bool = Bool()
    
    var messageUploadedToSmooch:Bool = Bool()

    // set incoming and outgoing bubble
    let incomingBubble = JSQMessagesBubbleImageFactory((bubbleImage: UIImage.jsq_bubbleRegularStrokedTaillessImage(), capInsets: UIEdgeInsetsZero)).incomingMessagesBubbleImageWithColor(UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0))
    let outgoingBubble = JSQMessagesBubbleImageFactory((bubbleImage: UIImage.jsq_bubbleRegularStrokedTaillessImage(), capInsets: UIEdgeInsetsZero)).outgoingMessagesBubbleImageWithColor(UIColor(red: 37/255, green: 199/255, blue: 255/255, alpha: 1.0))
    
    var historyMessages = [JSQMessage]()
    var messages = [JSQMessage]()
    
  

// MARK: Application Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.automaticallyScrollsToMostRecentMessage = true
        
        imagePicker.delegate = self
        
        dateEnabled = true

        // add camera accesory to the left
        let cameraButton = UIButton()
        let image = UIImage(named: "Camera") as UIImage?
        cameraButton.setImage(image, forState: .Normal)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        // customize input toolbars
        self.inputToolbar.contentView.leftBarButtonItem = cameraButton
        self.inputToolbar.contentView.rightBarButtonItem.setTitleColor(UIColor(red: 95/255, green: 95/255, blue: 95/255, alpha: 1.0), forState: .Disabled)
        self.inputToolbar.contentView.rightBarButtonItem.setTitleColor(UIColor(red: 95/255, green: 95/255, blue: 95/255, alpha: 1.0), forState: .Normal)
        self.inputToolbar.contentView.rightBarButtonItem.setTitle("SEND", forState: .Disabled)
        self.inputToolbar.contentView.rightBarButtonItem.setTitle("SEND", forState: .Normal)
        self.inputToolbar.contentView.textView.keyboardAppearance = UIKeyboardAppearance.Dark
        
        // finish setup
        self.setup()
        
        self.trimOldMessages()
        
        // load previous messages from Smooch
//        self.addMessagesFromSmooch()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.messageUploaded(_:)), name: SKTMessageUploadFailedNotification, object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Smooch.conversation().delegate = self;
    }
    
    
    //### In App notification
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        Smooch.conversation().delegate = UIApplication.sharedApplication().delegate as! SKTConversationDelegate
    }
    
    //    func conversation(conversation: SKTConversation!, shouldShowForAction action: SKTAction) -> Bool {
    //
    //        if(action == SKTAction.InAppNotificationTapped) {
    //            let vc = ViewController() //change this to your class name
    //            self.presentViewController(vc, animated: true, completion: nil)
    //        }
    //        return false
    //    }
    
    
    func trimOldMessages(){
        
        for m in historyMessages{
            let dateDifference =  HelperClass.offsetFromDays(m.date)
            if (dateDifference <= maximumDifferenceDateforOldMessages){
                messages.append(m)
            }
        }
    }
    
    
    func conversation(conversation: SKTConversation!, shouldShowInAppNotificationForMessage message: SKTMessage!) -> Bool {
        return false
    }
    
    func messageUploaded(notification:NSNotification){
        messageUploadedToSmooch = true
    }

// MARK: - Smooch Message Actions
    
    func conversation(conversation: SKTConversation!, didReceiveMessages messages: [AnyObject]!) {


        let sender = "Server"
        
        for m in messages {
            
            let message = m as! SKTMessage
                    
            if message.text.rangeOfString("###$$$") != nil {
                        
                let listingID = message.text.stringByReplacingOccurrencesOfString("###$$$", withString: "")
                self.addStructuredMessage(listingID,sender: sender,loadHistory: false)
                        
            }else{
                        
                if let newMessage = JSQMessage(senderId: sender, senderDisplayName: sender, date: message.date, text: message.text){
                    self.messages += [newMessage]
                    self.finishReceivingMessageAnimated(true)
                }
            }
        }
    }
    
    
    
    func addStructuredMessage(listingID: String,sender:String,loadHistory:Bool){
        
        print("listingID -")
        print(listingID)
        
        let listingDB = PFQuery(className:"ListingDB")
        listingDB.whereKey("objectId", equalTo: listingID)
        listingDB.includeKey("productName")
        listingDB.includeKey("productImage")
        
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
                                                    self.messages += [message]
                                                                            if !loadHistory{
                                                    self.finishReceivingMessageAnimated(true)
                                                                            }
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
//                        self.messages += [message]
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
    
    
    // reload messages
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
    
    /*
     input - text entered by user
     pre-condition - No empty text
     post-condition - Message sent to the Smooch followed by messaging UI
     */
    func postMessage(text:String){
        Smooch.conversation().sendMessage(SKTMessage(text:text))
    
        
    }
    
    /*
     input - picture selected from Image picker
     pre-condition -
     post-condition - picture sent to Smooch followed by messaging UI
     */
    func postPicture(image:UIImage){
        
        let photoMessage = JSQPhotoMediaItem.init(image: image)
        
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderId, date: NSDate(), media: photoMessage)
        
        Smooch.conversation().sendImage(image, withProgress: nil) { (error,m ) in
            if error == nil{
                
                self.messages += [message]
                self.finishSendingMessageAnimated(true)
                
            }
        }
    }
    
}

//MARK: - SetUp Messages

extension ViewController {
    
    func setup() {
        
//        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
//        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
         self.senderId = "Me"
         self.senderDisplayName = "Me"
    }
    
    func addMessagesFromSmooch(){
        
        self.messages = [JSQMessage]()
        
        let messageHistory = Smooch.conversation().messages
        
        for m in messageHistory {
            let message = m as! SKTMessage
            
            let dateDifference =  HelperClass.offsetFromDays(message.date)
            
            if (dateDifference <= maximumDifferenceDateforOldMessages){
                
                var sender = ""
                if message.isFromCurrentUser == false{
                    sender = "Server"
                }else{
                    sender = self.senderId
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
                    self.messages += [newMessage]
                    
//                }else if message.text == "###$$$"{
//                    let structuredMsg = StructuredMessage() // It's my custom class inherited from JSQMessageMediaData
//                    let message = JSQMessage(senderId: sender, displayName: sender, media: structuredMsg)
//                    self.messages += [message]
                
            // 3. Text
                }else{
                    let newMessage = JSQMessage.init(senderId: sender, senderDisplayName: sender, date: message.date, text: message.text)
                    self.messages += [newMessage]
                }
            }
        }
        
        self.reloadMessagesView()
    }
    
    
//MARK: - Testing
    
    @IBAction func reloadData(sender: AnyObject) {
//        self.collectionView.reloadData()
//        self.messages = [JSQMessage]()
        self.addMessagesFromSmooch()
    }
    
    //### come out of messaging View Controller
    
    @IBAction func dismissViewController(sender: AnyObject) {
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
}

//MARK: - JSQMessage Collection View - Data Source & Delegate
extension ViewController {
    
    
    // Data source methods
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        let data = self.messages[indexPath.row]
        return data
    }
    
//    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
//        
//        self.messages.removeAtIndex(indexPath.row)
//    }
    
     // Delegate methods
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.row]
        
        if message.senderId == self.senderId{
            return self.outgoingBubble
        }else{
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let message = self.messages[indexPath.item];
        
        let currentCell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
       
        print("Message - ")
        print(message)
        
        if message.text != nil{
            currentCell.textView.textColor = UIColor.darkGrayColor()
        }
        
        return currentCell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        let message = self.messages[indexPath.item]
        
        if indexPath.item > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == message.senderId {
                
                return nil
            }
        }
        
        return NSAttributedString(string: message.senderDisplayName)
    }

    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        let message = self.messages[indexPath.item]
        
        if indexPath.item > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == message.senderId {
                
                return 0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = self.messages[indexPath.item];
        
        var imageAvatar = UIImage()
        
        if message.media != nil && message.media.isKindOfClass(StructuredMessage) {
            
         return nil
        }
//        print(message)
        if message.senderId == self.senderId{
            
            // ### change image to Looplist userImage
            imageAvatar = UIImage(named: "User")!
        }else{
            imageAvatar = UIImage(named: "Loop")!
        }

        return JSQMessagesAvatarImageFactory.avatarImageWithImage(imageAvatar, diameter: 60);
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {

        let message = self.messages[indexPath.item];
        
        // first time add date
        if (indexPath.item == 0){

            let currentDate =  JSQMessagesTimestampFormatter.sharedFormatter().relativeDateForDate(message.date)
            let dateInAttributes: NSAttributedString = NSAttributedString(string: currentDate)
            
            return dateInAttributes
        }
        else if (indexPath.item > 0) {
            
            let previousMessage = self.messages[indexPath.item - 1];
              if(!HelperClass.compareTwoDates(message.date,date2: previousMessage.date)) {
                 let currentDate =  JSQMessagesTimestampFormatter.sharedFormatter().relativeDateForDate(message.date)
                 let dateInAttributes: NSAttributedString = NSAttributedString(string: currentDate)
                
                return dateInAttributes
            }
        }
        
        return nil
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        let message = self.messages[indexPath.item];
        
        if (indexPath.item == 0){
            
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        else if (indexPath.item > 0){
            let previousMessage = self.messages[indexPath.item - 1];
            
            if(!HelperClass.compareTwoDates(message.date,date2: previousMessage.date)) {
                
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            }
        }
        
        return 0.0
    }

    
}

// MARK: - Toolbar Functions

extension ViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        if let message = JSQMessage(senderId: senderId, senderDisplayName: senderId, date: date, text: text){
            
            self.postMessage(text)
            self.messages += [message]
            self.finishSendingMessageAnimated(true)
            
//            if self.messageUploadedToSmooch == true{
//                self.messages += [message]
//                self.finishSendingMessageAnimated(true)
//            }
//            self.messageUploadedToSmooch = false
            
        }
    }
    
    
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    

// MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let pickedImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.postPicture(pickedImage)
        dismissViewControllerAnimated(true, completion: nil)

    }
}







