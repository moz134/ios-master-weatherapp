//
//  HomeViewController.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 18/11/22.
//

import UIKit
import Nuke
import CoreLocation


class HomeViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet public var citySearchBar: UISearchBar?
    @IBOutlet public var timeStamp: UILabel?
    @IBOutlet public var locationIcon: UIImageView?
    @IBOutlet public var cityName: UILabel?
    @IBOutlet public var temperatureLbl: UILabel?
    @IBOutlet public var weatherIcon: UIImageView?
    var locationManager = CLLocationManager()
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetupUI()
        citySearchBar?.delegate = self
        self.viewModel.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.checkForLocationPermission()
        self.navigationController?.title = "HomePage"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func checkForLocationPermission() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .denied, .restricted:
                    self.locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.startUpdatingLocation()
                @unknown default:
                    self.locationManager.requestWhenInUseAuthorization()
                }
            } else {
                self.showLocationPermissionPopUp()
            }
        }
    }

    func showLocationPermissionPopUp() {
        // initialise a pop up for using later
        let alertController = UIAlertController(title: "Location Permission", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
            self.callDefaultLocations(lat: 21.1458, long: 79.0882)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true)

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Waiting for permissions")
        case .denied, .restricted:
            self.showLocationPermissionPopUp()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        @unknown default:
            self.showLocationPermissionPopUp()
        }
    }

    func callDefaultLocations(lat: Double, long: Double) {
        self.fetchCurrentLocationKey(lat: lat, long: long)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentPosition = manager.location?.coordinate
        manager.stopUpdatingLocation()
        // Default Nagpur Coordinates
        let lat = currentPosition?.latitude ?? 21.1458
        let long = currentPosition?.longitude ?? 79.0882
        self.callDefaultLocations(lat: lat, long: long)
        print(lat, long)
    }

    func fetchCurrentLocationKey(lat: Double, long: Double) {
        DispatchQueue.main.async {
            self.viewModel.callCurrentLocationSearchAPI(lat: lat, long: long)
        }
    }

    func initSetupUI() {
        self.timeStamp?.text = ""
        self.cityName?.text = ""
        self.weatherIcon?.image = UIImage()
        self.temperatureLbl?.text = ""
    }

    func setUpUI(citydDetails: CityDetailsUIModel, weatherDetails: WeatherDataUIModel) {
        citySearchBar?.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        citySearchBar?.backgroundColor = .clear
        citySearchBar?.placeholder = "search for a city"
        self.locationIcon?.image = UIImage(named: "locationpin")
        self.locationIcon?.tintColor = .blue
        self.cityName?.text = citydDetails.cityName
        self.cityName?.textColor = .blue
        self.cityName?.font = UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        self.timeStamp?.text = self.fetchlocalizedTime(epochTime: weatherDetails.epochTime)
        self.timeStamp?.textColor = .blue
        self.timeStamp?.font = UIFont.boldSystemFont(ofSize: CGFloat(18.0))
        self.temperatureLbl?.text = String(weatherDetails.temperatureValue) + " " + weatherDetails.temperatureUnit
        self.temperatureLbl?.textColor = .blue
        self.temperatureLbl?.font = UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        DispatchQueue.main.async {
            let url = "https://developer.accuweather.com/sites/default/files/\(weatherDetails.weatherIconKey)-s.png"
            Nuke.loadImage(with: URL(string: url)!, into: self.weatherIcon ?? UIImageView())
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let targetVC = RecentViewController()
        targetVC.delegate = self
        self.navigationController?.pushViewController(targetVC, animated: true)
    }

    
}

extension HomeViewController:  SuccessDataDelegate {

    func successData(citydDetails: CityDetailsUIModel, weatherDetails: WeatherDataUIModel) {
        DispatchQueue.main.async {
            self.setUpUI(citydDetails: citydDetails, weatherDetails: weatherDetails)
        }
    }

    func fetchlocalizedTime(epochTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(epochTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, EEE, hh:mm a"
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: date as Date)
    }
}



