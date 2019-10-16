//
//  ViewController.swift
//  pogodynka
//
//  Created by Guest User on 16.10.2019.
//  Copyright © 2019 Mateusz Grzelinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var windVelocity: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var rain: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBAction func previousDay(_ sender: Any) {
    }
    @IBAction func nextDay(_ sender: Any) {
    }
    
    // class var shared: URLSession { get { return URLP{} } }
    // https://www.metaweather.com/api/location/44418/

}

