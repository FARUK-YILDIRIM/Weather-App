//
//  AddCityViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit


class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper Functions
    
    @IBAction func addCityButton(_ sender: Any) {
        guard let newCity = cityTextField.text, !newCity.isEmpty else {
            showError()
            return
        }
        
        var cityListarray = userDefaults.object(forKey: "cityList") as? [String] ?? [String]()
        cityListarray.append(cityTextField.text!)
        userDefaults.set(cityListarray, forKey: "cityList")
        self.dismiss(animated: true, completion: nil)
    }
    
    func showError() {
        errorLabel.isHidden = false
        errorLabel.text = "Please enter a city name."
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
