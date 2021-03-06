//
//  LoginController.swift
//  WordFlip
//
//  Created by Fhict on 03-06-16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassWord: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    func loadJsonData()
    {
        let url = NSURL(string: "\(api.url)/login?name=\(tfUserName.text!)&password=\(tfPassWord.text!)")
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
                api.user = Pupil (
                    id: id!,
                    userName: userName!,
                    passWord: passWord!,
                    lastLoggedIn: lastLoggedIn!)
            }
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        loadJsonData()
        sleep(1)
        if api.user != nil
        {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
//            let str = dateFormatter.stringFromDate((loggedInPupil?.lastLoggedIn)!)
//            lblErrorMessage.text = "Inloggen gelukt\(str)"
            
            let preferences = NSUserDefaults.standardUserDefaults()
            let currentUserKey = "currentUserName"
            let currentUser = api.user!.userName
            let currentPasswordKey = "currentPassWord"
            let currentPassword = api.user!.passWord
            preferences.setValue(currentUser, forKeyPath: currentUserKey)
            preferences.setValue(currentPassword, forKeyPath: currentPasswordKey)
            let didSave = preferences.synchronize()
            if !didSave{
                lblErrorMessage.hidden = false
                lblErrorMessage.text = "Inloggegevens opslaan is mislukt"
            }
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("TabBarController")
            self.presentViewController(viewController, animated: true, completion: nil)
        }
        else
        {
            lblErrorMessage.hidden = false
            lblErrorMessage.text = "Gebruikersnaam of wachtwoord is onjuist"
        }
    }
}
