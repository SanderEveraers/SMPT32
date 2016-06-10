//
//  SplashViewController.swift
//  WordFlip
//
//  Created by Rob Van Gastel on 26/05/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var loggedInPupil: Pupil?
    var userName = ""
    var passWord = ""
    
    func getPupil() -> Int {
        return (loggedInPupil?.id)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let preferences = NSUserDefaults.standardUserDefaults()
        let currentUserName = "currentUserName"
        let currentPassWord = "currentPassWord"
        if preferences.objectForKey(currentUserName) != nil && preferences.objectForKey(currentPassWord) != nil{
            userName = preferences.objectForKey(currentUserName) as! String
            passWord = preferences.objectForKey(currentPassWord) as! String
            loadJsonData()
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("TabBarController")
            self.presentViewController(viewController, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    func loadJsonData()
    {
        let url = NSURL(string: "http://145.93.160.26:8080/login?name=\(userName)&password=\(passWord)")
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
