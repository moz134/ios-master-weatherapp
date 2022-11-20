//
//  WeatherResponseModel.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//

import Foundation

// City
struct CityWeatherConditionResponse: Decodable {
    var epochTime: Int
    var weatherText: String
    var weatherIcon: Int
    var hasPrecipitation: Bool
    var isDayTime: Bool
    var temperature: TemperatureResponseModel

    enum CodingKeys: String, CodingKey {
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.epochTime = try container.decode(Int.self, forKey: .epochTime)
        self.weatherText = try container.decode(String.self, forKey: .weatherText)
        self.weatherIcon = try container.decode(Int.self, forKey: .weatherIcon)
        self.hasPrecipitation = try container.decode(Bool.self, forKey: .hasPrecipitation)
        self.isDayTime = try container.decode(Bool.self, forKey: .isDayTime)
        self.temperature = try container.decode(TemperatureResponseModel.self, forKey: .temperature)
    }
}

struct TemperatureResponseModel: Decodable {
    var Metric: MetricResponseModel
}

struct MetricResponseModel: Decodable {
    var Value: Double
    var Unit: String
}

// CitySearchResponseModel
struct CitySearchResponseModel: Decodable {
    var key: String
    var type: String
    var englishName: String
    var country: CountryNameResponseModel
    var administrativeArea: AdministrativeAreaResponseModel

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case key = "Key"
        case englishName = "EnglishName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.type = try container.decode(String.self, forKey: .type)
        self.englishName = try container.decode(String.self, forKey: .englishName)
        self.country = try container.decode(CountryNameResponseModel.self, forKey: .country)
        self.administrativeArea = try container.decode(AdministrativeAreaResponseModel.self, forKey: .administrativeArea)
    }
}

struct CountryNameResponseModel: Decodable {
    var EnglishName: String
}

struct AdministrativeAreaResponseModel: Decodable {
    var EnglishName: String
    var EnglishType: String?

}


// search city response structure
//{
//  "Version": 1,
//  "Key": "204844",
//  "Type": "City",
//  "Rank": 25,
//  "LocalizedName": "Nagpur",
//  "EnglishName": "Nagpur",
//  "PrimaryPostalCode": "",
//  "Region": {
//    "ID": "ASI",
//    "LocalizedName": "Asia",
//    "EnglishName": "Asia"
//  },
//  "Country": {
//    "ID": "IN",
//    "LocalizedName": "India",
//    "EnglishName": "India"
//  },
//  "AdministrativeArea": {
//    "ID": "MH",
//    "LocalizedName": "Maharashtra",
//    "EnglishName": "Maharashtra",
//    "Level": 1,
//    "LocalizedType": "State",
//    "EnglishType": "State",
//    "CountryID": "IN"
//  },
//  "TimeZone": {
//    "Code": "IST",
//    "Name": "Asia/Kolkata",
//    "GmtOffset": 5.5,
//    "IsDaylightSaving": false,
//    "NextOffsetChange": null
//  },
//  "GeoPosition": {
//    "Latitude": 21.142,
//    "Longitude": 79.085,
//    "Elevation": {
//      "Metric": {
//        "Value": 305,
//        "Unit": "m",
//        "UnitType": 5
//      },
//      "Imperial": {
//        "Value": 1000,
//        "Unit": "ft",
//        "UnitType": 0
//      }
//    }
//  },
//  "IsAlias": false,
//  "SupplementalAdminAreas": [
//    {
//      "Level": 2,
//      "LocalizedName": "Nagpur",
//      "EnglishName": "Nagpur"
//    },
//    {
//      "Level": 3,
//      "LocalizedName": "Nagpur (Urban)",
//      "EnglishName": "Nagpur (Urban)"
//    }
//  ],
//  "DataSets": [
//    "AirQualityCurrentConditions",
//    "AirQualityForecasts",
//    "Alerts",
//    "FutureRadar",
//    "MinuteCast",
//    "PremiumAirQuality"
//  ]
//}


// search city details response structure
//[
//  {
//    "LocalObservationDateTime": "2022-11-19T03:13:00+05:30",
//    "EpochTime": 1668807780,
//    "WeatherText": "Clear",
//    "WeatherIcon": 33,
//    "HasPrecipitation": false,
//    "PrecipitationType": null,
//    "IsDayTime": false,
//    "Temperature": {
//      "Metric": {
//        "Value": 14.2,
//        "Unit": "C",
//        "UnitType": 17
//      },
//      "Imperial": {
//        "Value": 58,
//        "Unit": "F",
//        "UnitType": 18
//      }
//    },
//    "MobileLink": "http://www.accuweather.com/en/in/nagpur/204844/current-weather/204844?lang=en-us",
//    "Link": "http://www.accuweather.com/en/in/nagpur/204844/current-weather/204844?lang=en-us"
//  }
//]




//
//{
//  "Version": 1,
//  "Key": "3588388",
//  "Type": "City",
//  "Rank": 55,
//  "LocalizedName": "Batla House",
//  "EnglishName": "Batla House",
//  "PrimaryPostalCode": "",
//  "Region": {
//    "ID": "ASI",
//    "LocalizedName": "Asia",
//    "EnglishName": "Asia"
//  },
//  "Country": {
//    "ID": "IN",
//    "LocalizedName": "India",
//    "EnglishName": "India"
//  },
//  "AdministrativeArea": {
//    "ID": "DL",
//    "LocalizedName": "Delhi",
//    "EnglishName": "Delhi",
//    "Level": 1,
//    "LocalizedType": "Union Territory",
//    "EnglishType": "Union Territory",
//    "CountryID": "IN"
//  },
//  "TimeZone": {
//    "Code": "IST",
//    "Name": "Asia/Kolkata",
//    "GmtOffset": 5.5,
//    "IsDaylightSaving": false,
//    "NextOffsetChange": null
//  },
//  "GeoPosition": {
//    "Latitude": 28.569,
//    "Longitude": 77.286,
//    "Elevation": {
//      "Metric": {
//        "Value": 198,
//        "Unit": "m",
//        "UnitType": 5
//      },
//      "Imperial": {
//        "Value": 649,
//        "Unit": "ft",
//        "UnitType": 0
//      }
//    }
//  },
//  "IsAlias": false,
//  "ParentCity": {
//    "Key": "202396",
//    "LocalizedName": "Delhi",
//    "EnglishName": "Delhi"
//  },
//  "SupplementalAdminAreas": [
//    {
//      "Level": 3,
//      "LocalizedName": "Defence Colony",
//      "EnglishName": "Defence Colony"
//    },
//    {
//      "Level": 2,
//      "LocalizedName": "South East",
//      "EnglishName": "South East"
//    }
//  ],
//  "DataSets": [
//    "AirQualityCurrentConditions",
//    "AirQualityForecasts",
//    "Alerts",
//    "ForecastConfidence",
//    "FutureRadar",
//    "MinuteCast",
//    "PremiumAirQuality"
//  ]
//}
