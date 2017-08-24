//
//  DetailViewController.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/2014.
//  Edited by Eric Cerney on 9/27/2014
//  Edited by Ray Fix on 4/12/2015.
//  Copyright (c) 2014-2105 Razeware, LLC. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  
  var detailVehicle: Vehicle? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
   
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
    
  func configureView() {
    // Update the user interface for the detail item.
    if let vehicle = detailVehicle {
      title = vehicle.vehicleTitle
      detailDescriptionLabel?.text = vehicle.vehicleDetails
    }
  }

  @IBAction func goForward(sender: AnyObject) {
    // TODO: Fill this in.
  }
  
  @IBAction func goBackward(sender: AnyObject) {
    // TODO: Fill this in.
  }
  
  @IBAction func stopMoving(sender: AnyObject) {
    // TODO: Fill this in.
  }
  
  @IBAction func turn(sender: AnyObject) {
    // TODO: Fill this in.
  }
  
  @IBAction func makeNoise(sender: AnyObject) {
    // TODO: Fill this in.
  }
  
}
