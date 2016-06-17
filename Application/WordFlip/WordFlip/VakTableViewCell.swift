//
//  VakTableViewCell.swift
//  WordFlip
//
//  Created by Fhict on 17/06/16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class VakTableViewCell: UITableViewCell {

    @IBOutlet weak var labelVakName: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var buttonToets: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
