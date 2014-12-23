//
//  ViewController.swift
//  frontend
//
//  Created by Jason Shiverick on 12/22/14.
//  Copyright (c) 2014 buffaloSpeedway. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let placesURLString: String = "https://sharpies.herokuapp.com/api/v1.0/places"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getPlacesData()
        
        //postPlacesData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getPlacesData() -> Void{
        
        Alamofire.request(.GET, placesURLString)
            .responseJSON { (_, _, JSON, _) in
                println(JSON!)
        }
        
    }
    
    func postPlacesData() -> Void{
        
        let parameters = [
            "title": "In the back",
            "description": "Where the front is not"
        ]
        
        Alamofire.request(.POST, placesURLString, parameters: parameters, encoding: .JSON)
    }


}

