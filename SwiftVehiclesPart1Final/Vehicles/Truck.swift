//
//  Truck.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/2014.
//  Edited by Eric Cerney on 9/27/2014
//  Edited by Ray Fix on 4/12/2015.
//  Copyright (c) 2014-2105 Razeware, LLC. All rights reserved.
//

import Foundation

class Truck : Vehicle {
  var cargoCapacityCubicFeet:Int = 0
  
  override var vehicleDetails: String {
    // Get basic details from superclass
    let basicDetails = super.vehicleDetails
      
      // Initialize mutable string
      var truckDetailsBuilder = "\n\nTruck-Specific Details:\n\n"
      
      // Add info about truck-specific features.
      truckDetailsBuilder += "Cargo Capacity: \(cargoCapacityCubicFeet) cubic feet"
      
      // Create the final string by combining basic and truck-specific details.
      let truckDetails = basicDetails + truckDetailsBuilder
      
      return truckDetails
  }
  
  // MARK: - Superclass overrides
  override func goForward() -> String {
    return String(format:"%@ Depress gas pedal.", changeGears("Drive"))
  }
  
  override func stopMoving() -> String {
    return String(format:"Depress brake pedal. %@", changeGears("Park"))
  }
  
  override func goBackward() -> String {
    if cargoCapacityCubicFeet > 100 {
      // Sound a backup alarm first
      return String(format:"Wait for \"%@\", then %@", soundBackupAlarm(), changeGears("Reverse"))
    } else {
      return String(format:"%@ Depress gas pedal.", changeGears("Reverse"))
    }
  }
  
  override func makeNoise() -> String {
    switch numberOfWheels {
    case Int.min...4:
      return "Beep beep!"
    case 5...8:
      return "Honk!"
    default:
      return "HOOOOOOOOONK!"
    }
  }
  
  // MARK: - Private methods
  private func soundBackupAlarm() -> String {
    return "Beep! Beep! Beep! Beep!"
  }
}