//
//  WordViewController.swift
//  WordFlip
//
//  Created by Fhict on 07/06/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import CoreData

class WordViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext?

    @IBOutlet weak var pbWords: UIProgressView!
    @IBOutlet weak var lbAantalWoorden: UILabel!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbAnswer: UILabel!
    @IBOutlet weak var tbTranslation: UITextField!

    @IBOutlet weak var btReady: UIButton!
    @IBOutlet weak var btWoordDoorgeven: UIButton!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    var word = Word(id: 1000, question: ".", answer:",", sentence: "';'", count: 0)
    
    var words:[Word] = []
    
    var leftSwipe = UISwipeGestureRecognizer()
    
    var goodWords: [String:String] = [:]
    
    var geoefendeWoorden: Int = 1
    var aantalWoorden: Int = 0
    
    var timer = NSTimer()
    var timerInterrupt = NSTimer()
    var timerSwipe = NSTimer()
    var timerBug = NSTimer()
    
    var isGoed:Bool = false
    
    var hetAntWoord = ""
    
    @IBAction func btWoordDoorgeven(sender: UIButton) {
        
        let vertaling = tbTranslation.text?.lowercaseString
        isGoed = false
        lbAnswer.text = ""
        if(timer.valid) {
            timer.invalidate()
        }
        if(timerInterrupt.valid) {
            timerInterrupt.invalidate()
        }
        
        //Extra state
        if(geoefendeWoorden == ((words.count*2)-1)) {
            
            if(vertaling == words.last?.getAnswer()) {
                lbQuestion.text = words.first?.getQuestion()
                print("ITWORK")
                self.geoefendeWoorden += 1
                
                dispatch_async(dispatch_get_main_queue()) {
                    //self.pbWords.setProgress(Float(self.geoefendeWoorden/self.words.count), animated: false)
                    self.pbWords.progress = Float(self.geoefendeWoorden) / Float(self.words.count*2)
                }
                
                //self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(words.count*2)
                tbTranslation.text = ""
            }
            return
            
        }
        if(geoefendeWoorden == ((words.count*2))) {
            if(vertaling == words.first?.getAnswer()) {
                pbWords.progress = Float(geoefendeWoorden/words.count)
                self.lbQuestion.text = "Je bent klaar"
                //var disableMyButton = sender as? UIButton
                //disableMyButton!.enabled = false
                lbAantalWoorden.text = ""
                btWoordDoorgeven.hidden = true
                btReady.hidden = false
                tbTranslation.hidden = true
                self.leftSwipe.enabled = false
            }
        }

        //timerInterrupt.invalidate()
        //repeatDing: repeat {
        forLoop: for (_, element) in words.enumerate() {
            if(element.getQuestion() == lbQuestion.text!) {
                word = Word(id: element.getID(), question: element.getQuestion(), answer: element.getAnswer(), sentence: element.getSentence(), count: element.getCount())
                
                if(!isGoed) {
                    if(element.getQuestion() == lbQuestion.text! && element.getAnswer() == vertaling) {
                        
                        self.hetAntWoord = element.getAnswer()
                        var index: Int = Int(arc4random_uniform(UInt32(words.count)))
                        var randomVal = Array(words)[index]
                        var bool = false
                        while(!bool) {
                            if(randomVal.getQuestion() == lbQuestion.text! || randomVal.getCount() == 2) {
                                index = Int(arc4random_uniform(UInt32(words.count)))
                                print("opnieuw" + randomVal.getQuestion() + " - " + String(randomVal.getCount()))
                                randomVal = Array(words)[index]
                            } else {
                                print("Legit  " + randomVal.getQuestion() + " - " + String(randomVal.getCount()))
                                bool = true
                            }
                        }
                        lbQuestion.text = ""
                        tbTranslation.text = ""
                        lbAnswer.text = ""
                        lbQuestion.text = randomVal.getQuestion()
                        self.lbQuestion.slideInFromLeft()
                        self.geoefendeWoorden += 1
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            //self.pbWords.setProgress(Float(self.geoefendeWoorden/self.words.count), animated: false)
                            self.pbWords.progress = Float(self.geoefendeWoorden) / Float(self.words.count*2)
                        }
                        
                        element.setCount()
                        isGoed = true
                        //self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(words.count*2)
                        if(geoefendeWoorden == ((words.count*2)-1)) {
                            lbQuestion.text = words.last?.getQuestion()
                        }
                        continue //repeatDing
                    } else {
                        //lbUitkomst.text = "Probeer het later opnieuw."
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(timerAction), userInfo: word, repeats: false)
                        timerInterrupt = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(timerInterruptAction), userInfo: nil, repeats: true)
                        //isGoed = false
                        tbTranslation.text = ""
                        //self.geoefendeWoorden += 1
                        performSelector(#selector(nextWord), withObject: nil, afterDelay: 2)
                    }
                }
            }
        }
        
        //}while(geoefendeWoorden < aantalWoorden)
        if(geoefendeWoorden >= words.count*2) {
            self.lbQuestion.text = "Je bent klaar"
            //var disableMyButton = sender as? UIButton
            //disableMyButton!.enabled = false
            lbAantalWoorden.text = ""
            btWoordDoorgeven.hidden = true
            btReady.hidden = false
            tbTranslation.hidden = true
            self.leftSwipe.enabled = false
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
    
    @IBAction func btReady(sender: UIButton) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("TabBarController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(aantalWoorden)
        // Do any additional setup after loading the view, typically from a nib.
        self.loadJsonData()
        sleep(1)
        
        
        self.leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(WordViewController.handleSwipes(_:)))
        //var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        //rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        //view.addGestureRecognizer(rightSwipe)
        
        performSelector(#selector(loadData), withObject: nil, afterDelay: 1)
        
        dispatch_async(dispatch_get_main_queue()) {
            //self.pbWords.setProgress(Float(self.geoefendeWoorden/self.words.count), animated: false)
            self.pbWords.progress = Float(self.geoefendeWoorden) / Float(self.words.count*2)
        }
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            forLoop: for (_, element) in words.enumerate() {
                if(element.getQuestion() == lbQuestion.text!) {
                    
                    word = Word(id: element.getID(), question: element.getQuestion(), answer: element.getAnswer(), sentence: element.getSentence(), count: element.getCount())
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
        self.lbAnswer.text = word.getAnswer()
        lbAnswer.textColor = UIColor.redColor()
    }
    
    func timerSwipeAction() {
        // Something cool
        timerSwipe.invalidate()
        //let word = timer.userInfo as! Word
        self.lbAnswer.text = word.getAnswer()
        lbAnswer.textColor = UIColor.redColor()
    }
    
    func timerInterruptAction() {
        // Something cool
        timer.invalidate()
        self.lbAnswer.text = ""
    }
    
    func timerBugAction() {
        var index: Int = Int(arc4random_uniform(UInt32(words.count)))
        var randomVal = Array(words)[index]
        var bool = false
        while(!bool) {
            if(randomVal.getCount() == 2) {
                index = Int(arc4random_uniform(UInt32(words.count)))
                randomVal = Array(words)[index]
            }  else {
                bool = true
                lbQuestion.text = randomVal.getQuestion()
                lbAnswer.text = ""
            }
        }
    }
    
    func nextWord() {
        var index: Int = Int(arc4random_uniform(UInt32(words.count)))
        var randomVal = Array(words)[index]
        var bool = false
        while(!bool) {
            if(randomVal.getQuestion() == lbQuestion.text! || randomVal.getCount() == 2) {
                index = Int(arc4random_uniform(UInt32(words.count)))
                randomVal = Array(words)[index]
            } else {
                bool = true
                self.lbQuestion.slideInFromRight()
                lbQuestion.text = randomVal.getQuestion()
                lbAnswer.text = ""
            }
        }
    }
    
    func loadData() {
        nextWord()
        //self.lbAantalWoorden.text = String(geoefendeWoorden) + "/" + String(words.count*2)
    }
    
    //JSON parsing
    func loadJsonData()
    {
        let url = NSURL(string: "\(api.url)/practice?userid=6&course=Engels")
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
                let id = item.objectForKey("id") as? NSInteger
                let question = item.objectForKey("question") as? String
                let answer = item.objectForKey("answer") as? String
                let sentence = item.objectForKey("sentence") as? String
                print("..")
                if(id != nil && question != nil && answer != nil && sentence != nil) {
                    let newWord = Word (
                        id: id!,
                        question: question!,
                        answer: answer!,
                        sentence: sentence!,
                        count: 0
                    )
                    words.append(newWord)
                }
            }
        }
    }
    
    @IBAction func speechWord(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: lbQuestion.text!)
        //Snelheid
        myUtterance.rate = 0.5
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-UK")
        synth.speakUtterance(myUtterance)
        myUtterance = AVSpeechUtterance(string: "")
    }
    
    
}