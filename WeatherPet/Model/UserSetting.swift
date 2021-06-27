//
//  UserSetting.swift
//  WeatherPet
//
//  Created by Чистяков Василий Александрович on 25.06.2021.
//

import Foundation

final class UserSetting {
    
    private enum SettingKeys: String {
        case userCity
    }
    
    static var userCity: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKeys.userCity.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingKeys.userCity.rawValue
            if let city = newValue {
                print("value \(city) was added \(key)")
                defaults.set(city, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
