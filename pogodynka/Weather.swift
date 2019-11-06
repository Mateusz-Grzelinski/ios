
import Foundation
import CoreLocation

struct Weather {
    let weatherType:String
    let tempMax:Double
    let tempMin:Double
    let windVelocity:Double
    let windDirection:Double
    let rain:Double
    let pressure:Double
    let iconName:String
    let timeStamp:Double
    let city: String
    
    init(json:[String:Any], city:String) {
        self.weatherType = json["summary"] as! String
        self.tempMax = json["temperatureMax"] as! Double
        self.tempMin = json["temperatureMin"] as! Double
        self.windVelocity = json["windSpeed"] as! Double
        self.windDirection = json["windBearing"] as! Double
        self.rain = json["humidity"] as! Double
        self.pressure = json["pressure"] as! Double
        self.iconName = json["icon"] as! String
        self.timeStamp = json["time"] as! Double
        self.city = city
    }
    
    
    static func getData (latitude: String, city:String, longitude: String, completion: @escaping ([Weather]?) -> ()) {
        
        let API_PATH = "https://api.darksky.net/forecast/13066f8bc7d489b2e2f550c8237de8c4/\(latitude),\(longitude)"
        let request = URLRequest(url: URL(string: API_PATH)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
    
        var forecastArray:[Weather] = []
        
        if let data = data {
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let dailyForecasts = json["daily"] as? [String:Any] {
                        if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                            for dataPoint in dailyData {
                                if let weatherObject = try? Weather(json: dataPoint, city: city) {
                                    forecastArray.append(weatherObject)
                                }
                            }
                        }
                    }
                
                }
            }catch {
                    print(error.localizedDescription)
                }
                completion(forecastArray)
            }
        }
        task.resume()
        
    }
}

