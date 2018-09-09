//
//  DataControlLer.swift
//  task
//
//  Created by noue shamrok on 8/29/18.
//  Copyright © 2018 noue shamrok. All rights reserved.
//

import UIKit

protocol DataControlLerDelegate {
    func weatherbycitiesRecived(data: WeatherData)
    func weatherbycordrecived(data: WeatherData)
    
}


class DataControlLer: NSObject {

    var delegate: DataControlLerDelegate?
    func displayCurrentWeatherByCoordinate(lat:String,lon:String) {
        

        //get by location
        
        let query:String = "lat=" + lat + "&lon=" + lon
        
        WeatherService.sharedWeatherService().getCurrentWeather(query: query, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
              
         
                    
                    
                    self.delegate?.weatherbycordrecived(data: data!)
                
            })
        })
        
    }
    
    func displayCurrentWeatherByCities(city:String) {
        

        let query:String = "q=" + city
        
        WeatherService.sharedWeatherService().getCurrentWeather(query: query, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
              
                    
                    
                    self.delegate?.weatherbycitiesRecived(data: data!)
                
            })
        })

        
    }
    
    
    
    
}
