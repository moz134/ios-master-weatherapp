//
//  WeatherDataManager.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 20/11/22.
//

import Foundation

class WeatherDataManager {
    static let instance = WeatherDataManager()
    private init() {
        //
    }
    var listCities: [String] = []

    func updateRecentSearch(str: String) {
        if self.listCities.count < 5 {
            self.listCities.append(str.capitalized)
            self.listCities = Array(Set(listCities))
        } else {
            self.listCities[0] = str
        }
        UserDefaults.standard.set(listCities, forKey: "listCities")
    }

    func fetchRecentSearch() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "listCities") ?? listCities
    }
    
}
