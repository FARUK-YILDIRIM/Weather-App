//
//  CityListViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit

protocol UpdateCityDelegate: AnyObject {
    func fetchWeather(byCity city: String)
    
}

class CityListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var cityDelegate: UpdateCityDelegate?
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        cityListArray()
        tableView.reloadData()
    }
    
    // MARK: - Helper Functions
    
    func cityListArray() -> [String]{
        let cityListArray = userDefaults.object(forKey: "cityList") as? [String] ?? [String]()
        return cityListArray
    }
    
    func returnCityFromTableView(_ index: Int) -> String {
        let cityListArray = cityListArray()
        return cityListArray[index]
    }
    
    func deleteCity(_ delete: Int) -> Void {
        var cityListArray = cityListArray()
        cityListArray.remove(at: delete)
        userDefaults.set(cityListArray, forKey: "cityList")
        
        tableView.reloadData()
        
        let alert = UIAlertController(title: "City Deleted", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addCity(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
}

// MARK: - UITableViewDataSource

extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cityListArray()[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CityListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCity(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.cityDelegate != nil  {
            cityDelegate?.fetchWeather(byCity: returnCityFromTableView(indexPath.row))
            self.navigationController?.popViewController(animated: true)
        }
    }
}
