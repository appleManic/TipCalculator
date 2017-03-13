//
//  TipCalculatorManager.swift
//  TipCalculator
//
//  Created by Pawan selokar on 3/10/17.
//  Copyright © 2017 Pawan selokar. All rights reserved.
//

import Foundation
import UIKit

enum Service {
    case bad, okay, excellent
}

class TipCalculatorManager {
  //
    var deafultValues: [String: Double]! {
        didSet {
            let  deafultVal = ["bad": 15 , "okay": 18, "excellent": 20]
            UserDefaults.standard.set(deafultVal, forKey: "defaultValues")
        }
    }
    
    init() {
        print("TipCalculatorManager init")
        if let deafultValues = UserDefaults.standard.dictionary(forKey: "defaultValues") {
            self.deafultValues = deafultValues as? [String : Double]
        } else {
           let  deafultVal = ["bad": 15 , "okay": 18, "excellent": 20]
            UserDefaults.standard.set(deafultVal, forKey: "defaultValues")
        }
    }
    
    var isTipPercentageSelected = false
    
    var amoutBeforeTip: Double = 0
    
    var tipPercent: Double = 0 {
        didSet {
            if tipPercent < 0 {
                print("Tip cannot be negative")
                tipPercent = 0
            }
        }
    }
    
    var tipAmountCalculated: Double {
        get{
            return (amoutBeforeTip * tipPercent / 100)
        }
    }
    
    var tipAmount: Double = 0
    
    
    var totalAmount: Double {
        get {return (amoutBeforeTip + (isTipPercentageSelected ? (amoutBeforeTip * tipPercent / 100) : tipAmount ))}
        set(newValue) {
            amoutBeforeTip = newValue
        }
    }

}

    
