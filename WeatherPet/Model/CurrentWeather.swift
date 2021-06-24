//
//  CurrentWeather.swift
//  WeatherPet
//
//  Created by Чистяков Василий Александрович on 24.06.2021.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(CurrentWeatherData: CurrentWeatherData) {
        cityName = CurrentWeatherData.name
        temperature = CurrentWeatherData.main.temp
        feelsLikeTemperature = CurrentWeatherData.main.feelsLike
        conditionCode = CurrentWeatherData.weather.first!.id
    }
}
