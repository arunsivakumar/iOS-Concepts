//
//  Motorcylce.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/2014.
//  Edited by Eric Cerney on 9/27/2014
//  Edited by Ray Fix on 4/12/2015.
//  Copyright (c) 2014-2105 Razeware, LLC. All rights reserved.
//

import Foundation

class Motorcycle : Vehicle {
  
  var engineNoise = ""
  
  override var vehicleDetails:String {
    // Get basic details from superclass
    let basicDetails = super.vehicleDetails
      
      // Initialize mutable string
      var motorcycleDetailsBuilder = "\n\nMotorcycle-Specific Details:\n\n"
      
      // Add info about motorcycle-specific features.
      motorcycleDetailsBuilder += "Engine Noise: \(engineNoise)"
      
      let motorcycleDetails = basicDetails + motorcycleDetailsBuilder
      
      return motorcycleDetails
  }
  
  override init() {
    super.init()
    numberOfWheels = 2
    powerSource = "gas engine"
  }
  
  // MARK: - Superclass Overrides
  override func goForward() -> String {
    return String(format: "%@ Open throttle.", changeGears("Forward"))
  }

  override func goBackward() -> String {
    return String(format: "%@ Walk %@ backwards using feet.", changeGears("Neutral"), modelName)
  }
  
  override func stopMoving() -> String {
    return "Squeeze brakes"
  }

  override func makeNoise() -> String {
    return self.engineNoise
  }
}

