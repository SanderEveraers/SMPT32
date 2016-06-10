//
//  VakkenViewController.swift
//  WordFlip
//
//  Created by Fhict on 09/06/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit
import CoreData

class VakkenViewController: UIViewController {
    
    var ManagedObjectContext: NSManagedObjectContext?

    @IBOutlet weak var OefenButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
     
     
     wrligjwlgmalkmseg
     srgsghsr
     segsgsegse
     segseg
    }
    */
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.destinationViewController.isKindOfClass(WordViewController) {
                if let newWordViewController = segue.destinationViewController as? WordViewController {
                    newWordViewController.managedObjectContext = ManagedObjectContext
                }
            }
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
