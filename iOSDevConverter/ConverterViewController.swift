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

    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
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
    var selectedConversionIndex = 0;
    
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
        outputDisplay.text = conversions[self.selectedConversionIndex].outputUnit
        inputDisplay.text = conversions[self.selectedConversionIndex].inputUnit
    }
}

