//
//  MasterViewController.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit

class VehicleListTableViewController: UITableViewController {
  
  var vehicles:[Vehicle] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupVehicleArray()
    title = "Vehicles"
  }
    
    // MARK: - Data setup
    func setupVehicleArray() {
        // Clear the array. (Start from scratch.)
        vehicles.removeAll(keepingCapacity: true)
        
        // Create a car.
        let mustang = Car()
        mustang.brandName = "Ford"
        mustang.modelName = "Mustang"
        mustang.modelYear = 1968
        mustang.isConvertible = true
        mustang.isHatchback = false
        mustang.hasSunroof = false
        mustang.numberOfDoors = 2
        mustang.powerSource = "gas engine"
        
        // Add it to the array
        vehicles.append(mustang)
        
        // Create another car.
        let outback = Car()
        outback.brandName = "Subaru"
        outback.modelName = "Outback"
        outback.modelYear = 1999
        outback.isConvertible = false
        outback.isHatchback = true
        outback.hasSunroof = false
        outback.numberOfDoors = 5
        outback.powerSource = "gas engine"
        
        // Add it to the array.
        vehicles.append(outback)
        
        // Create another car
        let prius = Car()
        prius.brandName = "Toyota"
        prius.modelName = "Prius"
        prius.modelYear = 2002
        prius.hasSunroof = true
        prius.isConvertible = false
        prius.isHatchback = true
        prius.numberOfDoors = 4
        prius.powerSource = "hybrid engine"
        
        // Add it to the array.
        vehicles.append(prius)
        
        // Create a motorcycle
        let harley = Motorcycle()
        harley.brandName = "Harley-Davidson"
        harley.modelName = "Softail"
        harley.modelYear = 1979
        harley.engineNoise = "Vrrrrrrrroooooooooom!"
        
        // Add it to the array.
        vehicles.append(harley)
        
        // Create another motorcycle
        let kawasaki = Motorcycle()
        kawasaki.brandName = "Kawasaki"
        kawasaki.modelName = "Ninja"
        kawasaki.modelYear = 2005
        kawasaki.engineNoise = "Neeeeeeeeeeeeeeeeow!"
        
        // Add it to the array
        self.vehicles.append(kawasaki)
        
        // Sort the array by the model year
        vehicles.sorted { $0.modelYear < $1.modelYear }
    }
  
  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let vehicle = vehicles[indexPath.row]
        (segue.destination as! VehicleDetailViewController).detailVehicle = vehicle
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vehicles.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
    
    let vehicle = vehicles[indexPath.row] as Vehicle
    cell.textLabel?.text = vehicle.vehicleTitle
    return cell
  }
}

