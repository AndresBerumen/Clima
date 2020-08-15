//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }
    
    
    // MARK: Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: Properties
    var city = ""
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

}



    // MARK: - TextFieldDelegate Extension
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type a city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        city = searchTextField.text!
        weatherManager.fetchWeather(cityName: city)
        cityLabel.text = city
        searchTextField.text = ""
    }
    
    
    // Actions
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        searchTextField.text = ""
        cityLabel.text = city
    }
}



// MARK: - WeatherManagerDelegate Extension
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdate(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.finalCondition[0])
            self.view.backgroundColor = UIColor(named: weather.finalCondition[1])
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



// MARK: - LocationManagerDelegate Extension
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
