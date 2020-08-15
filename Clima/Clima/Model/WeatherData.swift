import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Codable {
    let temp: Double
    let pressure: Int
}


struct Weather: Codable {
    let id: Int
}


