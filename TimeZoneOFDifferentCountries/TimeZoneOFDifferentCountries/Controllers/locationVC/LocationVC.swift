//
//  LocationVC.swift
//  TimeZoneOFDifferentCountries
//
//  Created by Tipu on 16/5/23.
//

import UIKit
import Alamofire

struct City: Codable{
    let name: String
    let countryName: String
    let gmtOffset: Int
}

protocol LocationVCDelegate: AnyObject {
    func didSelectLocation(cityNames: [String])
}

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    weak var delegate: LocationVCDelegate?
    
    var cities: [City] = []
    var filteredCities: [City] = []
    var isSearching = false
    var selectedCityNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        fetchDataFromAPI()
        tableView.allowsMultipleSelection = true

    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    //2U8WWRYX3OIO
    func fetchDataFromAPI() {
        let apiKey = "2U8WWRYX3OIO"
        let apiUrl = "https://api.timezonedb.com/v2.1/list-time-zone?key=\(apiKey)&format=json"
        AF.request(apiUrl).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let responseData = data as? [String: Any],
                   let cityData = responseData["zones"] as? [[String: Any]] {
                    var cities: [City] = []
                    for cityDict in cityData {
                        if let name = cityDict["zoneName"] as? String,
                           let countryName = cityDict["countryName"] as? String,
                           let gmtOffset = cityDict["gmtOffset"] as? Int {
                            let city = City(name: name, countryName: countryName, gmtOffset: gmtOffset)
                            cities.append(city)
                        }
                    }
                    
                    self.cities = cities
                    self.filteredCities = cities
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("API request failed: \(error)")
            }
        }
    }

    @IBAction func AddLocationButton(_ sender: UIButton) {
        delegate?.didSelectLocation(cityNames: selectedCityNames)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getGMTOffset(city: String, country: String) -> String? {
        let timeZone: TimeZone?
        
        if let cityTimeZone = TimeZone(identifier: "Europe/\(city)") {
            timeZone = cityTimeZone
        } else if let countryTimeZone = TimeZone(identifier: "Etc/GMT+\(country)") {
            timeZone = countryTimeZone
        } else {
            timeZone = TimeZone(identifier: "GMT")
        }
        
        guard let gmtOffset = timeZone?.secondsFromGMT() else {
            return nil
        }
        
        let hours = gmtOffset / 3600
        let minutes = abs((gmtOffset / 60) % 60)
        
        let sign = gmtOffset >= 0 ? "+" : "-"
        
        return "GMT \(sign)\(hours):\(String(format: "%02d", minutes))"
    }
    //MARK: TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredCities.count)
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        let city = filteredCities[indexPath.row]
        cell.configureCell(cityName: city.name, countryName: city.countryName, gmtOffset: city.gmtOffset )
        
        if cell.isSelected {
             cell.tintColor = UIColor.brown
         } else {
             cell.tintColor = UIColor.white
         }
        
        cell.lable.textColor = UIColor.white
        cell.countryLable.textColor = UIColor.white
        cell.timeGTM.textColor = UIColor.white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filteredCities[indexPath.row]
        selectedCityNames.append(selectedCity.name)
    }

    // Implement UISearchBarDelegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities
            isSearching = false
        } else {
            filteredCities = cities.filter { city in
                return city.name.lowercased().contains(searchText.lowercased())
            }
            isSearching = true
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredCities = cities
        isSearching = false
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Set the background colors for even and odd rows
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor.gray
        }
    }
}

