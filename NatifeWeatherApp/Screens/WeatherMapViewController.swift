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
    
    private let mapView = MKMapView()
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let locationButton = TopLocationButton(image: SFSymbols.location)
    private let completer = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = []
    private var annotation: MKPointAnnotation?
    private var isTableViewHidden = false
    
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
            /// Remove any existing tapped location annotation
            if let tappedLocation = annotation {
                mapView.removeAnnotation(tappedLocation)
            }
            /// Set a new coordinates to get weather data
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
//            addPinToMap(coordinate: coordinate)
            
            delegate?.coordinates(
                                  lat: coordinate.latitude,
                                  lon: coordinate.longitude)

            /// Add a new annotation at the tapped location
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            getTitleAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            mapView.addAnnotation(annotation)
            self.annotation = annotation
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
    private func getTitleAnnotation(latitude: CLLocationDegrees,
                                    longitude: CLLocationDegrees) {
        /// Reverse geocode the tapped location to get the title annotation
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude,
                                  longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                self.annotation?.title = placemark.compactAddress
            }
        }
    }
    
    
    private func addPinToMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = completer.queryFragment
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        delegate?.coordinates(lat: coordinate.latitude, lon: coordinate.longitude)
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
        searchController.searchBar.text = completion.title
        tableView.isHidden = true
        searchController.dismiss(animated: true, completion: nil)
        isTableViewHidden = true
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)

        search.start { response, error in
            if let placemark = response?.mapItems.first?.placemark {
                let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
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
}

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name, let locality = locality {
            var address = name
            if name != locality {
                address += ", " + locality
            }
            if let country = country {
                address += ", " + country
            }
            return address
        } else {
            return nil
        }
    }
}


