//
//  ViewController.swift
//  pogodynka
//
//  Created by Guest User on 16.10.2019.
//  Copyright © 2019 Mateusz Grzelinski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var weatherData: [Weather] = []
  var i: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Weather.getData(latitude: "19.9872", city: "None", longitude: "50.0527", completion:{ (results:[Weather]?) in
            if let weatherData = results {
                self.weatherData = weatherData
                DispatchQueue.main.async {
                    self.reloadWeather(i: self.i)
                }
                
            }
        })
    }

    @IBOutlet weak var iconName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var windVelocity: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var rain: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var city: UILabel!
    
    @IBAction func previousDay(_ sender: Any) {
       if(self.i < self.weatherData.count - 1) {
            self.i += 1
            self.reloadWeather(i: self.i)
        }
    }
    @IBAction func nextDay(_ sender: Any) {
       if(self.i > 0) {
            self.i -= 1
            self.reloadWeather(i: self.i)
        }
    }

    func reloadWeather(i: Int) {
        //self.??.text = self.formatDate(self.weatherData[i].timeStamp)
        self.weatherIcon.image = UIImage(named: self.weatherData[i].iconName)
        self.iconName.text = String(self.weatherData[i].iconName)
        self.tempMin.text = String(self.weatherData[i].tempMin)
        self.tempMax.text = String(self.weatherData[i].tempMax)
        self.windVelocity.text = String(self.weatherData[i].windVelocity)
        self.windDirection.text = String(self.weatherData[i].windDirection)
        self.rain.text = String(self.weatherData[i].rain)
        self.pressure.text = String(self.weatherData[i].pressure)
        self.city.text = String(self.weatherData[i].city)
    }
    
    func formatDate(unixtimeInterval: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: unixtimeInterval))
    }

}

