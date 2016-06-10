//
//  TrophyChestController.swift
//  WordFlip
//
//  Created by Fhict on 10-06-16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class TrophyChestController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logOutAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Uitloggen", message: "Weet je zeker dat je wilt uitloggen?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Nee", style:UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.Default, handler: {action in self.logout()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func logout() -> Void{
        let preferences = NSUserDefaults.standardUserDefaults()
        let currentUserKey = "currentUserName"
        let currentPassWord = "currentPassWord"
        preferences.removeObjectForKey(currentUserKey)
        preferences.removeObjectForKey(currentPassWord)
        preferences.synchronize()
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
}
