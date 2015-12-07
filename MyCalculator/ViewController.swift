//
//  ViewController.swift
//  MyCalculator
//
//  Created by shuo on 15/12/4.
//  Copyright © 2015年 shuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dispaly: UILabel!
    
    var userInTheMiddleOfTypingANumber = false
   
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber{
            dispaly.text = dispaly.text! + digit
        }else{
            dispaly.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        operandStack.append(dispalyValue)
        userInTheMiddleOfTypingANumber = false
        print(operandStack)
    }
    var dispalyValue: Double{
        get{
            return NSNumberFormatter().numberFromString(dispaly.text!)!.doubleValue
        }
        set{
            dispaly.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "+": performBinaryOperation(){$0 + $1}
        case "-": performBinaryOperation(){$1 - $0}
        case "*": performBinaryOperation(){$0 * $1}
        case "/": performBinaryOperation(){$1 / $0}
        case "√": performUnaryOperation(){sqrt($0)}
        default:break
        }
    }
    func performBinaryOperation(operation: (Double,Double)->Double){
            if operandStack.count >= 2{
                dispalyValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    func performUnaryOperation(operation: Double->Double){
        if operandStack.count >= 1{
            dispalyValue = operation(operandStack.removeLast())
        }
        enter()
    }
}

