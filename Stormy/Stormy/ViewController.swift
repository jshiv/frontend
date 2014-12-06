//
//  ViewController.swift
//  Stormy
//
//  Created by Jason Shiverick on 12/5/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let apiKey = "a9abbec0e2d9c3ba913becfe326afabc"
    
    var locations = [
    "Steamer Lane":"36.9538394,-122.0241292",
    "Christy Willoughby": "44.9666949,-93.2778775",
    "Home":"37.4484911,-122.1802811"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "36.9538394,-122.0241292", relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location:NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            
            if (error == nil) {
                var dataObject = NSData(contentsOfURL: location)
                let weatherData: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                println(weatherData)
            }
            
            
        })
        downloadTask.resume()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

