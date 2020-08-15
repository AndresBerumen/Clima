import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    
    var finalCondition: [String] {
        switch conditionId {
        case 200...232:
            return ["cloud.bolt", "thunder"]
        case 300...321:
            return ["cloud.drizzle", "drizzle"]
        case 500...531:
            return ["cloud.rain", "rain"]
        case 600...622:
            return ["snow", "snow"]
        case 701...781:
            return ["cloud.fog", "fog"]
        case 800:
            return ["sun.max", "sunny"]
        case 801...804:
            return ["cloud", "cloud"]
        default:
            return ["sun", "sunny"]
        }
    }
    
    

}
