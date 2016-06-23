//
//  VakSettingsView.swift
//  WordFlip
//
//  Created by Fhict on 22-06-16.
//  Copyright © 2016 FHICT. All rights reserved.
//

import UIKit

class VakSettingsView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerData = ["5 woorden", "6 woorden", "7 woorden", "8 woorden", "9 woorden", "10 woorden"]
    @IBOutlet weak var aantalWoordenPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aantalWoordenPicker.dataSource = self
        aantalWoordenPicker.delegate = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
