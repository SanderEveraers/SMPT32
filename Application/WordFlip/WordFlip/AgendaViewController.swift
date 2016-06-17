//
//  AgendaViewController.swift
//  WordFlip
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import Foundation
import UIKit

class AgendaViewController: ViewController, PiechartDelegate {
    
    var tijden = [Int]()
    
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var piechart1: UIView!
    @IBOutlet weak var lbTipOfDay: UILabel!
    
    //MOMENT:
    var amount = 18
    var planned = 15
    
    //SUBJECT:
    var amountEn = 67
    var amountFr = 12
    var amountDe = 4
    
    //TIME
    var amountMorn = 17
    var amountNoon = 12
    var amountEven = 4
    var amountNigh = 5
    
    //SPEED
    var amountLess1 = 10
    var amountMore1 = 38
    var amountMore2 = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJsonTipMomentsData()
        loadJsonTipSubjectData()
        loadJsonTipTimeData()
        loadJsonTipSpeedData()
        sleep(1)
        
        let color1 = UIColor(netHex: 0x42A5F5)
        let color2 = UIColor(netHex: 0xFF9800)
        let color3 = UIColor(netHex: 0x1D6AA8)
        let color4 = UIColor(netHex: 0xAA00BB)
        
        var views2: [String: UIView] = [:]
        var views: [String: UIView] = [:]
        var views3: [String: UIView] = [:]
        var views4: [String: UIView] = [:]
        
        
        //Uitgevoerd
        var uitgevoerd = Piechart.Slice()
        uitgevoerd.value = CGFloat(planned)
        uitgevoerd.color = color1
        uitgevoerd.text = "voltooid"
        
        var niet = Piechart.Slice()
        niet.value = CGFloat(amount - planned)
        niet.color = color2
        niet.text = "gemist"
        
        //tijden
        var ochtend = Piechart.Slice()
        ochtend.value = CGFloat(amountMorn)
        ochtend.color = color1
        ochtend.text = "'s ochtends"
        
        var middag = Piechart.Slice()
        middag.value = CGFloat(amountNoon)
        middag.color = color2
        middag.text = "'s middags"
        
        var avond = Piechart.Slice()
        avond.value = CGFloat(amountEven)
        avond.color = color3
        avond.text = "'s avonds"
        
        var nacht = Piechart.Slice()
        nacht.value = CGFloat(amountNigh)
        nacht.color = color4
        nacht.text = "'s nachts"
        
        //per vak
        var engels = Piechart.Slice()
        engels.value = CGFloat(amountEn)
        engels.color = color1
        engels.text = "engels"
        
        var frans = Piechart.Slice()
        frans.value = CGFloat(amountFr)
        frans.color = color2
        frans.text = "frans"
        
        var duits = Piechart.Slice()
        duits.value = CGFloat(amountDe)
        duits.color = color3
        duits.text = "duits"
        
        let vakChart = Piechart()
        vakChart.delegate = self
        vakChart.title = "vakken"
        vakChart.activeSlice = 0
        vakChart.layer.borderWidth = 0
        vakChart.slices = [engels,frans,duits]
        
        //tijd
        var kort = Piechart.Slice()
        kort.value = CGFloat(amountLess1)
        kort.color = color1
        kort.text = "<1 minuut"
        
        var medium = Piechart.Slice()
        medium.value = CGFloat(amountMore1)
        medium.color = color2
        medium.text = ">1minuut"
        
        var lang = Piechart.Slice()
        lang.value = CGFloat(amountMore2)
        lang.color = color3
        lang.text = ">2 minuten"
        
        let tijdChart = Piechart()
        tijdChart.delegate = self
        tijdChart.title = "snelheid"
        tijdChart.activeSlice = 0
        tijdChart.layer.borderWidth = 0
        tijdChart.slices = [kort, medium, lang]
        
        
        
        let piechart = Piechart()
        piechart.delegate = self
        piechart.title = "momenten"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 0
        piechart.slices = [uitgevoerd, niet]
        
        let timePie = Piechart()
        timePie.delegate = self
        timePie.title = "tijden"
        timePie.activeSlice = 0
        timePie.layer.borderWidth = 0
        timePie.slices = [ochtend, middag, avond, nacht]
        
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        timePie.translatesAutoresizingMaskIntoConstraints = false
        vakChart.translatesAutoresizingMaskIntoConstraints = false
        tijdChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        view.addSubview(timePie)
        view.addSubview(vakChart)
        view.addSubview(tijdChart)
        views["piechart"] = piechart
        views2["timePie"] = timePie
        views3["vakChart"] = vakChart
        views4["tijdChart"] = tijdChart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[piechart(==120)]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-160-[piechart(==120)]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[timePie(==120)]", options: [], metrics: nil, views: views2))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-300-[timePie(==120)]", options: [], metrics: nil, views: views2))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[vakChart(==120)]-25-|", options: [], metrics: nil, views: views3))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-160-[vakChart(==120)]", options: [], metrics: nil, views: views3))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[tijdChart(==120)]-25-|", options: [], metrics: nil, views: views4))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-300-[tijdChart(==120)]", options: [], metrics: nil, views: views4))
        
        loadJsonTipOfDayData()
        sleep(1)
//        
//        let pie = Piechart()
//        pie.delegate = self
//        pie.title = "moments"
//        pie.activeSlice = 0
//        pie.layer.borderWidth = 0
//        pie.slices = [uitgevoerd, niet]
//        
//        pie.translatesAutoresizingMaskIntoConstraints = false
//        piechart1.addSubview(pie)
//        piechart1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
//        piechart1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-300-[piechart(==300)]", options: [], metrics: nil, views: views))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setSubtitleForPieChart(piechart: Piechart, total: CGFloat, slice: Piechart.Slice) -> String{
        return "\(Int(round(Double(slice.value) / Double(total) * 100)))% \(slice.text)"
    }
    
    func setInfoForPieChart(piechart: Piechart, total: CGFloat, slice: Piechart.Slice) -> String{
        return "\(Int(slice.value))/\(Int(total))"
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Uitloggen", message: "Weet je zeker dat je wilt uitloggen?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Nee", style:UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.Default, handler: {action in self.logout()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadJsonTipOfDayData()
    {
        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONTipOfDayData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONTipOfDayData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSObject
        {
            let tip = jsonData.valueForKey("tip") as? String
            
            if (tip != nil){
                lbTipOfDay.text = tip
            }
        }
    }
    
    func loadJsonTipMomentsData()
    {
        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip/moments")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONTipMomentsData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONTipMomentsData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSObject
        {
            let amountjson = jsonData.valueForKey("amount") as? NSInteger
            let plannedjson = jsonData.valueForKey("planned") as? NSInteger
            
            if (amountjson != nil && plannedjson != nil){
                self.amount = amountjson!
                self.planned = plannedjson!
            }
        }
    }
    
    func loadJsonTipSubjectData()
    {
        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip/subject")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONTipSubjectData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONTipSubjectData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSArray
        {
            amountEn = 0
            amountFr = 0
            amountDe = 0
            for item in jsonData
            {
                let jName = item.valueForKey("name") as? NSString
                let jAmount = item.valueForKey("amount") as? Int
                if (jAmount != nil) {
                    if (jName == "Engels"){
                        amountEn = jAmount!
                    } else if (jName == "Frans"){
                        amountFr = jAmount!
                    } else if (jName == "Duits"){
                        amountDe = jAmount!
                    }
                }
            }
        }
    }
    
    func loadJsonTipTimeData()
    {
        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip/times")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONTipTimeData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONTipTimeData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSArray
        {
            amountMorn = 0
            amountNoon = 0
            amountEven = 0
            amountNigh = 0
            for item in jsonData
            {
                let jName = item.valueForKey("name") as? NSString
                let jAmount = item.valueForKey("amount") as? Int
                if (jAmount != nil) {
                    if (jName == "'s ochtends"){
                        amountMorn = jAmount!
                    } else if (jName == "'s middags"){
                        amountNoon = jAmount!
                    } else if (jName == "'s avonds"){
                        amountEven = jAmount!
                    } else if (jName == "'s nachts"){
                        amountNigh = jAmount!
                    }
                }
            }
        }
    }
    
    func loadJsonTipSpeedData()
    {
        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip/speed")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJSONTipSpeedData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJSONTipSpeedData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSArray
        {
            amountLess1 = 0
            amountMore1 = 0
            amountMore2 = 0
            for item in jsonData
            {
                let jName = item.valueForKey("name") as? NSString
                let jAmount = item.valueForKey("amount") as? Int
                if (jAmount != nil) {
                    if (jName == "'< 1 minuut"){
                        amountLess1 = jAmount!
                    } else if (jName == "> 1 minuut"){
                        amountMore1 = jAmount!
                    } else if (jName == "> 2 minuten"){
                        amountMore2 = jAmount!
                    }
                }
            }
        }
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

