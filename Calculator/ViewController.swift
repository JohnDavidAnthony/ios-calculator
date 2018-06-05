//
//  ViewController.swift
//  Calculator
//
//  Created by John David Anthony on 2018-06-04.
//  Copyright © 2018 John David Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Adding all the Buttons and display
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    
    var outputValue: Double = 0
    var tempValue: Double = 0
    var cleared = true
    var selectedOpp: String = ""
    var oppSelected = false
    var firstAfterOpp = false
    var calculateNext = true
    var editingBlocked = false
    var numberEntered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clear(_ sender: Any) {
        outputValue = 0
        outputLabel.text = "0"
        cleared = true
        plusButton.isSelected = false
        negativeButton.isSelected = false
        multiplyButton.isSelected = false
        divideButton.isSelected = false
        selectedOpp = ""
    }

    //Function that adds the corrosponind number for each button to the screen
    @IBAction func numberButton(_ sender: UIButton) {
        //TODO Figure out what all the "UnWrapping" ? ! does
        
        //Check if Label is cleared
        if cleared{
            outputLabel.text = sender.currentTitle!
            cleared = false
            //Clear Opperators
            oppSelected = false
            selectedOpp = ""
            editingBlocked = false
            
        }
        else if !editingBlocked{
            if firstAfterOpp{
                tempValue = Double(outputLabel.text!)!
                outputLabel.text = sender.currentTitle!
                firstAfterOpp = false
            }
            else{
                outputLabel.text! += sender.currentTitle!
            }
        }
        numberEntered = false
    }
    
    //Doesn't add a decimal if one already exists
    @IBAction func decimalButton(_ sender: UIButton) {
        if !(outputLabel.text!.contains(".")) {
            outputLabel.text! += "."
        }
        //Removes decimal if it was the last thing added when button pressed again
        else if outputLabel.text!.last == "."{
            outputLabel.text!.removeLast()
        }
    }
    
    //Reciprocates number
    @IBAction func negateButton(_ sender: UIButton) {
        if outputLabel.text!.contains("-"){
            outputLabel.text!.remove(at: outputLabel.text!.startIndex)
        }
        else{
            outputLabel.text!.insert("-", at: outputLabel.text!.startIndex)
        }
    }
    
    //Updates the current opperator
    @IBAction func opperatorButton(_ sender: UIButton) {
        //Deselect Button
        plusButton.isSelected = false
        negativeButton.isSelected = false
        multiplyButton.isSelected = false
        divideButton.isSelected = false
        
        //Pressed button is the currently selected op:
        if oppSelected && selectedOpp == sender.currentTitle{
            //Calculate
            if numberEntered {
                calculateButton(UIButton())
                oppSelected = false
                selectedOpp = ""
                firstAfterOpp = false
                calculateNext = false
                numberEntered = false
            }
            //Cancel opp
            else{
                oppSelected = false
                selectedOpp = ""
                firstAfterOpp = false
                calculateNext = false
            }
            
        }
        //Pressed Button is different operator switch current operator
        else if oppSelected && !calculateNext && selectedOpp != sender.currentTitle{
            selectedOpp = sender.currentTitle!
            //Highlight operator
            sender.isSelected = true
        }
        //Operator Pressed for first time
        else{
            //Highlight operator
            sender.isSelected = true
            //update operator
            editingBlocked = false
            selectedOpp = sender.currentTitle!
            oppSelected = true
            firstAfterOpp = true
            calculateNext = true
        }
    }
    //Percentage Button
    @IBAction func percentageButton(_ sender: UIButton) {
        outputLabel.text = String(Double(outputLabel.text!)! / 100)
        oppSelected = false
    }
    
    
    //Calculate
    @IBAction func calculateButton(_ sender: UIButton) {
        var outputValue: Double = Double(outputLabel.text!)!
        switch selectedOpp{
        case "-":
            outputValue = tempValue - Double(outputLabel.text!)!
            break
        case "+":
            outputValue = tempValue + Double(outputLabel.text!)!
            break
        case "*":
            outputValue = tempValue * Double(outputLabel.text!)!
            break
        case "/":
            outputValue = tempValue / Double(outputLabel.text!)!
            break
        default:
            print("error")
        }
        
        oppSelected = false

        outputLabel.text = String(outputValue)
        editingBlocked = true
        plusButton.isSelected = false
        negativeButton.isSelected = false
        multiplyButton.isSelected = false
        divideButton.isSelected = false
    }
    
    
    
    
    
}

