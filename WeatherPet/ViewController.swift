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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serchBar.delegate = self
        tempLabel.isHidden = true
        cityLabel.isHidden = true
        weatherIconImageView.isHidden = true
        feelsLikeLabel.isHidden = true
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchBar.text!)&appid=\(apiKey)&units=metric"
        // print(serchBar.text!)
        // print(urlString)
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Mine.self, from: data)
                   // print(json.main.temp)
                    let conditionCode: Int = json.weather.first!.id
                    
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
                    DispatchQueue.main.async {
                        self.cityLabel.text = (json.name)
                        self.tempLabel.text = "\(String(format: "%.0f", json.main.temp))℃"
                        self.feelsLikeLabel.text = "Oщущается как \(String(format: "%.0f",json.main.feelsLike)) ℃"
                        self.weatherIconImageView.image = UIImage(systemName: systemIconNameString)
                        self.cityLabel.isHidden = false
                        self.tempLabel.isHidden = false
                        self.feelsLikeLabel.isHidden = false
                        self.weatherIconImageView.isHidden = false
                    }
                } catch let error {
                    let alletController = UIAlertController(title: "Ошибка", message: "Неверное название города", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alletController.addAction(okAction)
                    print(error)
                    
                    DispatchQueue.main.async {
                        self.present(alletController, animated: true, completion: nil)
                    }
                }
            }
        }.resume()
    }
}
