//
//  APIService.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//

import Foundation
import UIKit

class APIService {

    var fetchCurrentDelegate: SearchCoordinatesDelegate?
    var fetchCityDetailsDelegate: SearchCityKeyDetailsDelegate?
    var searchCityNameDelegate: SearchCityNameDelegate?

    func fetchCurrentLocationKey(lat: Double, long: Double) {
        let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(Constants.apiKey)&q=\(lat),\(long)")!
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error  {

            } else if let data = data {
                print(data)
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode(CitySearchResponseModel.self, from: data)
                    self.fetchCurrentDelegate?.searchCityUsingCoordinates(cityDetails: CityDetailsUIModel(cityKey: response.key, cityName: response.englishName, stateName: response.administrativeArea.EnglishName, countryName: response.country.EnglishName))
                } catch {
                    print("Error in decoding!")
                }
            }

        }.resume()
    }

    func fetchCityDetails(cityKey: String) {
        let url = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/\(cityKey)?apikey=\(Constants.apiKey)")!
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                print(data)
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode([CityWeatherConditionResponse].self, from: data)
                    let resp = response.first
                    self.fetchCityDetailsDelegate?.searchCityKey(weatherDetails: WeatherDataUIModel(temperatureValue: resp?.temperature.Metric.Value ?? 0, temperatureUnit: resp?.temperature.Metric.Unit ?? "", epochTime: resp?.epochTime ?? 0, weatherIconKey: resp?.weatherIcon ?? 0, weatherText: resp?.weatherText ?? "", isDayTime: resp?.isDayTime ?? false))
                } catch {
                    print("error occured")
                }
            }
        }.resume()
    }

    func searchCity(cityName: String) {
        let cityNameStr = String(cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Nagpur")
        let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/search?q=\(cityNameStr)&apikey=\(Constants.apiKey)")!
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode([CitySearchResponseModel].self, from: data)
                    let resp = response.first
                    self.searchCityNameDelegate?.searchCityName(cityDetails: CityDetailsUIModel(cityKey: resp?.key ?? "", cityName: resp?.englishName ?? "", stateName: resp?.administrativeArea.EnglishName ?? "", countryName: resp?.country.EnglishName ?? ""))
                } catch {
                    print("error occured")
                }
            }
        }.resume()

    }
}
