//
//  WeatherDataUIModel.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//

import Foundation


struct WeatherDataUIModel {
    var temperatureValue: Double
    var temperatureUnit: String
    var epochTime: Int
    var weatherIconKey: Int
    var weatherText: String
    var isDayTime: Bool
}

struct CityDetailsUIModel {
    var cityKey: String
    var cityName: String
    var stateName: String
    var countryName: String
}
