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

//    let w1 = Word(id: 1, question: "Independence", answer: "onafhankelijkheid", sentence: " ...")
//    let w2 = Word(id: 2, question: "City", answer: "stad", sentence: "...")
//    let w3 = Word(id: 3, question: "Rhythm", answer: "ritme", sentence: "...")
//    let w4 = Word(id: 4, question: "Joke", answer: "grapje", sentence: "...")
    
    var word = Word(id: 1000, question: ".", answer:".", sentence: "';'")
    
    var words:[Word] = []
    
    var goodWords: [String:String] = [:]
    
    var geoefendeWoorden: Int = 1
    var aantalWoorden: Int = 0
    
    var timer = NSTimer()
    var timerInterrupt = NSTimer()
    var timerSwipe = NSTimer()
    
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
                if(element.getQuestion() == lbWoord.text!) {
                    word = Word(id: element.getID(), question: element.getQuestion(), answer: element.getAnswer(), sentence: element.getSentence())
                
                if(!isGoed) {
            if(element.getQuestion() == lbWoord.text! && element.getAnswer() == vertaling) {
                
                self.hetAntWoord = element.getAnswer()
                var index: Int = Int(arc4random_uniform(UInt32(words.count)))
                var randomVal = Array(words)[index]
                var bool = false
                while(!bool) {
                    if(randomVal.getQuestion() == lbWoord.text!) {
                        index = Int(arc4random_uniform(UInt32(words.count)))
                        randomVal = Array(words)[index]
                    } else {
                        bool = true
                    }
                }
                lbWoord.text = ""
                tbVertaling.text = ""
                lbUitkomst.text = ""
                lbWoord.text = randomVal.getQuestion()
                self.geoefendeWoorden += 1
                isGoed = true
                self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(words.count)
                continue //repeatDing
            } else {
                //lbUitkomst.text = "Probeer het later opnieuw."
                timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(timerAction), userInfo: word, repeats: false)
                timerInterrupt = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(timerInterruptAction), userInfo: nil, repeats: true)
                //isGoed = false
                tbVertaling.text = ""
                //self.geoefendeWoorden += 1
                performSelector(#selector(nextWord), withObject: nil, afterDelay: 2)
            }
            }
                }
        }
        
        //}while(geoefendeWoorden < aantalWoorden)
        if(geoefendeWoorden >= words.count) {
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
        //self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(aantalWoorden)
        // Do any additional setup after loading the view, typically from a nib.
        self.loadJsonData()
        sleep(1)
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(_:)))
        //var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        //rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        //view.addGestureRecognizer(rightSwipe)
        
        performSelector(#selector(loadData), withObject: nil, afterDelay: 1)
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            forLoop: for (_, element) in words.enumerate() {
                if(element.getQuestion() == lbWoord.text!) {
                    word = Word(id: element.getID(), question: element.getQuestion(), answer: element.getAnswer(), sentence: element.getSentence())
                }
            }
            timerSwipe = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(timerSwipeAction), userInfo: word, repeats: false)
            
            timerInterrupt = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: #selector(timerInterruptAction), userInfo: nil, repeats: false)
            
            performSelector(#selector(nextWord), withObject: nil, afterDelay: 2)
            
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
        self.lbUitkomst.text = word.getAnswer()
        lbUitkomst.textColor = UIColor.redColor()
    }
    
    func timerSwipeAction() {
        // Something cool
        timerSwipe.invalidate()
        //let word = timer.userInfo as! Word
        self.lbUitkomst.text = word.getAnswer()
        lbUitkomst.textColor = UIColor.redColor()
    }
    
    func timerInterruptAction() {
        // Something cool
        timer.invalidate()
        self.lbUitkomst.text = ""
    }
    
    func nextWord() {
        var index: Int = Int(arc4random_uniform(UInt32(words.count)))
        var randomVal = Array(words)[index]
        var bool = false
        while(!bool) {
            if(randomVal.getQuestion() == lbWoord.text!) {
                index = Int(arc4random_uniform(UInt32(words.count)))
                randomVal = Array(words)[index]
            } else {
                bool = true
                lbWoord.text = randomVal.getQuestion()
                lbUitkomst.text = ""
            }
        }
    }
    
    func loadData() {
        nextWord()
        self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(words.count)
    }
    
    //JSON parsing
    func loadJsonData()
    {
        let url = NSURL(string: "http://145.93.106.100:8080/practice?userid=6&course=Engels")
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
    
    func parseJSONData(jsonObject:AnyObject) {
        if let jsonData = jsonObject as? NSArray
        {
            for item in jsonData
            {
                let newWord = Word (
                    id: item.objectForKey("id") as! Int,
                    question: item.objectForKey("question") as! String,
                    answer: item.objectForKey("answer") as! String,
                    sentence: item.objectForKey("sentence") as! String
                )
                words.append(newWord)
            }
        }
    }


}

