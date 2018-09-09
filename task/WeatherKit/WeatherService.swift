

import Foundation


open class WeatherService {
    public typealias WeatherDataCompletionBlock = (_ data: WeatherData?) -> ()
    
    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=97cce5b42320d87100a885f5dfa0dac9&units=metric&"
    let urlSession:URLSession = URLSession.shared
    
    open class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    open func getCurrentWeather(query:String , completion: @escaping WeatherDataCompletionBlock) {
       
       
        

        
        
        let openWeatherAPI = openWeatherBaseAPI + query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print(openWeatherAPI)
        let request = URLRequest(url: URL(string: openWeatherAPI)!)
        let weatherData = WeatherData()
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if let error = error  {
                    print(error)
                }
                
                return
            }
            
            // Retrieve JSON data
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
         
                let cod = jsonResult?["cod"] as? NSString

                if (cod == "404"){
                    return
                }
                
                let name = jsonResult?["name"] as? NSString
                weatherData.city = name as! String
                
                
                // Parse JSON data
                let jsonWeather = jsonResult?["weather"] as! [AnyObject]
                
                for jsonCurrentWeather in jsonWeather {
                    weatherData.weather = jsonCurrentWeather["description"] as! String
                }
                
                let jsonMain = jsonResult?["main"] as! Dictionary<String, AnyObject>
                
                weatherData.temperature = jsonMain["temp"] as! Double
                weatherData.humidity =    jsonMain["humidity"] as! Double
                weatherData.pressure =    jsonMain["pressure"] as! Double
                
                completion(weatherData)
                
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
}

let _sharedWeatherService: WeatherService = { WeatherService() }()
