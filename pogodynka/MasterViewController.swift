//
//  MaterCiewController.swift
//  pogodynka
//
//  Created by Guest User on 06.11.2019.
//  Copyright © 2019 Mateusz Grzelinski. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MasterViewController: UITableViewController, UISearchBarDelegate {
    
    //@IBOutlet weak var citySearchBar: UISearchBar!
    
    var detailViewController: DetailViewController? = nil
    var weatherArray = [[Weather]]()
    var valueToPass:[Weather]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationWeather(cityName: "Warsaw")
        getLocationWeather(cityName: "Melbourne")
        getLocationWeather(cityName: "Novosibirsk")
        
        //citySearchBar.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        if let location = searchBar.text, !location.isEmpty {
//            getLocationWeather(cityName: location)
//        }
//    }
    
    func getLocationWeather(cityName: String) {
        CLGeocoder().geocodeAddressString(cityName) {
            (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather.getData(latitude: String(location.coordinate.latitude), city: cityName, longitude: String(location.coordinate.latitude),  completion: {
                        (results:[Weather]?) in
                        if let weatherRecord = results {
                            self.weatherArray.append(weatherRecord)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let tableVC = navVC.viewControllers.first as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        tableVC.weatherData = weatherArray[index!]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let weatherCell = weatherArray[indexPath.row]
        
        cell.textLabel!.text = weatherCell[0].city
        // todo display current temp, not min
        cell.detailTextLabel!.text = "Max temp \(Int(weatherCell[0].tempMax)) °C"
        cell.imageView?.image = UIImage(named: weatherCell[0].iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

