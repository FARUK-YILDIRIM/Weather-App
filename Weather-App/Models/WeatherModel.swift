//
//  WeatherModel.swift
//  Weather-App
//
//  Created by Faruk YILDIRIM on 25.12.2021.
//

import Foundation

struct WeatherModel: Codable {
    
    var location: Location
    var current: Current
    var forecast: Forecast
    
    // MARK: - Location
    
    struct Location: Codable {
        let name: String
        let lat: Double
        let lon: Double
        let localtime: String
    }
    
    // MARK: - Current
    
    struct Current: Codable {
        let temp_c: Double
        let condition: Condition
        let pressure_in: Double
        let humidity: Double
        let vis_km: Double
        let last_updated: String
        
        struct Condition: Codable {
            let text: String
            let icon: String
        }
    }
    
    // MARK: - Forecast
    
    struct Forecast: Codable {
        let forecastday: [Forecastday]
    }
    
    struct Forecastday: Codable {
        let hour: [Hour]
        let date: String
    }
    
    struct Hour: Codable {
        let time: String
        let condition: Condition
        
        struct Condition: Codable {
            let text: String
            let icon: String
        }
    }
}


