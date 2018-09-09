

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var pressure: UILabel!
    
    
    var data:WeatherData = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        temperature.text = "Temperature " + String(format: "%.1f", data.temperature)
        weather.text =     "Weather " + data.weather
        humidity.text =    "Humidity " + String(format: "%.1f", data.humidity)
        pressure.text =    "Pressure " + String(format: "%.1f", data.pressure)
        
        self.navigationItem.title = "Weather City "  + data.city
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
