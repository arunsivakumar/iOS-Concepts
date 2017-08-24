//
//  MapPickerHelper.swift
//  Selfcare
//
//  Created by Arun Sivakumar on 8/12/17.
//  Copyright © 2017 Liberty Wireless Ltd. All rights reserved.
//

import Foundation
import GooglePlacePicker

class UserLocation{
    var location: String = ""
    var latitude: CGFloat = 0
    var longitude: CGFloat = 0
    var accuracy: String = ""
//    
//    init(location:String,latitude:CGFloat,longitude:CGFloat,accuracy:String) {
//        self.location = location
//        self.latitude = latitude
//        self.longitude = longitude
//        self.accuracy = accuracy
//    }
}

typealias MapLocationPickerHelperCallback  = (UserLocation?) -> Void



class MapLocationPickerHelper: NSObject{
    
    weak var viewController:UIViewController!
    var callback:MapLocationPickerHelperCallback
    
    init(viewController: UIViewController,callback:@escaping MapLocationPickerHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        super.init()
        
        self.showPlacePickerView()
    }
    
    func showPlacePickerView() {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        self.viewController.present(placePicker, animated: true, completion: nil)
    }
}

extension MapLocationPickerHelper : GMSPlacePickerViewControllerDelegate
{
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print("picked")
        print("Place name \(place.name)")
        print("Place address \(place.formattedAddress)")
        print("Place attributions \(place.attributions)")
        
        print("Place latitude \(place.coordinate.latitude)")
        print("Place longitude \(place.coordinate.longitude)")
        
        let userLocation = UserLocation()
        callback(userLocation)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("cancelled")
    }
}

