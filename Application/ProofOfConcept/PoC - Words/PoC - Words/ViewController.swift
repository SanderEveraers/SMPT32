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
    @IBOutlet weak var lbAantalWoorden: UILabel!

    let w1 = Word(woord: "Independence",antwoord: "onafhankelijkheid")
    let w2 = Word(woord: "City",antwoord: "stad")
    let w3 = Word(woord: "Rhythm",antwoord: "ritme")
    let w4 = Word(woord: "Joke",antwoord: "grapje")
    
    var word = Word(woord: ".", antwoord:"." )
    
    var words:[Word] = []
    
    var goodWords: [String:String] = [:]
    
    var geoefendeWoorden: Int = 0
    var aantalWoorden: Int = 7
    
    var timer = NSTimer()
    var timerInterrupt = NSTimer()
    var isGoed:Bool = false
    
    var hetAntWoord = ""
    
    @IBAction func btWoordDoorgeven(sender: UIButton) {
        let vertaling = tbVertaling.text?.lowercaseString
        isGoed = false
        lbUitkomst.text = ""
        if(timer.valid) {
            timer.invalidate()
        }
        if(timerInterrupt.valid) {
            timerInterrupt.invalidate()
        }
        //timerInterrupt.invalidate()
        //repeatDing: repeat {
            forLoop: for (_, element) in words.enumerate() {
                if(element.getWoord() == lbWoord.text!) {
                word = Word(woord: element.getWoord(), antwoord: element.getAntwoord())
                
                if(!isGoed) {
            if(element.getWoord() == lbWoord.text! && element.getAntwoord() == vertaling) {
                
                self.hetAntWoord = element.getAntwoord()
                var index: Int = Int(arc4random_uniform(UInt32(words.count)))
                var randomVal = Array(words)[index]
                var bool = false
                while(!bool) {
                    if(randomVal.getWoord() == lbWoord.text!) {
                        index = Int(arc4random_uniform(UInt32(words.count)))
                        randomVal = Array(words)[index]
                    } else {
                        bool = true
                    }
                }
                lbWoord.text = ""
                tbVertaling.text = ""
                lbUitkomst.text = ""
                lbWoord.text = randomVal.getWoord()
                self.geoefendeWoorden += 1
                isGoed = true
                self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(aantalWoorden)
                continue //repeatDing
            } else {
                //lbUitkomst.text = "Probeer het later opnieuw."
                timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(timerAction), userInfo: word, repeats: false)
                timerInterrupt = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(timerInterruptAction), userInfo: nil, repeats: true)
                //isGoed = false
                tbVertaling.text = ""
                //self.geoefendeWoorden += 1
            }
            }
                }
        }
        
        //}while(geoefendeWoorden < aantalWoorden)
        if(geoefendeWoorden >= aantalWoorden) {
        self.lbWoord.text = "Je bent klaar"
        var disableMyButton = sender as? UIButton
        disableMyButton!.enabled = false
        }
        
//        if(words[vertaling!] != nil) {
//            if(words[vertaling!] == lbWoord.text)
//            {
//                var index: Int = Int(arc4random_uniform(UInt32(words.count)))
//                var randomVal = Array(words.values)[index]
//                var bool = false
//                
//                while(!bool) {
//                    if(randomVal == lbWoord.text) {
//                        index = Int(arc4random_uniform(UInt32(words.count)))
//                        randomVal = Array(words.values)[index]
//                    } else {
//                        bool = true
//                    }
//                }
//                lbWoord.text = ""
//                tbVertaling.text = ""
//                lbUitkomst.text = ""
//                lbWoord.text = randomVal
//            }
//            
//        }  else {
//            lbUitkomst.text = "Probeer het later opnieuw." + self.words[lbWoord.text!]!
//        }
//        
        
        
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
        self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(aantalWoorden)
        // Do any additional setup after loading the view, typically from a nib.
        words.append(w1)
        words.append(w2)
        words.append(w3)
        words.append(w4)
        
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            
            backgroundThread(background: {
                // Your function here to run in the background
                //self.lbUitkomst.text = self.words[self.lbWoord.text!]
                //self.lbUitkomst.text = "xxx"
                let index: Int = Int(arc4random_uniform(UInt32(self.words.count)))
                let randomVal = Array(self.words)[index]
                var bool = false
                
//                while(!bool) {
//                    if(randomVal.getWoord() == self.lbWoord.text!) {
//                         index: Int = Int(arc4random_uniform(UInt32(words.count)))
//                         randomVal = Array(words)[index]
//                    } else {
//                        bool = true
//                    }
//                }
                self.lbWoord.text = ""
                self.tbVertaling.text = ""
                //lbUitkomst.text = ""
                self.lbWoord.text = randomVal.getWoord()
                },
                             completion: {
                                // A function to run in the foreground when the background thread is complete
                                self.lbUitkomst.text = ""

            })
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
    
    //Threads
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    //TIMER
    func timerAction() {
        // Something cool
        timer.invalidate()
        //let word = timer.userInfo as! Word
        self.lbUitkomst.text = word.getAntwoord()
        lbUitkomst.textColor = UIColor.redColor()
    }
    
    func timerInterruptAction() {
        // Something cool
        timer.invalidate()
        self.lbUitkomst.text = ""
    }


}

