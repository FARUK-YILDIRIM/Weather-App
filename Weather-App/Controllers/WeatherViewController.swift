//
//  ViewController.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 24.12.2021.
//

import UIKit
import Kingfisher
import SkeletonView

class WeatherViewController: UIViewController, UpdateCityDelegate {
    
    // MARK: - Properties
    var weatherService = WeatherService.shared
    var forecastHourlyWeather = [ForecastCondition]()
    
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var localtimeLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather(byCity: "Ankara")
        tableView.dataSource = self
        
        conditionImage.isSkeletonable = true
        temperatureLabel.isSkeletonable = true
        cityNameLabel.isSkeletonable = true
        localtimeLabel.isSkeletonable = true
        humidityLabel.isSkeletonable = true
        visibilityLabel.isSkeletonable = true
        pressureLabel.isSkeletonable = true
        tableView.isSkeletonable = true
        
        showSkeletonAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityListPanel" {
            let vc = segue.destination as! CityListViewController
            vc.cityDelegate = self
        }
    }
    // MARK: - API
    
     func fetchWeather(byCity city: String) {
        showSkeletonAnimation()
        weatherService.fetchWeather(byCity: city) { (result) in
            self.handleResult(result)
        }
    }
    
     private func handleResult(_ result: Result<WeatherModel, Error>) {
        switch result {
        case .success(let model):
            updateView(with: model)
        case .failure(let error):
            handleError(error)
        }
    }
    
     private func handleError(_ error: Error) {
         conditionImage.image = UIImage(named: "imSad")
         cityNameLabel.text = "City Not Found"
         localtimeLabel.text = "The system is not responding."
         conditionLabel.text = ""
         temperatureLabel.text = "Oops!"
         humidityLabel.text = "Error"
         visibilityLabel.text = "Error"
         pressureLabel.text = "Error"
         tableView.isHidden = true
         hideSkeletonAnimation()
     }
    
    // MARK: - Helper Functions
    
    private func updateView(with model: WeatherModel) {
        hideSkeletonAnimation()
        tableView.isHidden = false
        conditionImage.kf.setImage(with: URL(string: String("https:" + model.current.condition.icon)))
        temperatureLabel.text = String(model.current.temp_c).appending("°C")
        conditionLabel.text = model.current.condition.text
        cityNameLabel.text = model.location.name
        localtimeLabel.text = String("\(self.showToday()), \(stringParseForTime(str: model.location.localtime))")
        humidityLabel.text = String(model.current.humidity)
        visibilityLabel.text = String(model.current.vis_km).appending(" KM")
        pressureLabel.text = String(model.current.pressure_in).appending(" in")
        
        DispatchQueue.main.async {
            for i in 1 ..< model.forecast.forecastday[0].hour.count {
                self.forecastHourlyWeather.append(ForecastCondition(
                    time: model.forecast.forecastday[0].hour[i].time,
                    text: model.forecast.forecastday[0].hour[i].condition.text,
                    icon: model.forecast.forecastday[0].hour[i].condition.icon
                    
                    )
                )
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func stringParseForTime(str: String) -> String {
        let components = str.components(separatedBy: " ")
        return components[1]
    }
    
    private func showToday() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    private func showSkeletonAnimation(){
        conditionImage.showAnimatedGradientSkeleton()
        temperatureLabel.showAnimatedGradientSkeleton()
        cityNameLabel.showAnimatedGradientSkeleton()
        localtimeLabel.showAnimatedGradientSkeleton()
        humidityLabel.showAnimatedGradientSkeleton()
        visibilityLabel.showAnimatedGradientSkeleton()
        pressureLabel.showAnimatedGradientSkeleton()
        tableView.showAnimatedGradientSkeleton()
    }
    
    private func hideSkeletonAnimation(){
        conditionImage.hideSkeleton()
        conditionImage.hideSkeleton()
        temperatureLabel.hideSkeleton()
        cityNameLabel.hideSkeleton()
        localtimeLabel.hideSkeleton()
        humidityLabel.hideSkeleton()
        visibilityLabel.hideSkeleton()
        pressureLabel.hideSkeleton()
        tableView.hideSkeleton()
    }
    
    @IBAction func addCity(_ sender: Any) {
        performSegue(withIdentifier: "showCityListPanel", sender: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastHourlyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        
        if forecastHourlyWeather.count > 0 && indexPath.row < forecastHourlyWeather.count {
            cell.forecastImage.kf.setImage(with: URL(string: String("https:" + forecastHourlyWeather[indexPath.row].icon)))
            cell.forecastTime.text = stringParseForTime(str: forecastHourlyWeather[indexPath.row].time)
            cell.forecastCondition.text = forecastHourlyWeather[indexPath.row].text
        }
        return cell
    }
}

// MARK: - UITableViewCell

class WeatherCell: UITableViewCell {
    
@IBOutlet weak var forecastImage: UIImageView!
@IBOutlet weak var forecastTime: UILabel!
@IBOutlet weak var forecastCondition: UILabel!
    
}
