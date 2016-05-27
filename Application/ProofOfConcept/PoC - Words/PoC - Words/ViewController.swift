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
    @IBOutlet weak var lbWoord: UILabel!
    @IBOutlet weak var lbUitkomst: UILabel!

    var words: [String: String] = [
        "onafhankelijkheid" : "Independence",
        "stad" : "city",
        "ritme": "rhythm"
    ]
    
    var goodWords: [String:String] = [:]
    
    @IBAction func btWoordDoorgeven(sender: UIButton) {
        let vertaling = tbVertaling.text?.lowercaseString
        if(words[vertaling!] != nil) {
            if(words[vertaling!] == lbWoord.text)
            {
                var index: Int = Int(arc4random_uniform(UInt32(words.count)))
                var randomVal = Array(words.values)[index]
                var bool = false
                
                while(!bool) {
                    if(randomVal == lbWoord.text) {
                        index = Int(arc4random_uniform(UInt32(words.count)))
                        randomVal = Array(words.values)[index]
                    } else {
                        bool = true
                    }
                }
                lbWoord.text = ""
                tbVertaling.text = ""
                lbUitkomst.text = ""
                lbWoord.text = randomVal
            }
            
        }  else {
            lbUitkomst.text = "Probeer het later opnieuw."
        }
        
        
        
//        if(vertaling == "onafhankelijkheid") {
//            lbUitkomst.text = "Juist!"
//            lbUitkomst.textColor = UIColor.init(red: 0.0, green: 153.0/255, blue: 51.0/255, alpha: 255.0/255)
//        } else {
//            lbUitkomst.text = "Probeer het later nog eens."
//            lbUitkomst.textColor = UIColor.redColor()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            var index: Int = Int(arc4random_uniform(UInt32(words.count)))
            var randomVal = Array(words.values)[index]
            var bool = false
            
            while(!bool) {
                if(randomVal == lbWoord.text) {
                    index = Int(arc4random_uniform(UInt32(words.count)))
                    randomVal = Array(words.values)[index]
                } else {
                    bool = true
                }
            }
            lbWoord.text = ""
            tbVertaling.text = ""
            lbUitkomst.text = ""
            lbWoord.text = randomVal
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSwipe(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }


}

