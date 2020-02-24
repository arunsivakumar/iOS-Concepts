//
//  ViewController.swift
//  Map
//
//  Created by Arun Sivakumar on 7/12/17.
//  Copyright © 2017 Arun Sivakumar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Search State for the Search Bar
private enum SearchState{
   case DefaultMode
   case SearchMode
}

class MapViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitLocationButton: UIButton!{
        didSet{
            submitLocationButton.layer.cornerRadius = 10.0
            submitLocationButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
            submitLocationButton.isHidden = true
        }
    }
    
    
    //MARK:- Variables
    fileprivate var searchState:SearchState = .SearchMode{
        didSet{
            
            searchTerm = searchBar.text!
            
            switch searchState {
            case .DefaultMode:
                showSubmitButton()
                searchBarEndEditing()
                tableView.isHidden = true
            case .SearchMode:
                hideSubmitButton()
                tableView.isHidden = false
            }
        }
    }
    
    
    fileprivate var locationItems:[MKMapItem] = [] {
        didSet{
        self.tableView.reloadData()
        }
    }
    

    
    private func resetSearch(){
        locationItems = []
    }
    
    private func searchBarEndEditing(){
        searchBar.endEditing(true)
    }
    
    private var searchTerm = ""{
        didSet{
            // Update the entities based on the saearch Term
        
            if searchTerm == ""{
                resetSearch()
            }else{
                fetchLocations(from:searchTerm)
            }
        }
    }
    
    private let locationManager = CLLocationManager()
    
    //var resultSearchController:UISearchController? = nil
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        searchState = .DefaultMode
        setUp()
    }
    
     //MARK:- Functions
    
    // Initial Setup
    
    private func setUp(){
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
    }
    
    private func fetchLocations(from textToSearch:String){
        
        let textToSearch = searchTerm
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = textToSearch
        //erequest.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if textToSearch == self.searchTerm{
                search.start { [weak vc = self]( response,_) -> Void in
                    guard let response = response,textToSearch == vc?.searchTerm  else {
                        return
                    }
                    vc?.locationItems = response.mapItems
                }
            }
        }
    }
    
    private var userSelectedLocation:MKMapItem?{
        didSet{
            if let userSelectedLocation = userSelectedLocation {
                setPinOnMap(for:userSelectedLocation.placemark)
                showSubmitButton()
            }else{
                hideSubmitButton()
            }
        }
    }
    
    private func showSubmitButton(){
        if userSelectedLocation  != nil {
            self.submitLocationButton.isHidden = false
            self.view.bringSubview(toFront: submitLocationButton)
        }

    }
    
    private func hideSubmitButton(){
        self.submitLocationButton.isHidden = true
        self.view.sendSubview(toBack: submitLocationButton)
    }
    
    func setPinOnMap(for placemark:MKPlacemark){
        
       
        // clear old pin
        mapView.removeAnnotations(mapView.annotations)
        
        // make new pin and add
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        // set the region
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    // user authorization
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation() // request location after the authorization
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first { // array of location items
            print("location:\(location)")
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error)")
    }
}

extension  MapViewController: UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return locationItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapLocationTableViewCell") as! MapLocationTableViewCell
        cell.locationItem = locationItems[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        searchState = .DefaultMode
        userSelectedLocation = locationItems[selectedIndexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

// MARK:- Search Bar Delegates
extension  MapViewController: UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchState = .SearchMode
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchState = .DefaultMode
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarEndEditing()
    }
}
