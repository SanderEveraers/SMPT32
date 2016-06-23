//
//  VakViewController.swift
//  WordFlip
//
//  Created by Fhict on 16/06/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class VakViewController: UITableViewController {
    
    var difficulty:Int?

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! VakTableViewCell
        // Configure the cell...
        let currentRow = indexPath.row
        switch currentRow{
        case 0:
            cell.labelVakName?.text = "Engels"
            cell.labelDificulty?.textColor = getColorFromDifficulty()
            cell.progressView.progress = 0.6
            cell.labelDate.text = "27-06-2016"
            cell.labelToets.text = "Toets hoofdstuk 4"
        case 1:
            cell.labelVakName?.text = "Frans"
            cell.labelDificulty?.textColor = UIColor.grayColor()
            cell.progressView.progress = 0.3
            cell.labelDate.text = "29-06-2016"
            cell.labelToets.text = "Toets hoofdstuk 3"
        case 2:
            cell.labelVakName?.text = "Duits"
            cell.labelDificulty?.textColor = UIColor.grayColor()
            cell.progressView.progress = 0.8
            cell.labelDate.text = "01-07-2016"
            cell.labelToets.text = "Toets hoofdstuk 6"
        default:
            cell.labelVakName?.text = "Nederlands"
        }
        return cell
    }
    
    func getColorFromDifficulty() -> UIColor
    {
        if difficulty != nil
        {
            switch difficulty! {
            case 0:
                return UIColor.grayColor()
            case 1:
                return UIColor.greenColor()
            case 2:
                return UIColor.yellowColor()
            case 3:
                return UIColor.orangeColor()
            case 4:
                return UIColor.redColor()
            default:
                return UIColor.grayColor()
            }
        }
        else {
            return UIColor.greenColor()
        }
    }
    
    
    //Generated code:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
        sleep(1)
        
        // Uncomment the following line to preserve selection between presentations
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func loadJsonData()
    {
        let url = NSURL(string: "\(api.url)/toetsrating?toetsid=1")
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
    
    func parseJSONData(jsonObject:AnyObject){
        if let jsonData = jsonObject as? NSObject
        {
            let level = jsonData.valueForKey("rating") as? NSInteger
            if (level != nil){
                difficulty = level
            }
        }
    }
}