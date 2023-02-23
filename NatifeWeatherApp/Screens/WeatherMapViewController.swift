//
//  WeatherMapViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 22.02.2023.
//

import UIKit
import MapKit

class WeatherMapViewController: UIViewController {
    
    var coordinator: CoordinatorProtocol?
    lazy var presenter = WeatherPresenter(view: self, networkManager: NetworkManager())
    
    private let mapView = MKMapView()
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let completer = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setSearchController()
    }

    private func configureUI() {
        /// Initial settings
        view.backgroundColor = WeatherColor.darkBlue
        tableView.backgroundColor = .white
        tableView.isHidden = true
        /// Layouts
        mapView.setWeatherMapElements(view: view, subView: mapView)
        tableView.setWeatherMapElements(view: view, subView: tableView)
        /// Delegates
        tableView.delegate = self
        tableView.dataSource = self
        completer.delegate = self
    }
    
    @objc private func searchButtonPressed() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    /// Configure the search controller
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a place"
        searchController.searchBar.backgroundColor = WeatherColor.darkBlue
        /// configure Search TextField
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.searchTextField.leftViewMode = .never
        searchController.searchBar.showsCancelButton = false
        /// configure navigation controller
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        /// color bar buttons
        navigationController?.navigationBar.tintColor = .white
        
        /// Add search bar button:
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func addPinToMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = completer.queryFragment
        annotation.coordinate = coordinate
        presenter.getWeatherByLocation(lat: coordinate.latitude, lon: coordinate.longitude)
        mapView.addAnnotation(annotation)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension WeatherMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
        let completion = searchResults[indexPath.row]
        cell.textLabel?.text = completion.title
        cell.detailTextLabel?.text = completion.subtitle
        return cell
    }
    
// MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = searchResults[indexPath.row]
        completer.queryFragment = completion.title
        searchController.searchBar.text = completion.title
        tableView.isHidden = true
        searchController.dismiss(animated: true, completion: nil)
        
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            print(response.hashValue)
            if let placemark = response?.mapItems.first?.placemark {
                let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.addPinToMap(coordinate: region.center)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating

extension WeatherMapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.isHidden = false
        tableView.reloadData()
        let query = searchController.searchBar.text ?? "" /// when you tap on searchBar
        completer.queryFragment = query
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate

extension WeatherMapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results /// when you start typing
        tableView.reloadData()
        tableView.isHidden = searchResults.isEmpty
    }
}

extension WeatherMapViewController: WeatherViewProtocol {
    func setWeather(weather: [WeatherData], filteredWeather: [WeatherData], city: String) {
    }
}



