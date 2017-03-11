//
//  Settings.swift
//  TipCalculator
//
//  Created by Pawan selokar on 3/10/17.
//  Copyright © 2017 Pawan selokar. All rights reserved.
//

import Foundation

class SettingsManager {
   
    static let shared = SettingsManager()
    
    func getCurrencyCodeForAllLocales()  -> [String] {
        let locales = NSLocale.availableLocaleIdentifiers
        var codeArray = [String]()
        for localeId in locales {
            let locale = NSLocale(localeIdentifier: localeId)
            if let code = locale.object(forKey: NSLocale.Key.currencyCode) as? String{
                if !codeArray.contains(code) {
                    codeArray.append(code)
                }
            }
        }
        codeArray.sort{$0 < $1}
        return codeArray
    }
    
    func getCurrencyCode() -> String {
        if let currecyCode = UserDefaults.standard.value(forKey: "currencyCode") {
            return currecyCode as! String
        } else {
            return Locale.current.currencyCode! as String
        }
    }
    
    func storeCurrencyCode(_ currencyCode: String) {
        if (UserDefaults.standard.value(forKey: "currencyCode") == nil) {
            UserDefaults.standard.set(currencyCode, forKey: "currencyCode")
        } else {
           print("Value is already stored")
        }
    }
    
    func currencySymbolFor(currencyCode: String) -> String {
         return (Locale(identifier:"de") as NSLocale).displayName(forKey: .currencySymbol, value: currencyCode)!
    }
    
    func getDefaultValue() -> [String: Double] {
        return UserDefaults.standard.dictionary(forKey: "defaultValues") as! [String : Double]
    }
}

extension Double {
    func currencySymbol() -> String {
        let code = UserDefaults.standard.value(forKey: "currencyCode")
        let symbol = (Locale(identifier:"de") as NSLocale).displayName(forKey: .currencySymbol, value: code!)!
        return "\(symbol)\(self)"
    }
}

extension String {
    func currencySymbol() -> String {
        let code = UserDefaults.standard.value(forKey: "currencyCode")
        let symbol = (Locale(identifier:"de") as NSLocale).displayName(forKey: .currencySymbol, value: code!)!
        return "\(symbol)\(self)"
    }
}
