//
//  WeatherViewModel.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//


import Foundation


class WeatherViewModel: SearchCoordinatesDelegate, SearchCityKeyDetailsDelegate, SearchCityNameDelegate {
    var cityDetails: CityDetailsUIModel?
    private var apiService = APIService()
    var delegate: SuccessDataDelegate?

    func callCurrentLocationSearchAPI(lat: Double, long: Double) {
        apiService.fetchCurrentDelegate = self
        apiService.fetchCurrentLocationKey(lat: lat, long: long)
    }

    func callFetchCityDetailsAPI(cityKey: String) {
        apiService.fetchCityDetailsDelegate = self
        apiService.fetchCityDetails(cityKey: cityKey)
    }

    func callSearchCityNameAPI(cityName: String) {
        apiService.searchCityNameDelegate = self
        apiService.searchCity(cityName: cityName)
    }

    func searchCityName(cityDetails: CityDetailsUIModel) {
        self.cityDetails = cityDetails
        self.callFetchCityDetailsAPI(cityKey: cityDetails.cityKey)
    }

    func searchCityKey(weatherDetails: WeatherDataUIModel) {
        self.delegate?.successData(citydDetails: self.cityDetails ?? CityDetailsUIModel(cityKey: "", cityName: "", stateName: "", countryName: ""), weatherDetails: weatherDetails)
    }


    func searchCityUsingCoordinates(cityDetails: CityDetailsUIModel) {
        self.cityDetails = cityDetails
        self.callFetchCityDetailsAPI(cityKey: cityDetails.cityKey)
    }

    
}
