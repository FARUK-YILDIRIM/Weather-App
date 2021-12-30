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
    fileprivate let BASE_URL = "https://api.weatherapi.com/v1/"
    
    
    func fetchWeather(byCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = String("\(self.BASE_URL)forecast.json?key=\(API_KEY)&q=\(city)&days=1&aqi=no&alerts=no")
        handleRequest(urlString: urlString, completion: completion)
    }
    
    func fetchWeather(lat: Double,lon: Double, completion: @escaping (Result<[SearchModel], Error>) -> Void) {
        let urlString = String("\(self.BASE_URL)search.json?key=\(API_KEY)&q=\(lat),\(lon)")
        handleRequest(urlString: urlString, completion: completion)
    }
    
    // MARK: - SearchModel Handle Request
    private func handleRequest(urlString: String, completion: @escaping (Result<[SearchModel], Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: [SearchModel].self, queue: .main, decoder: JSONDecoder()) { (response) in
                print(response)
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    // MARK: - WeatherModel Handle Request
    private func handleRequest(urlString: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: WeatherModel.self, queue: .main, decoder: JSONDecoder()) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

