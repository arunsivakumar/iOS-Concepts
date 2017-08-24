//
//  ViewController.swift
//  WhaleTalk
//
//  Created by Arun on 4/10/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
//    private let tableView = UITableView()
    
    private let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    private let newMessageField = UITextView()
    
//    private var messages = [Message]()
    private var sections = [NSDate:[Message]]()
    private var dates = [NSDate]()
    
    private var bottomConstraint: NSLayoutConstraint!
    
    private let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

    
        
        tableView.delegate = self
        
        //7
        tableView.estimatedRowHeight = 44
        
        // add this variable above the loop
        var localIncoming = true
        //12
        var date = NSDate(timeIntervalSince1970: 1100000000)
        
        for i in 0...10 {
            let m = Message()
//            m.text = String(i)
            m.text = "this is a longer Message"
            m.timestamp = date
//            messages.append(m)
            //12
            addMessage(m)
            
                // inside the loop we will add these 2 new lines right above `messages.append(m)`
            m.incoming = localIncoming
            localIncoming = !localIncoming
            
            if i%2 == 0{
                //every other message will be a day later
                date = NSDate(timeInterval: 60 * 60 * 24, sinceDate: date)
            }

        }
        
        //8 
        
        let newMessageArea = UIView()
        newMessageArea.backgroundColor = UIColor.lightGrayColor()
        newMessageArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newMessageArea)
        
        newMessageField.translatesAutoresizingMaskIntoConstraints = false
        newMessageArea.addSubview(newMessageField)
        
        newMessageField.scrollEnabled = false
        
        let sendButton = UIButton()
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        newMessageArea.addSubview(sendButton)
        
        sendButton.setTitle("Send", forState: .Normal)
        
        //10
        sendButton.addTarget(self, action: Selector("pressedSend:"), forControlEvents:.TouchUpInside)

        
        sendButton.setContentHuggingPriority(251, forAxis: .Horizontal)
        //9
        sendButton.setContentCompressionResistancePriority(751, forAxis: .Horizontal)
        
        bottomConstraint = newMessageArea.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        bottomConstraint.active = true
        
        let messageAreaConstraints:[NSLayoutConstraint] = [
            newMessageArea.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            newMessageArea.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
//            newMessageArea.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
//            newMessageArea.heightAnchor.constraintEqualToConstant(50)
            //8
            newMessageField.leadingAnchor.constraintEqualToAnchor(newMessageArea.leadingAnchor,constant:10),
            newMessageField.centerYAnchor.constraintEqualToAnchor(newMessageArea.centerYAnchor),
            sendButton.trailingAnchor.constraintEqualToAnchor(newMessageArea.trailingAnchor, constant:-10),
            newMessageField.trailingAnchor.constraintEqualToAnchor(sendButton.leadingAnchor,constant: -10),
            sendButton.centerYAnchor.constraintEqualToAnchor(newMessageField.centerYAnchor),
            newMessageArea.heightAnchor.constraintEqualToAnchor(newMessageField.heightAnchor, constant:20)
        ]
        
        NSLayoutConstraint.activateConstraints(messageAreaConstraints)
        
      

        
//        for eachMessage in messages {
//            print(eachMessage, ":", eachMessage.text)
//        }
        
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        //4
         tableView.registerClass(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let tableViewConstraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
//            tableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
            //8
            tableView.bottomAnchor.constraintEqualToAnchor(newMessageArea.topAnchor)
        ]
        
        NSLayoutConstraint.activateConstraints(tableViewConstraints)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: Selector("keyboardWillShow:"),
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: Selector("keyboardWillHide:"),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
        
        let tapRecognizer = UITapGestureRecognizer(target:self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapRecognizer)
        
   
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.scrollToBottom()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        updateBottomConstraint(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        updateBottomConstraint(notification)
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        if let
//            userInfo = notification.userInfo,
//            frame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue,
//            animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
//            let newFrame = view.convertRect(frame, fromView: (UIApplication.sharedApplication().delegate?.window)!)
//            bottomConstraint.constant = newFrame.origin.y - CGRectGetHeight(view.frame)
//            UIView.animateWithDuration(animationDuration, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }
//    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func updateBottomConstraint(notification: NSNotification) {
        if let
            userInfo = notification.userInfo,
            frame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue,
            animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
            let newFrame = view.convertRect(frame, fromView: (UIApplication.sharedApplication().delegate?.window)!)
            bottomConstraint.constant = newFrame.origin.y - CGRectGetHeight(view.frame)
            UIView.animateWithDuration(animationDuration, animations: {
                self.view.layoutIfNeeded()
            })
            //10
            tableView.scrollToBottom()
        }
    }
    
    //10
    func pressedSend(button:UIButton){
        guard let text = newMessageField.text where text.characters.count > 0 else {return}
        let message = Message()
        message.text = text
        message.incoming = false
        message.timestamp = NSDate()
//        messages.append(message)
        addMessage(message)
        newMessageField.text = ""
        tableView.reloadData()
//        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: tableView.numberOfRowsInSection(0)-1, inSection: 0), atScrollPosition: .Bottom, animated: true)
            tableView.scrollToBottom()
        view.endEditing(true)
    }
    
    //12
    
    func addMessage(message:Message){
        guard let date = message.timestamp else {return}
        let calendar = NSCalendar.currentCalendar()
        let startDay = calendar.startOfDayForDate(date)
        //we group messages by the day so we'll use the start of the day
        
        var messages = sections[startDay]
        if  messages == nil{
            dates.append(startDay)
            messages = [Message]()
        }
        messages!.append(message)
        sections[startDay] = messages
    }
    
    


}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        let paddingView = UIView()
        view.addSubview(paddingView)
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        paddingView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints:[NSLayoutConstraint] = [
            paddingView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            paddingView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            dateLabel.centerXAnchor.constraintEqualToAnchor(paddingView.centerXAnchor),
            dateLabel.centerYAnchor.constraintEqualToAnchor(paddingView.centerYAnchor),
            paddingView.heightAnchor.constraintEqualToAnchor(dateLabel.heightAnchor, constant: 5),
            paddingView.widthAnchor.constraintEqualToAnchor(dateLabel.widthAnchor, constant: 10),
            view.heightAnchor.constraintEqualToAnchor(paddingView.heightAnchor)
        ]
        NSLayoutConstraint.activateConstraints(constraints)
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        dateLabel.text = formatter.stringFromDate(dates[section])
        
        paddingView.layer.cornerRadius = 10
        paddingView.layer.masksToBounds = true
        paddingView.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
        
        
        return view
    }
    
    func getMessages(section: Int)->[Message]{
        let date = dates[section]
        return sections[date]!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
        return getMessages(section).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:indexPath) as! ChatCell
        let messages = getMessages(indexPath.section)
        let message  = messages[indexPath.row]
        // 4 
//        cell.textLabel?.text = message.text
        cell.messageLabel.text = message.text
        cell.incoming(message.incoming)
        cell.separatorInset = UIEdgeInsetsMake(0, tableView.bounds.size.width, 0, 0)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension ChatViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}


