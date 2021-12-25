//
//  ViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBAction func addCity(_ sender: Any) {
        performSegue(withIdentifier: "showCityListPanel", sender: nil)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

