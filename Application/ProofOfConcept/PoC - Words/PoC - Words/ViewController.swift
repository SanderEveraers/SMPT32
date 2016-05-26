//
//  ViewController.swift
//  PoC - Words
//
//  Created by Fhict on 26/05/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tbVertaling: UITextField!
    @IBOutlet weak var lbUitkomst: UILabel!

    @IBAction func btWoordDoorgeven(sender: UIButton) {
        let vertaling = tbVertaling.text?.lowercaseString
        if(vertaling == "vrijheid") {
            lbUitkomst.text = "Juist!"
            lbUitkomst.textColor = UIColor.init(red: 0.0, green: 153.0/255, blue: 51.0/255, alpha: 255.0/255)
        } else {
            lbUitkomst.text = "Probeer het later nog eens"
            lbUitkomst.textColor = UIColor.redColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

