//
//  CityListViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit

class CityListViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        cityListArray()
        tableView.reloadData()
        print("cityListArray  \(cityListArray())" )
    }
    
    // MARK: - Helper Functions
    
    func cityListArray() -> [String]{
        let userDefaults = UserDefaults.standard
        let cityListArray = userDefaults.object(forKey: "cityList") as? [String] ?? [String]()
        return cityListArray
    }
    
    @IBAction func addCity(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
}

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
