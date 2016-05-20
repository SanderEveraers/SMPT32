//
//  ViewController.swift
//  TEXTTOSPEECHFAILAPP
//
//  Created by Fhict on 20-05-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var speechText: UITextView!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textToSpeech(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: speechText.text)
        //Snelheid
        myUtterance.rate = 0.5
        myUtterance.voice = AVSpeechSynthesisVoice(language:"en-US")
        synth.speakUtterance(myUtterance)
        myUtterance = AVSpeechUtterance(string: "")
    }
    
    @IBAction func textZumSprechen(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: speechText.text)
        //Snelheid
        myUtterance.rate = 0.5
        myUtterance.voice = AVSpeechSynthesisVoice(language:"de-DE")
        synth.speakUtterance(myUtterance)
        myUtterance = AVSpeechUtterance(string: "")
    }

    @IBAction func tekstNaarSpraak(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: speechText.text)
        //Snelheid
        myUtterance.rate = 0.5
        myUtterance.voice = AVSpeechSynthesisVoice(language:"nl-NL")
        synth.speakUtterance(myUtterance)
        myUtterance = AVSpeechUtterance(string: "")
    }
}

