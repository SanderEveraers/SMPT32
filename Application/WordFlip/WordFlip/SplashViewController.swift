//
//  SplashViewController.swift
//  WordFlip
//
//  Created by Rob Van Gastel on 26/05/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        // Do any additional setup after loading the view.
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        //Checks if the user is logged in
//        //if true it opens the Tab Bar
//        //if flase it opens the sign up and login screen
//        if(defaults.boolForKey("loggedIn")) {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
//            self.presentViewController(vc, animated: true, completion: nil)
//            
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
//            self.presentViewController(vc, animated: true, completion: nil)
//        }
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
