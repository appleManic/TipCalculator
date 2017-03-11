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
            let  deafultVal = ["bad": 50 , "okay": 18, "excellent": 20]
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
    
    var amoutBeforeTip: Double?
    
    var tipPercent: Double = 0 {
        didSet {
            if tipPercent < 0 {
                print("Tip cannot be negative")
                tipPercent = 0
            }
        }
    }
    
    var tipAmount: Double {
            return (amoutBeforeTip! * tipPercent / 100)
    }
    
    var totalAmount: Double {
        get {return (amoutBeforeTip! + amoutBeforeTip! * tipPercent / 100)}
        set(newValue) {
            amoutBeforeTip = newValue
        }
    }

}

    
