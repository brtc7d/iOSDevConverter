//
//  ViewController.swift
//  iOSDevConverter
//
//  Created by Ben on 10/26/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

struct conversion {
    var label: String
    var inputUnit: String
    var outputUnit: String
}

class ConverterViewController: UIViewController {

    
    
    //display variables
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    //conversion button popup logic
    @IBAction func converterTapped(_ sender: Any) {
        //UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead
        let actionSheet = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for conversion in self.conversions {
            let action = UIAlertAction(title: conversion.label, style: .default) { (action) in
                self.selectedConversionIndex = actionSheet.actions.firstIndex(of: action)!
                self.updateLabels()
            }
            actionSheet.addAction(action)
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    var conversions: [conversion] = []
    var selectedConversionIndex = 0
    
    var inputString = ""
    
    
    //number button functions
    @IBAction func zeroTapped(_ sender: Any) {
        if(inputString != "") {
            addToInput(forPress: 0)
        }
    }
    @IBAction func oneTapped(_ sender: Any) {
        addToInput(forPress: 1)
    }
    @IBAction func twoTapped(_ sender: Any) {
        addToInput(forPress: 2)
    }
    @IBAction func threeTapped(_ sender: Any) {
        addToInput(forPress: 3)
    }
    @IBAction func fourTapped(_ sender: Any) {
        addToInput(forPress: 4)
    }
    @IBAction func fiveTapped(_ sender: Any) {
        addToInput(forPress: 5)
    }
    @IBAction func sixTapped(_ sender: Any) {
        addToInput(forPress: 6)
    }
    @IBAction func sevenTapped(_ sender: Any) {
        addToInput(forPress: 7)
    }
    @IBAction func eightTapped(_ sender: Any) {
        addToInput(forPress: 8)
    }
    @IBAction func nineTapped(_ sender: Any) {
        addToInput(forPress: 9)
    }
    
    //other buttons
    @IBAction func clearTapped(_ sender: Any) {
        inputString = ""
        updateLabels()
    }
    @IBAction func negateTapped(_ sender: Any) {
        if(inputString != "") {
            if(inputString.contains("-")) {
                inputString.remove(at: inputString.startIndex)
            } else {
                inputString.insert(Character("-"), at: inputString.startIndex)
            }
        }
        updateLabels()
    }
    @IBAction func decimalTapped(_ sender: Any) {
        if(!inputString.contains(".")) {
            if(inputString != "") {
                inputString.append(".")
            } else {
                inputString.append("0.")
            }
        }
        updateLabels()
    }
    //utility functions
    func addToInput(forPress number: Int) {
        inputString.append(String(number))
        updateLabels()
    }
    func formatNumberString(_ str: String) -> String {
        if(str == "") {
            return "0"
        }
        return str
    }
    func getNumberFromString(_ str: String) -> Double {
        if let lastChar = str.last {
            if lastChar == "." {
                inputString.remove(at: inputString.endIndex)
                let val = Double(inputString)
                return val!
            } else {
                return Double(str)!
            }
        }
        return 0.0
    }
    
    //conversion formulas
    func applyConversion(to num: Double) -> Double {
        switch selectedConversionIndex {
            
            case 0: // f to c
                return (num - 32) * 5 / 9
            case 1: // c to f
                return num * 9 / 5 + 32
            case 2: // mi to km
                return num * 1.609
            case 3: // km to mi
                return num / 1.069
            default:
                return num
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        conversions.append(conversion(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"))
        conversions.append(conversion(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"))
        conversions.append(conversion(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"))
        conversions.append(conversion(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi"))
        
        updateLabels()
    }
    
    func updateLabels() {
        
        inputDisplay.text = formatNumberString(inputString) + conversions[self.selectedConversionIndex].inputUnit
        
        let converted = applyConversion(to: getNumberFromString(inputString))
        
        
        outputDisplay.text = formatNumberString(String(converted)) + conversions[self.selectedConversionIndex].outputUnit
    }
}

