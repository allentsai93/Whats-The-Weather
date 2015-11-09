//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Allen Tsai on 2015-11-09.
//  Copyright © 2015 Allen Tsai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityTextField: UITextField!

    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        var wasSuccessful = false
        // Do any additional setup after loading the view, typically from a nib.
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        if let url = attemptedUrl {
            
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray.count > 1 {
                    
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span")
                    
                    print(weatherArray[0])
                    
                    if weatherArray.count > 1 {
                        wasSuccessful = true
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                        
                    }
                }
            }
        }
        task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

