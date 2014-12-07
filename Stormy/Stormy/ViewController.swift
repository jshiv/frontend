//
//  ViewController.swift
//  Stormy
//
//  Created by Jason Shiverick on 12/5/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var tempreatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var percipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var localLabel: UILabel!
    
    private let apiKey = "a9abbec0e2d9c3ba913becfe326afabc"
    
    var locations = [
    "Steamer Lane":"36.9538394,-122.0241292",
    "Christy": "44.9666949,-93.2778775",
    "Home":"37.4484911,-122.1802811"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshActivityIndicator.hidden = true
        refreshButton.hidden = false
        getCurrentWeatherData()
        getLocalJSONData()
        
    }
    
    
    func getLocalJSONData() -> Void {
        
        let localURL = NSURL(string: "http://localhost:8000/images")
        
        let localSharedSession = NSURLSession.sharedSession()
        
        let localDownloadTask: NSURLSessionDownloadTask = localSharedSession.downloadTaskWithURL(localURL!, completionHandler: { (location:NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if (error == nil){
                let localDataObject = NSData(contentsOfURL: location)
                let localData: NSDictionary = NSJSONSerialization.JSONObjectWithData(localDataObject!, options: nil, error: nil) as NSDictionary
                
                let message = localData["message"] as String
                
                self.localLabel.text = message
            }
            
        })
        localDownloadTask.resume()
        
        
    }
    
    
    func getCurrentWeatherData() -> Void {
        

        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: locations["Steamer Lane"]!, relativeToURL: baseURL)
        

        
        let sharedSession = NSURLSession.sharedSession()
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location:NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            
            if (error == nil) {
                let dataObject = NSData(contentsOfURL: location)
                let weatherData: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                
                let currentWeather = Current(weatherDictionary: weatherData)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempreatureLabel.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon!
                    self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.percipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = currentWeather.summary
                    
                    
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
                
            } else {
                
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error!", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Stop refresh anamation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                    
                })
            
            }
            
            
        })
        downloadTask.resume()
    }
    
    
    @IBAction func refresh() {
        
        getCurrentWeatherData()
        
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        
        refreshActivityIndicator.startAnimating()
        
        
        
        
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

