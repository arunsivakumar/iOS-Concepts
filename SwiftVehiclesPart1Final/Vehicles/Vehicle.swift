//
//  Vehicle.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/2014.
//  Edited by Eric Cerney on 9/27/2014
//  Edited by Ray Fix on 4/12/2015.
//  Copyright (c) 2014-2105 Razeware, LLC. All rights reserved.
//

import Foundation

class Vehicle {
  
  var brandName = "null"
  var modelName = "null"
  var modelYear = 0
  var powerSource = "null"
  var numberOfWheels = 0
  
  // MARK: - Computed Properties
    
  var vehicleTitle: String {
    return String(format:"%d %@ %@", modelYear, brandName,modelName)
  }
    
  var vehicleDetails: String {
    var details = ""
    details += "Basic vehicle details:\n\n"
    details += "Brand name: \(brandName)\n"
    details += "Model name: \(modelName)\n"
    details += "Model year: \(modelYear)\n"
    details += "Power source: \(powerSource)\n"
    details += "# of wheels: \(numberOfWheels)\n"
    return details
  }
    
  // MARK: - Public Methods
    
  func goForward() -> String {
    return "null"
  }
  
  func goBackward() -> String {
    return "null"
  }
  
  func stopMoving() -> String {
    return "null"
  }
  
  func turn(degrees:Int) -> String {
    var normalizedDegrees = degrees
    
    // Since there are only 360 degrees in a circle, calculate what a single turn would be.
    let degreesInACircle = 360
  
    if (normalizedDegrees > degreesInACircle || normalizedDegrees < -degreesInACircle) {
      // The % operator returns the remainder after dividing.
      normalizedDegrees = normalizedDegrees % degreesInACircle
    }
  
    return String(format: "Turn %d degrees.", normalizedDegrees)
  }
  
  func changeGears(newGearName:String) -> String {
    return String(format: "Put %@ into %@ gear.",self.modelName, newGearName)
  }
  
  func makeNoise() -> String {
    return "null"
  }
  
}

