//
//  MapLocationTableViewCell.swift
//  Map
//
//  Created by Arun Sivakumar on 7/12/17.
//  Copyright © 2017 Arun Sivakumar. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class MapLocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var detailedLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
  
    
    var locationItem:MKMapItem?{
        didSet{
        
            guard let locationItem = locationItem else { return }
            
            let placemark = locationItem.placemark
            locationLabel?.text = placemark.name
            detailedLabel?.text = parseAddress(selectedItem: placemark)
        
        }
    }
    
    private func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
