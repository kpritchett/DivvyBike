//
//  ViewController.swift
//  Divvy Bike
//
//  Created by Student on 10/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var myTableView: UITableView!

    
    var stations = [[String: String]]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let urlString = "https://www.divvybikes.com/stations/json/"
        if let url = URL(string: urlString)
        {
            //returns data object from URL
            if let myData = try? Data(contentsOf: url, options: [])
            {
                //if data object was created, we created a json object from library
                let json = JSON(data: myData)
                
                    print("OK to parse")
                    parse(json)
            }
        }
    }
    
    func parse(_ json: JSON)
    {
        for list in json["stationBeanList"].arrayValue
        {
            print("parse is working")
            //grabs the name, available docks, total docks, longitude, and latitude fron the API
            let stationName = list["stationName"].stringValue
            let availableDocks = list["availableDocks"].stringValue
            let totalDocks = list["totalDocks"].stringValue
            let latitude = list["latitude"].stringValue
            let longitude = list["longitude"].stringValue
            
            let obj = ["stationName": stationName, "availableDocks": availableDocks, "totalDocks": totalDocks, "latitude": latitude, "longitude": longitude]
            
            //places the data in the array
            stations.append(obj as! [String : String])
        }
        myTableView.reloadData()
    }
    
    //creates a tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //adds cells to the tableview and inserts required information
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let station = stations[indexPath.row]
        cell.textLabel!.text = station["stationName"]
        cell.detailTextLabel!.text = "Available Docks: " + station["availableDocks"]! + "  Total Docks: " + station["totalDocks"]!
        return cell
    }
    //carries over the stations array to the detailcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = myTableView.indexPathForSelectedRow
        {
            let station = stations[indexPath.row]
            let nextController = segue.destination as! DetailController
            nextController.detailItem = station
        }
    }
}

