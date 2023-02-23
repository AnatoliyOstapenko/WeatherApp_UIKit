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
        view.backgroundColor = WeatherColor.darkBlue
        view.addSubview(mapView)
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        completer.delegate = self
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func searchButtonPressed() {
        
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

        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        /// color bar buttons
        navigationController?.navigationBar.tintColor = .white
        
        /// Add search bar button:
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem = searchButton
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
            if let placemark = response?.mapItems.first?.placemark {
                let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                print("REGION - latitude:\(region.center.latitude) - longitude:\(region.center.longitude)")
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating

extension WeatherMapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? "" /// when you tap on searchBar
        print("SearchResults: \(query)")
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
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Autocomplete error: \(error.localizedDescription)") /// when tap on cancel and the cross
    }
}
