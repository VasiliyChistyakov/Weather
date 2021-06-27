//
//  ViewController.swift
//  WeatherPet
//
//  Created by Чистяков Василий Александрович on 20.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var serchBar: UISearchBar!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    let netwrokingManager = NetworkWeatherManager()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serchBar.delegate = self
        
        tempLabel.isHidden = true
        cityLabel.isHidden = true
        weatherIconImageView.isHidden = true
        feelsLikeLabel.isHidden = true
        
        let defualtCity = fetchCities(city: (UserSetting.userCity) ?? " " )
        uploadCity(city: defualtCity)
    }
    
    func fetchCities (city: String) -> String {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        return urlString
    }
    
    func uploadCity (city: String) {
        netwrokingManager.fetchCurrentWeather(urlSting: city) { currentWeather in
            DispatchQueue.main.async {
                
                self.cityLabel.text = currentWeather.cityName 
                self.tempLabel.text = "\(currentWeather.temperatureString)°C"
                self.feelsLikeLabel.text = " Ощущаеться как \(currentWeather.feelsLikeTemperatureString)°C"
                self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
                
                self.cityLabel.isHidden = false
                self.feelsLikeLabel.isHidden = false
                self.tempLabel.isHidden = false
                self.weatherIconImageView.isHidden = false
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let serchText = searchBar.text!
        let serch = fetchCities(city: serchText)
        
        UserSetting.userCity = serchText
        
        uploadCity(city: serch)
    }
}

