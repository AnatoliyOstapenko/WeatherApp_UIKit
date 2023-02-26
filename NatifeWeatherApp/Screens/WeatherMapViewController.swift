//
//  WeatherMapViewController.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 22.02.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol MapCoordinatesProtocol: AnyObject {
    func coordinates(lat: Double, lon: Double)
}

class WeatherMapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: CoordinatorProtocol?
    weak var delegate: MapCoordinatesProtocol?
    lazy var presenter = WeatherPresenter(view: self, networkManager: NetworkManager())
    
    private let mapView = MKMapView()
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let locationButton = TopLocationButton(image: SFSymbols.location)
    private let completer = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = []
    private var annotation: MKPointAnnotation?
    private var coordinate: CLLocationCoordinate2D?
    private var isTableViewHidden = false
    
    private var cityName: String?
    private var temperature: String?
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tap
    }()
    
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
        locationButton.setMapButton(view: mapView, button: locationButton)
        /// Delegates
        tableView.delegate = self
        tableView.dataSource = self
        completer.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        tapGesture.delegate = self
        /// Add acctions:
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem = searchButton
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        mapView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions:
    @objc private func searchButtonPressed() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @objc private func locationButtonPressed() {
        if let location = mapView.userLocation.location {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
                                         
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            /// Hide keyboard:
            searchController.searchBar.resignFirstResponder()
            /// Remove any existing tapped location annotation:
            if let tappedLocation = annotation {
                mapView.removeAnnotation(tappedLocation)
            }
            /// Set a new coordinates to get weather data
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            self.coordinate = coordinate
            /// Get weather data from network manager:
            presenter.getWeatherByLocation(lat: coordinate.latitude, lon: coordinate.longitude)
        }
    }
    
    // MARK: - Configuration UI
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
    }
    
    // Private methodes
    /// Update annotation and mapView
    private func updateAnnotation(city: String) {
        if let coordinate = self.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = city
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            self.annotation = annotation
        }
    }
        
    private func addPinToMap(coordinate: CLLocationCoordinate2D) {
        if let newAnnotation = annotation {
            mapView.removeAnnotation(newAnnotation)
        }
        self.coordinate = coordinate
        /// Get weather data from network manager:
        presenter.getWeatherByLocation(lat: coordinate.latitude, lon: coordinate.longitude)
        /// Set weather on the main screen:
        delegate?.coordinates(lat: coordinate.latitude,lon: coordinate.longitude)
    }
}

// MARK: - UITableViewDataSource

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
        searchController.searchBar.text = completion.title
        searchController.dismiss(animated: true, completion: nil)
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        isTableViewHidden = true
        tableView.isHidden = true

        search.start { response, error in
            if let placemark = response?.mapItems.first?.placemark {
                let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
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
            let query = searchController.searchBar.text ?? ""
            completer.queryFragment = query
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension WeatherMapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if !isTableViewHidden {
            searchResults = completer.results
            tableView.reloadData()
            tableView.isHidden = searchResults.isEmpty
        } else {
            tableView.isHidden = true
            isTableViewHidden = false
        }
    }
}

// MARK: - MKMapViewDelegate

extension WeatherMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotaion = view.annotation {
            delegate?.coordinates(lat: annotaion.coordinate.latitude,
                                  lon: annotaion.coordinate.longitude)
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        /// Customize glyph design and text. Set temperature to glyph
        pinView.canShowCallout = true
        pinView.glyphTintColor = .white
        pinView.glyphImage = nil
        pinView.alpha = 0.8
        pinView.glyphText = temperature
        pinView.markerTintColor = WeatherColor.darkBlue
        return pinView
    }
}

// MARK: - WeatherViewProtocol

extension WeatherMapViewController: WeatherViewProtocol {
    func setWeather(weather: [WeatherData], filteredWeather: [WeatherData], city: String) {
        self.temperature = weather.first?.temp
        self.updateAnnotation(city: city)
    }
}
