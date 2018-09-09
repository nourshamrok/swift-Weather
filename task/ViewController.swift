

import UIKit
import CoreLocation



class ViewController: UIViewController , CLLocationManagerDelegate , UITableViewDelegate, UITableViewDataSource , DataControlLerDelegate{

    @IBOutlet weak var city3tbl: UITableView!
    

    @IBAction func citytap(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var citybtn: UIButton!
    let locationManager = CLLocationManager()
    
    
    //dic cityid id name
    let cities = ["Moscow", "Kiev","London","Cairo","Ramla"]
    var citiesWInfo = [WeatherData]()
    
    var datacont = DataControlLer()
    let cellReuseIdentifier = "cell"
    
    var currentData:WeatherData = WeatherData()
    
    func weatherbycitiesRecived(data: WeatherData) {
        citiesWInfo.append(data)
        city3tbl.reloadData()
    }
    
    func weatherbycordrecived(data: WeatherData) {
        
        currentData = data
        self.temp.text = String(format: "%.1f", data.temperature)
        self.weather.text = data.weather
        self.citybtn.setTitle("Weather City "  + data.city, for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.city3tbl.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.city3tbl.separatorStyle = .none
        
        self.city3tbl.delegate = self
        self.city3tbl.dataSource = self
        
        
        datacont.delegate = self
        
        
        // i put israel Coordinate
        
        datacont.displayCurrentWeatherByCoordinate(lat: "31.771959" , lon: "35.217018")
    
        //to get Coordinate from the gps please change to initLocationManager()
        
        // initLocationManager()
        
        cities.forEach { cityname in
            datacont.displayCurrentWeatherByCities(city: cityname)
        }
     
        
    }

    

    
    
    func initLocationManager(){
    
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        datacont.displayCurrentWeatherByCoordinate(lat: String(locValue.latitude) , lon: String(locValue.longitude))
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesWInfo.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell = self.city3tbl.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = self.citiesWInfo[indexPath.row].city + " Temp: " + String(format: "%.1f", self.citiesWInfo[indexPath.row].temperature)
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    
        
        currentData = self.citiesWInfo[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let destVC : InfoViewController = segue.destination as! InfoViewController
        destVC.data = currentData
    }
    
    

}

