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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController .. viewdidLoad")
        
        tipCal = TipCalculatorManager()
        tipCal!.amoutBeforeTip = 100
        tipCal!.tipPercent = 10
        let values = tipCal.deafultValues
        
        print("Tip amount: \(tipCal!.tipAmount), total amount: \(tipCal!.totalAmount)")
        
        print("default values \(values)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

