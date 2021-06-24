//
//  NetworkWeatherManager.swift
//  WeatherPet
//
//  Created by Чистяков Василий Александрович on 23.06.2021.
//

import Foundation
import UIKit

struct NetworkWeatherManager {
    
    func fetchCurrentWeather (urlSting url: String, complitionHandler: @escaping (CurrentWeather)-> Void)  {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                
                if let currentWeather = self.parseJson(withData: data) {
                    complitionHandler(currentWeather)
                }
            }
        } .resume()
    }
    
    func parseJson(withData data: Data) -> CurrentWeather? {
        
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(CurrentWeatherData:currentWeatherData)  else {
                return nil
            }
            return currentWeather 
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
