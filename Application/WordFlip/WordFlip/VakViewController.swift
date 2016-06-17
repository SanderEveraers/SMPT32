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
        return 3
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        let currentRow = indexPath.row
        switch currentRow{
        case 0:
            cell.textLabel?.text = "Engels"
        case 1:
            cell.textLabel?.text = "Frans"
        case 2:
            cell.textLabel?.text = "Duits"
        default:
            cell.textLabel?.text = "Nederlands"
        }
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

}