//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


NotificationCenter.default.addObserver(
    self,
    selector: #selector(CreditsPopUpViewController.applicationDidBecomeActive(notification:)),
    name: NSNotification.Name.UIApplicationDidBecomeActive,
    object: nil)

func applicationDidBecomeActive(notification: NSNotification) { // for apple pay
    // do something
    let indexPath = IndexPath(item: 3, section: 0)
    tableView.reloadRows(at: [indexPath], with: .none)
}



func addApplePayButton(){
    if let _ = self.applePayButton{
        
        var btnApplePay: PKPaymentButton
        let paymentNetworks: [PKPaymentNetwork] = [.amex, .masterCard, .visa]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            btnApplePay = PKPaymentButton(type: .buy, style: .black)
            btnApplePay.addTarget(self, action: #selector(self.buyWithApplePay), for: .touchUpInside)
            btnApplePay.frame = CGRect(x:0,y: 0, width:applePayButton.frame.width, height:self.applePayButton.frame.height)
            let bounds = applePayButton.bounds
            btnApplePay.center = CGPoint(x:bounds.midX, y:bounds.midY);
            
            self.applePayButton.addSubview(btnApplePay)
            self.applePayButton.bringSubview(toFront: btnApplePay)
        }else{
            btnApplePay = PKPaymentButton(type: .setUp, style: .black)
            btnApplePay.addTarget(self, action: #selector(self.setUpApplePay), for: .touchUpInside)
            btnApplePay.frame = CGRect(x:0,y: 0, width:applePayButton.frame.width, height:applePayButton.frame.height)
            let bounds = applePayButton.bounds
            btnApplePay.center = CGPoint(x:bounds.midX, y:bounds.midY);
            
            self.applePayButton.addSubview(btnApplePay)
            self.applePayButton.bringSubview(toFront: btnApplePay)
        }
    }
}



@IBOutlet weak var listingApplePayButton: UIButton!{
    
    didSet{
        if let listingApplePayButton = listingApplePayButton{
            if let userCredit = CurrentUser.sharedInstance.currentUser?.userCredit, userCredit.available.1 > 0, userCredit.available.1 > 0{
                // show select to buy
                listingApplePayButton.setTitle("Select", for: .normal)
            }else{
                // show apple pay button
                let paymentNetworks: [PKPaymentNetwork] = [.amex, .masterCard, .visa]
                
                if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
                    btnApplePay.frame = CGRect(x:0,y: 0, width:listingApplePayButton.frame.size.width, height: listingApplePayButton.frame.size.height)
                    btnApplePay.center = listingApplePayButton.center
                    
                    let bounds = listingApplePayButton.bounds
                    btnApplePay.center = CGPoint(x:bounds.midX, y:bounds.midY);
                    self.listingApplePayButton.backgroundColor = UIColor.clear
                    self.listingApplePayButton.addSubview(btnApplePay)
                    self.listingApplePayButton.bringSubview(toFront: btnApplePay)
                    
                }else{
                    listingApplePayButton.isUserInteractionEnabled = false
                    listingApplePayButton.setTitle("Details", for: .normal)
                }
            }
        }
    }
}