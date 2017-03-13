//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Pawan selokar on 3/10/17.
//  Copyright © 2017 Pawan selokar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settingsManager: SettingsManager!
    var pickerData = [String]()
    var isPickerViewOpen = false
    var isSwitchedOn = false
    
    @IBOutlet weak var segmentButton: UISegmentedControl!
    @IBOutlet weak var switchButt: UISwitch!
    
    @IBOutlet weak var pickerViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController viewDidLoad")
        settingsManager = SettingsManager()
        
        segmentButton.isEnabled = (UserDefaults.standard.value(forKey: "switchOnOff") as! Bool? ?? isSwitchedOn)
        switchButt.isOn = (UserDefaults.standard.value(forKey: "switchOnOff") as! Bool? ?? isSwitchedOn)
        
        pickerViewButton.isEnabled = false
    
        let currencyCode =  settingsManager.getCurrencyCode()
        let currencySymbol = settingsManager.currencySymbolFor(currencyCode: currencyCode)
        
        let buttonTitle = "Currency selected \(currencyCode): \(currencySymbol)"
        pickerViewButton.setTitle(buttonTitle, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchClicked(_ sender: UISwitch){
        sender.isOn  = !isSwitchedOn
        isSwitchedOn = !isSwitchedOn
        segmentButton.isEnabled = isSwitchedOn
        UserDefaults.standard.set(isSwitchedOn, forKey: "switchOnOff")
        
        let  deafultVal = ["bad": 15 , "okay": 18, "excellent": 20]
        UserDefaults.standard.set(deafultVal, forKey: "defaultValues")
    }
    
    @IBAction func pickerViewAction(_ sender: UIButton) {
        let currencyCode = settingsManager.getCurrencyCode()
        let currencySymbol = settingsManager.currencySymbolFor(currencyCode: currencyCode)
        pickerViewButton.setTitle("Currency code: \(currencyCode) Currency symbol: \(currencySymbol)", for: .normal)
    }
}
