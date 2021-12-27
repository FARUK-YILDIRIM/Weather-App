//
//  WeatherService.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 25.12.2021.
//

import Foundation
import Alamofire

final class WeatherService {
    
    static let shared = WeatherService()

    fileprivate let API_KEY = "9ca6d35a872d4078b15113527212412"
    fileprivate let BASE_URL = "https://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeather(byCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = String("\(self.BASE_URL)?key=\(API_KEY)&q=\(city)&days=1&aqi=no&alerts=no")
        handleRequest(urlString: urlString, completion: completion)
    }
    
    private func handleRequest(urlString: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: WeatherModel.self, queue: .main, decoder: JSONDecoder()) { (response) in
                print(response)
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
            }
        }
    }
    
}

