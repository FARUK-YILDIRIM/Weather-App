//
//  CityListViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit

class CityListViewController: UIViewController {

    @IBAction func addCity(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
