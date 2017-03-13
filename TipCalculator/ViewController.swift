//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pawan selokar on 3/10/17.
//  Copyright © 2017 Pawan selokar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tipCal: TipCalculatorManager!
    var settingsManager: SettingsManager!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var totalAmountTextFeild: UITextField!
    @IBOutlet weak var tipAmountTextFeild: UITextField!
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var totalAmountButton: UIButton!
    
    var currencySymbol: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController .. viewdidLoad")
        
        totalAmountTextFeild.keyboardType  = .decimalPad
        tipAmountTextFeild.keyboardType = .decimalPad
        totalAmountTextFeild.delegate = self
        tipAmountTextFeild.delegate = self
        
        tipCal = TipCalculatorManager()
        settingsManager = SettingsManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         print("ViewController .. viewdidAppear")
        //TODO: Get the currency code and Symbol
        let currencyCode =  settingsManager.getCurrencyCode()
        currencySymbol = settingsManager.currencySymbolFor(currencyCode: currencyCode)
        print("currency used \(currencySymbol)")
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 70)
        label.text = " Tip: \(currencySymbol)"
        label.font = UIFont.systemFont(ofSize: 20)
        tipAmountTextFeild.leftViewMode = UITextFieldViewMode.always
        
        tipAmountTextFeild.leftView = label
        
        
        let label1 = UILabel()
        label1.text = " Amount: \(currencySymbol)"
        label1.font = UIFont.systemFont(ofSize: 20)
        label1.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        totalAmountTextFeild.leftViewMode = UITextFieldViewMode.always
        totalAmountTextFeild.leftView = label1

        segmentedButton.isEnabled = (UserDefaults.standard.value(forKey: "switchOnOff") as! Bool? ?? false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlButtonClicked(_ sender: UISegmentedControl) {
       tipCal.isTipPercentageSelected = true
        //segmentedButton.isMomentary = false
       // segmentedButton.selectedSegmentIndex = UISegmentedControlNoSegment
        
        var segmentTitle: String = ""
        switch sender.selectedSegmentIndex {
        case 0:
            segmentTitle = String(sender.titleForSegment(at: 0)!.characters.dropLast())
        case 1:
            segmentTitle = String(sender.titleForSegment(at: 1)!.characters.dropLast())
        case 2:
            segmentTitle = String(sender.titleForSegment(at: 2)!.characters.dropLast())
        default:
            print("Should not selected")
        }
        
        tipCal.tipPercent = Double(segmentTitle)!
        
        tipAmountTextFeild.text = String(tipCal.tipAmountCalculated)
        
        let totalAmount = "\(currencySymbol)\(String(tipCal.totalAmount))"
        totalAmountLable.text =  "Total amount: \(totalAmount)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
     }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        segmentedButton.isMomentary = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        if textField == totalAmountTextFeild {
            tipCal.amoutBeforeTip = Double(newText) ?? 0
            segmentedButton.selectedSegmentIndex = UISegmentedControlNoSegment
            //segmentedButton.isMomentary = true
        } else {
            tipCal.tipAmount = Double(newText) ?? 0
            tipCal.isTipPercentageSelected = false
            //segmentedButton.isMomentary = true
            segmentedButton.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        
        print("Before Amount \(tipCal.amoutBeforeTip) tipAmount \(tipCal.tipAmount) totalAmount \(tipCal.totalAmount)")
        
        let totalAmount = "\(currencySymbol)\(String(tipCal.totalAmount))"
        totalAmountLable.text =  "Total amount: \(totalAmount)"
        return true
    }
}

