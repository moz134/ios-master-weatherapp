//
//  WeatherProtocols.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 20/11/22.
//

import Foundation

protocol SearchCoordinatesDelegate {
    func searchCityUsingCoordinates(cityDetails: CityDetailsUIModel)
}

protocol SearchCityKeyDetailsDelegate {
    func searchCityKey(weatherDetails: WeatherDataUIModel)
}

protocol SearchCityNameDelegate {
    func searchCityName(cityDetails: CityDetailsUIModel)
}

protocol SuccessDataDelegate {
    func successData(citydDetails: CityDetailsUIModel, weatherDetails: WeatherDataUIModel)
}

