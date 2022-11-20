//
//  RecentViewController.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//

import UIKit

class RecentViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet public var citySearchBar: UISearchBar?
    @IBOutlet public var cityListTableView: UITableView?
    var viewModel: WeatherViewModel?
    var delegate: SuccessDataDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = WeatherViewModel()
        self.viewModel?.delegate = delegate
        self.citySearchBar?.delegate = self
        self.cityListTableView?.delegate = self
        self.cityListTableView?.dataSource = self
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        self.cityListTableView?.register(nib, forCellReuseIdentifier: "CityTableViewCell")
        self.navigationController?.navigationBar.isHidden = false
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Recents"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDataManager.instance.fetchRecentSearch().count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell
        cell?.selectionStyle = .none
        let listCities = WeatherDataManager.instance.fetchRecentSearch()
        cell?.setData(str: listCities[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.citySearchBar?.resignFirstResponder()
        self.apiCall(cityName: WeatherDataManager.instance.fetchRecentSearch()[indexPath.row])
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.citySearchBar?.resignFirstResponder()
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        self.citySearchBar?.resignFirstResponder()
        let str = searchBar.text
        if let cityName = str {
            WeatherDataManager.instance.updateRecentSearch(str: cityName)
            apiCall(cityName: cityName)
        }
    }

    func apiCall(cityName: String) {
        self.viewModel?.callSearchCityNameAPI(cityName: cityName)
        self.navigationController?.popViewController(animated: true)
    }
}
