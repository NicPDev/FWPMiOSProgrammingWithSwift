//
//  ViewController.swift
//  Weather
//
//  Created by student on 17.01.15.
//  Copyright (c) 2015 NicolasPfeuffer. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
   
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    
    @IBOutlet weak var tempMinLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    //controls
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Cell
    @IBOutlet weak var tableViewCell: TableViewCell!
    
    var tableViewCellModel:TableViewCellModel!
    var items:[TableViewCellModel] = []
    
   
    
   
    override func viewWillAppear(animated: Bool) {
        
        self.tempLabel.alpha = 0.0
        self.tempMaxLabel.alpha = 0.0
        self.tempMinLabel.alpha = 0.0
        self.pressureLabel.alpha = 0.0
        self.humidityLabel.alpha = 0.0
        self.weatherImage.alpha = 0.0
        self.tableView.alpha = 0.0
        
        var imageName = "sunrise.png"
        var background = UIImage(named: imageName)
        
        var backgroundImageView = UIImageView(image:background!)
        

        backgroundImageView.image = background;
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.alpha = 0.0
        self.view.addSubview(backgroundImageView)
        
        
        var blurredImageView = UIImageView()
        
        blurredImageView.contentMode = UIViewContentMode.ScaleAspectFill
        blurredImageView.alpha = 0
        blurredImageView.setImageToBlur(background, blurRadius: kLBBlurredImageDefaultBlurRadius, completionBlock: nil)
        self.view.addSubview(blurredImageView)
        
        var bounds = CGRect()
        bounds = self.view.bounds
        
        backgroundImageView.frame = bounds;
        blurredImageView.frame = bounds;
        blurredImageView.alpha = 1.0
        
        self.view.sendSubviewToBack(blurredImageView)
        self.view.sendSubviewToBack(backgroundImageView)
        
        self.searchTextField.alpha = 0.5
        self.tempLabel.alpha = 0.0
        self.tempMaxLabel.alpha = 0.0
        self.tempMinLabel.alpha = 0.0
        self.pressureLabel.alpha = 0.0
        self.humidityLabel.alpha = 0.0
        self.weatherImage.alpha = 0.0
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        weatherImage.image = UIImage(named: "Sunny")
        
        
        searchTextField.placeholder = "Bitte geben Sie die gewünschte Stadt hier ein"
        searchTextField.delegate = self
        
    }

    
    
    

 
    func setWeatherLabels() {
        var weatherNew:Weather!
        
        var locationNew:Location!
        
        //MARK: String vom TextField umwandeln
        var weatherUrlLocationPartUTF8:String = searchTextField.text
        var weatherUrlLocationPartWithEncoding:String = weatherUrlLocationPartUTF8.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        //MARK: Serveranfrage
        let wuWeatherURLMainPart:String = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
        var wuWeatherURLCompleteString:String = "\(wuWeatherURLMainPart)\(weatherUrlLocationPartWithEncoding)&cnt=7&mode=json"
        let wuWeatherURL:NSURL? = NSURL(string: wuWeatherURLCompleteString)
        
        if ( searchTextField.text != nil){
            let request:NSURLRequest? = NSURLRequest(URL: wuWeatherURL!)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            // zuerst URL erstelln, die der request übergeben, die config per default erstellen lassen und die config der session übergeben
            
            
            session.dataTaskWithRequest(request!, completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    return
                }
                var parseError:NSError?
                
                let parsedObject:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parseError)
                
                if parseError != nil {
                    return   }
                println(parsedObject)
                
                
                
                
                var dtArray:[Int] = [Int]()
                var maxTempArray:[Double] = [Double]()
                var minTempArray:[Double] = [Double]()
                var iconArray:[String] = [String]()
                var weatherNew: Weather!
                var locationNew: Location!
                
                //MARK: SwiftyJSON Methode
                var jsonObject = JSON(data:data)
                println("SwiftyJSON:\(jsonObject)")
                // Direkt im Konstruktor zuweisen funktioniert nicht
                
//                let weatherJSON = Weather(DT: jsonObject["list"]["dt"][0].intValue, temp: jsonObject["list"]["temp"]["day"][0].doubleValue, humidity: jsonObject["list"]["humidity"][0].intValue, temp_min: jsonObject["list"]["temp"]["day"]["min"][0].doubleValue, temp_max: jsonObject["list"]["temp"]["day"]["max"][0].doubleValue, pressure: Int(jsonObject["list"]["pressure"][0]), seaLevel: 0, groundLevel: 0, weatherMain: jsonObject["list"]["weather"]["main"].stringValue)
                
                // Zuweisen auf let
                let date = jsonObject["list"]["dt"][0].intValue
                let temp = jsonObject["list"]["temp"]["day"][0].doubleValue
                let humidty = jsonObject["list"]["humidity"][0].intValue
                let mintemp = jsonObject["list"]["temp"]["day"]["min"][0].doubleValue
                let maxtemp = jsonObject["list"]["temp"]["day"]["max"][0].doubleValue
                let weatherMain2 = jsonObject["list"]["weather"]["main"].stringValue
                let pressure = jsonObject["list"]["pressure"][0].intValue
                    
                    let weatherJSON = Weather(DT: date, temp: temp, humidity: humidty, temp_min: mintemp, temp_max: maxtemp, pressure: Int(pressure), seaLevel: 0, groundLevel: 0, weatherMain: weatherMain2)
                
                //MARK: Methode ohne SwiftyJson, abfragen der einzelnen JSON Elemente
                //Da alle elemente optionals sind, muss jedes einzeln abgefragt werden, daher die kaskadierenden ifs
                
                
                if let weather = parsedObject as? NSDictionary{
                    if let city = weather ["city"] as? NSDictionary{
                        if let coord = city ["coord"] as? NSDictionary{
                            if let lat = coord ["lat"] as? CLLocationDegrees{
                                if let country = city["country"] as? String{
                                    if let lon = coord ["lon"] as? CLLocationDegrees{
                                        if let name = city ["name"] as? String {
                                            if let listArray = weather["list"] as? NSArray{
                                                for iterate in 0...6 {
                                                    if let listMainDic = listArray[iterate] as? NSDictionary{
                                                        if let dt = listMainDic["dt"] as? Int {
                                                            if let humidity = listMainDic["humidity"] as? Int{
                                                                if let pressure = listMainDic["pressure"] as? Double{
                                                                    if let tempMain = listMainDic["temp"] as? NSDictionary{
                                                                        if let temp = tempMain["day"] as? Double{
                                                                            if let maxTemp = tempMain["max"] as? Double{
                                                                                if let minTemp = tempMain["min"] as? Double{
                                                                                    if let weatherMainArray = listMainDic["weather"] as? NSArray {
                                                                                        if let weatherMainDic = weatherMainArray[0] as? NSDictionary{
                                                                                            if let weatherIcon = weatherMainDic["main"] as? String{
                                                                                                println(" if let abgearbeitet")
                                                                                                if iterate == 0 {
                                                                                                    weatherNew = Weather(DT: dt, temp: temp, humidity: humidity, temp_min: minTemp, temp_max: maxTemp, pressure: Int(pressure), seaLevel: 0, groundLevel: 0, weatherMain: weatherIcon)
                                                                                                    locationNew = Location(ID: 0, name: name, lat: lat, lon: lon, message: "0", country: country, sunrise: 0 , sunset: 0, weather: weatherNew!)
                                                                                                    println("var weatherNew and locationNew")
                                                                                                }
                                                                                                dtArray.append(dt)
                                                                                                maxTempArray.append(maxTemp)
                                                                                                minTempArray.append(minTemp)
                                                                                                iconArray.append(weatherIcon)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                if locationNew != nil {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    println(locationNew?.name)
                   
                    println(weatherNew.temp.description)
                    
                    var formatter = NSNumberFormatter()
                    formatter.numberStyle = .DecimalStyle
                    formatter.maximumIntegerDigits = 4
                    formatter.maximumFractionDigits = 0
                    formatter.roundingMode = .RoundUp
                    
                    self.tempLabel.text = "\(formatter.stringFromNumber(weatherNew.temp)!)°"
                    self.tempLabel.sizeToFit()
                    self.tempMaxLabel.text = "\(formatter.stringFromNumber(weatherNew.temp_max)!)°"
                    self.tempMaxLabel.sizeToFit()
                 
                    self.tempMinLabel.text = "\(formatter.stringFromNumber(weatherNew.temp_min)!)°"
                    self.tempMinLabel.sizeToFit()
                    self.humidityLabel.text = "\(weatherNew.humidity) %"
                    self.humidityLabel.sizeToFit()
                    self.pressureLabel.text = "\(weatherNew.pressure) p"
                    self.pressureLabel.sizeToFit()
                    self.weatherStateLabel.text = weatherNew.weatherMain.rawValue
                   self.weatherStateLabel.sizeToFit()
                    self.weatherImage.image = weatherNew.weatherMain.img
                    
                    
                   
                    
                    self.fadeCurrentWeatherLabels()
                    
                    //Wetter gesetzt
                    
                    
                    self.cityLabel.text = locationNew.name
                    self.cityLabel.sizeToFit()
                    
                    self.countryLabel.text = locationNew.country
                    
                    for var i = 0 ;i < dtArray.count; i++ {
                        self.tableViewCellModel = TableViewCellModel(weatherDate: dtArray[i], weatherMaxTemp: maxTempArray[i], weatherMinTemp: minTempArray[i], weatherIcon: iconArray[i])
                        self.items.append(self.tableViewCellModel)
                        println("\(self.tableViewCellModel)")
                    
                    }
                   self.tableView.reloadData()
                    
              
                })
                }
                }
                
                ).resume()
            items.removeAll(keepCapacity: true)
        }
    
    }
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(items.count)
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        // dequeue a cell for the given indexPath

        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TableViewCell
        cell.minTempLabel.text = self.items[indexPath.row].minTemp
        cell.minTempLabel.sizeToFit()
        cell.maxTempLabel.text = self.items[indexPath.row].maxTemp
        cell.maxTempLabel.sizeToFit()
        cell.cellImageView.image = self.items[indexPath.row].weatherIcon.img
        println(self.items[indexPath.row].date)
        cell.dateLabel.text = self.items[indexPath.row].date
        cell.dateLabel.sizeToFit()
       
        cell.backgroundColor = UIColor .clearColor()
        
        return cell
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        setWeatherLabels()
        
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fadeCurrentWeatherLabels(){
        
        if(self.tempLabel.alpha == 1.0){
            self.tempLabel.alpha = 0.0
            self.tempMaxLabel.alpha = 0.0
            self.tempMinLabel.alpha = 0.0
            self.pressureLabel.alpha = 0.0
            self.humidityLabel.alpha = 0.0
            self.weatherImage.alpha = 0.0
            self.tableView.alpha = 0.0}
        
        if(self.tempLabel.alpha == 0.0){
            UIView.animateWithDuration(1.0, animations: {
                self.tempLabel.alpha = 1.0
                self.tempMaxLabel.alpha = 1.0
                self.tempMinLabel.alpha = 1.0
                self.pressureLabel.alpha = 1.0
                self.humidityLabel.alpha = 1.0
                self.weatherImage.alpha = 1.0
                self.tableView.alpha = 1.0
                }, completion: {
                    (value: Bool) in
                    println(">>> Animation done.")
            })}    }

}

