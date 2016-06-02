//
//  ViewController.swift
//  LoginTrial
//
//  Created by Fhict on 02-06-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    var loggedInPupil: Pupil?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJsonData()
    {
//        let urlString = "http://localhost:8080/login?name=\(tfUsername.text!)&password=\(tfPassword.text!)"
        let url = NSURL(string: "http://localhost:8080/login?name=\(tfUsername.text!)&password=\(tfPassword.text!)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSObject
        {
            let id = jsonData.valueForKey("id") as? NSInteger
            let userName = jsonData.valueForKey("username") as? String
            let passWord = jsonData.valueForKey("password") as? String
            let lastLIMillis = jsonData.valueForKey("lastLoggedIn") as? Int
            var lastLoggedIn: NSDate?
            if (lastLIMillis != nil){
                lastLoggedIn = NSDate(timeIntervalSince1970:Double(lastLIMillis!) / 1000.0)
            }
            if (id != nil && userName != nil && passWord != nil && lastLoggedIn != nil){
                loggedInPupil = Pupil (
                    id: id!,
                    userName: userName!,
                    passWord: passWord!,
                    lastLoggedIn: lastLoggedIn!)
            }
        }
    }

    @IBAction func btnLoginClick(sender: AnyObject) {
        loadJsonData()
        
        if loggedInPupil != nil
        {
            lblErrorMessage.text = "Inloggen gelukt"
                            loggedInPupil = nil
        }
        else{
            lblErrorMessage.text = "Inloggen niet gelukt"
        }
    }

}

