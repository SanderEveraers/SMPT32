//
//  VakViewController.swift
//  WordFlip
//
//  Created by Fhict on 16/06/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class VakViewController: UITableViewController {

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
            cell.labelDificulty?.textColor = UIColor.greenColor()
        case 1:
            cell.labelVakName?.text = "Frans"
            cell.labelDificulty?.textColor = UIColor.redColor()
        case 2:
            cell.labelVakName?.text = "Duits"
            cell.labelDificulty?.textColor = UIColor.orangeColor()
        default:
            cell.labelVakName?.text = "Nederlands"
        }
        cell.buttonToets?.setTitle("Oefen voor hoofdstuk 12", forState: .Normal)
        return cell
    }
    
    
    //Generated code:
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}