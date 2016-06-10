//
//  TrophyChestController.swift
//  WordFlip
//
//  Created by Fhict on 10-06-16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class TrophyChestController: UIViewController {


    @IBAction func logOutAction(sender: AnyObject) {
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
