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
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pickerViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController viewDidLoad")
        settingsManager = SettingsManager()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        segmentButton.isEnabled = (UserDefaults.standard.value(forKey: "switchOnOff") as! Bool? ?? isSwitchedOn)
        switchButt.isOn = (UserDefaults.standard.value(forKey: "switchOnOff") as! Bool? ?? isSwitchedOn)
        
      //  print("Defalut values \(settingsManager.getDefaultValue())")
        
        
//        pickerData = settingsManager.getCurrencyCodeForAllLocales()
//        pickerViewHeightConstraint.constant = 0
//       // pickerViewButton.titleLabel?.text = "Currency selected \(settingsManager.currencySymbolFor(currencyCode: settingsManager.getCurrencyCode()))"
//        let buttonTitle = "Currency selected \(settingsManager.currencySymbolFor(currencyCode: settingsManager.getCurrencyCode()))"
//        
//        
//        pickerViewButton.setTitle(buttonTitle, for: .normal)
        
        //print("Settings \(settingsManager.getDefaultValue())")
       // print("code \(settingsManager.getCurrencyCodeForAllLocales())")
        
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
       
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.pickerViewHeightConstraint.constant = !self.isPickerViewOpen ? -250.0 : 0
            self.view.layoutIfNeeded()
        }, completion: {_ in
             self.isPickerViewOpen = true
        })
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UIPickerViewDataSource {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
}

extension SettingsViewController: UIPickerViewDelegate {
    //MARK: Delegates
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        //print("Item is \(component), row \(row)")
        
        settingsManager.storeCurrencyCode(pickerData[row])
        let buttonTitle = "Currency selected \(settingsManager.currencySymbolFor(currencyCode: settingsManager.getCurrencyCode()))"
        pickerViewButton.setTitle(buttonTitle, for: .normal)
        
        //        var pickerLabel = view as! UILabel!
//        if view == nil {  //if no label there yet
//            pickerLabel = UILabel()
//            //color the label's background
//            let hue = CGFloat(row)/CGFloat(pickerData.count)
//            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
//        }
//        let titleData = pickerData[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
//        pickerLabel!.attributedText = myTitle
//        pickerLabel!.textAlignment = .center
//        return pickerLabel
        
        // pickerView. = pickerData[row]
    }

}
