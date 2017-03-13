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
        
        //TODO: Get the currency code and Symbol
       let currencyCode =  settingsManager.getCurrencyCode()
        currencySymbol = settingsManager.currencySymbolFor(currencyCode: currencyCode)
        print(currencySymbol)
        
        
        // 
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 20, height: 70)
        label.text = currencySymbol
        label.font = UIFont.systemFont(ofSize: 20)
        tipAmountTextFeild.leftViewMode = UITextFieldViewMode.always
        
        tipAmountTextFeild.leftView = label
        
        
        let label1 = UILabel()
        label1.text = currencySymbol
        label1.font = UIFont.systemFont(ofSize: 20)
        label1.frame = CGRect(x: 0, y: 0, width: 20, height: 70)
        totalAmountTextFeild.leftViewMode = UITextFieldViewMode.always
        totalAmountTextFeild.leftView = label1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlButtonClicked(_ sender: UISegmentedControl) {
       tipCal.isTipPercentageSelected = true
        
        if sender.isSelected {
            tipAmountTextFeild.text = ""
        }
        
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
        
        let totalAmount = "\(currencySymbol)\(String(tipCal.totalAmount))"
        totalAmountButton.setTitle(totalAmount, for: .normal)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
     }
    
    @IBAction func totalAmountButtonClicked(_ sender: UIButton) {
       let totalAmount = "\(currencySymbol)\(String(tipCal.totalAmount))"
        totalAmountButton.setTitle(totalAmount, for: .normal)
        //totalAmountButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        totalAmountButton.setTitle("Click to get total amount", for: .normal)
        segmentedButton.isMomentary = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField == totalAmountTextFeild {
            tipCal.amoutBeforeTip = Double((totalAmountTextFeild.text)!) ?? 0
        } else {
            tipCal.tipAmount = Double((tipAmountTextFeild.text)!) ?? 0
            tipCal.isTipPercentageSelected = false
        
        }
        print("Before Amount \(tipCal.amoutBeforeTip) tipAmount \(tipCal.tipAmount) totalAmount \(tipCal.totalAmount)")
    }
}

