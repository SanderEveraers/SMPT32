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
//    
//    func loadJsonData()
//    {
//        let url = NSURL(string: api.url + "/" + String(api.user!.id) + "/tip/speed")
//        let request = NSURLRequest(URL: url!)
//        let session = NSURLSession.sharedSession()
//        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
//            do
//            {
//                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
//                {
//                    self.parseJSONData(jsonObject)
//                }
//            }
//            catch
//            {
//                print("Error parsing JSON data")
//            }
//        }
//        dataTask.resume();
//    }
//    
//    func parseJSONData(jsonObject:AnyObject){
//        if let jsonData = jsonObject as? NSObject
//        {
//            
//            for item in jsonData
//            {
//                let jName = item.valueForKey("name") as? NSString
//                let jAmount = item.valueForKey("amount") as? Int
//                tijden.append(jAmount)
//            }
//        }
//    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJsonTipMomentsData()
        
        let color1 = UIColor(netHex: 0x42A5F5)
        let color2 = UIColor(netHex: 0xFF9800)
        let color3 = UIColor(netHex: 0x1D6AA8)
        
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
        ochtend.value = 17
        ochtend.color = color1
        ochtend.text = "'s ochtends"
        
        var middag = Piechart.Slice()
        middag.value = 12
        middag.color = color2
        middag.text = "'s middags"
        
        var avond = Piechart.Slice()
        avond.value = 4
        avond.color = color3
        avond.text = "'s avonds"
//        
        
        
        //per vak
        var engels = Piechart.Slice()
        engels.value = 67
        engels.color = color1
        engels.text = "engels"
        
        var frans = Piechart.Slice()
        frans.value = 12
        frans.color = color2
        frans.text = "frans"
        
        var duits = Piechart.Slice()
        duits.value = 4
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
        kort.value = 10
        kort.color = color1
        kort.text = "<1 minuut"
        
        var medium = Piechart.Slice()
        medium.value = 38
        medium.color = color2
        medium.text = ">1minuut"
        
        var lang = Piechart.Slice()
        lang.value = 12
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
        timePie.slices = [ochtend, middag, avond]
        
        
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
            let amount = jsonData.valueForKey("amount") as? NSInteger
            let planned = jsonData.valueForKey("planned") as? NSInteger
            
            if (amount != nil && planned != nil){
                self.amount = amount!
                self.planned = planned!
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

