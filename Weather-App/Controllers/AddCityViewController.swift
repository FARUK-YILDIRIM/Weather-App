//
//  AddCityViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit


class AddCityViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var cityTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
  
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.9)
    }

    // MARK: - Helper Functions
    
    @IBAction func addCityButton(_ sender: Any) {
        var array = userDefaults.object(forKey: "cityList") as? [String] ?? [String]()
        array.append(cityTextField.text!)
        userDefaults.set(array, forKey: "cityList")

        self.dismiss(animated: true, completion: nil)

    }
    

}
