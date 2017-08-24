//
//  Car.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/2014.
//  Edited by Eric Cerney on 9/27/2014
//  Edited by Ray Fix on 4/12/2015.
//  Copyright (c) 2014-2105 Razeware, LLC. All rights reserved.
//

import Foundation

class Car : Vehicle {
  
  var isConvertible:Bool = false
  var isHatchback:Bool = false
  var hasSunroof:Bool = false
  var numberOfDoors:Int = 0
  
  override var vehicleDetails: String {
    // Get basic details from superclass
    let basicDetails = super.vehicleDetails
      
      // Initialize mutable string
      var carDetailsBuilder = "\n\nCar-Specific Details:\n\n"
      
      // String helpers for booleans
      let yes = "Yes\n"
      let no = "No\n"
      
      // Add info about car-specific features.
      carDetailsBuilder += "Has sunroof: "
      carDetailsBuilder += hasSunroof ? yes : no
      
      carDetailsBuilder += "Is Hatchback: "
      carDetailsBuilder += isHatchback ? yes : no
      
      carDetailsBuilder += "Is Convertible: "
      carDetailsBuilder += isConvertible ? yes : no
      
      carDetailsBuilder += "Number of doors: \(numberOfDoors)"
      
      // Create the final string by combining basic and car-specific details.
      let carDetails = basicDetails + carDetailsBuilder
      
      return carDetails
  }
  
  override init() {
    super.init()
    numberOfWheels = 4
  }
  
  // MARK: - Private method implementations
  private func start() -> String {
    return String(format: "Start power source %@.", powerSource)
  }
  
  // MARK:- Superclass Overrides
  override func goForward() -> String {
    return String(format: "%@ %@ Then depress gas pedal.", start(), changeGears("Forward"))
  }
  
  override func goBackward() -> String {
    return String(format: "%@ %@ Check your rear view mirror. Then depress gas pedal.", start(), changeGears("Reverse"))
  }
  
  override func stopMoving() -> String {
    return String(format: "Depress brake pedal. %@", changeGears("Park"))
  }
  
  override func makeNoise() -> String {
    return "Beep beep!"
  }
}