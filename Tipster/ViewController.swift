//
//  ViewController.swift
//  Tipster
//
//  Created by Bria Wallace on 2/28/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

///UIView that displays tip to pay based on bill and desired percentage
class ViewController: UIViewController, UITextFieldDelegate{

    //MARK: - IBOutlets
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    ///UILabel that displays the tip user should pay
    @IBOutlet weak var tipLabel: UILabel!
    
    ///UILabel that displays total amount user should pay
    @IBOutlet weak var totalLabel: UILabel!
    
    ///UIField for user to input bill amount before tip
    @IBOutlet weak var billField: UITextField!
    
    ///UIButtons to select what tip percentage to leave
    @IBOutlet weak var Tip15: UIButton!
    @IBOutlet weak var Tip18: UIButton!
    @IBOutlet weak var Tip20: UIButton!
    @IBOutlet weak var Tip25: UIButton!
    
    ///UIButtons to select whether to round tip to leave
    @IBOutlet weak var roundTrue: UIButton!
    @IBOutlet weak var roundFalse: UIButton!
    
    @IBAction func exitSettings(segue: UIStoryboardSegue) {
        
    }
    
    
    var selectedTip:Double =  0.18
    
//    //MARK: - IBAction
//    /**
//     Tap gesture recognizer that hides keyboard
//     
//     - Parameter sender: Any object, tap gesture recognizer in UIView
//     
//     - Returns: void
//    */
//    @IBAction func onTap(_ sender: AnyObject) {
//        view.endEditing(true)
//    }

    
    /**
     Calculates tip based on bill input and selected tip percentage
     
     - Parameter sender: Any object, tipControl and billField
     
     - Returns: void
    */
    @IBAction func calculateTip(_ sender: AnyObject) {
        if sender.tag != 0 {
            changeTipButtons(sender)
        }
        var billEdited = billField.text!
        let defaults = UserDefaults.standard
        defaults.set(billEdited, forKey: "Stored Bill Amount")
        defaults.set(NSDate.init(), forKey: "Stored Bill Time")
        defaults.synchronize()
        billEdited.remove(at: (billEdited.startIndex))
        let bill = Double(billEdited) ?? 0
        let tip = bill * selectedTip
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func roundOrUnround(_ sender: AnyObject) {
        var billEdited = billField.text!
        billEdited.remove(at: (billEdited.startIndex))
        let bill = Double(billEdited) ?? 0
        var tip = bill * selectedTip
        var total = bill * (1 + selectedTip)
        switch sender as! UIButton {
        case roundTrue:
            roundTrue.isHidden = true
            roundTrue.isEnabled = false
            roundFalse.isHidden = false
            roundFalse.isEnabled = true
            tip = bill * selectedTip
            total = bill + tip
        case roundFalse:
            roundTrue.isHidden = false
            roundTrue.isEnabled = true
            roundFalse.isHidden = true
            roundFalse.isEnabled = false
            total = ceil(total)
            tip = total - bill
        default:
            roundTrue.isHidden = false
            roundTrue.isEnabled = false
            roundFalse.isHidden = true
            roundFalse.isEnabled = true
            tip = bill * selectedTip
            total = bill + tip
                    }
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func changeTipButtonByPercAndCalculate(_ sender: Double) {
        switch sender {
        case 0.15:
            changeTipButtons(Tip15)
        case 0.18:
            changeTipButtons(Tip18)
        case 0.2:
            changeTipButtons(Tip20)
        case 0.25:
            changeTipButtons(Tip25)
        default:
            changeTipButtons(Tip18)
        }
        var billEdited = billField.text!
        billEdited.remove(at: (billEdited.startIndex))
        let bill = Double(billEdited) ?? 0
        let tip = bill * selectedTip
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func changeTipButtons(_ sender: AnyObject) {
        resetButtons()
        sender.titleLabel??.font = UIFont(name: "Lato-Regular", size: 24)
        sender.setTitleColor(tealColor, for: .normal)
        switch sender as! UIButton {
        case Tip15:
            selectedTip = 0.15
        case Tip18:
            selectedTip = 0.18
        case Tip20:
            selectedTip = 0.20
        case Tip25:
            selectedTip = 0.25
        default:
            selectedTip = 0.18
            Tip18.titleLabel?.font = UIFont(name: "Lato-Regular", size: 24)
            Tip18.setTitleColor(tealColor, for: .normal)
        }
    }
    
    func resetButtons() {
        Tip15.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        Tip18.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        Tip20.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        Tip25.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        Tip15.setTitleColor(grayColor, for: .normal)
        Tip18.setTitleColor(grayColor, for: .normal)
        Tip20.setTitleColor(grayColor, for: .normal)
        Tip25.setTitleColor(grayColor, for: .normal)
        roundTrue.isHidden = true
        roundTrue.isEnabled = false
        roundFalse.isHidden = false
        roundFalse.isEnabled = true
    }
    
    //MARK: - General Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            let currentString = textField.text
            if currentString?.characters.count == 1{
                return false
            }
        }
        if string.contains(".") && textField.text!.contains(".") {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billField.delegate = self
        self.billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.billField.delegate = self
        self.billField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        selectedTip = (defaults.object(forKey: "Default Tip") as! Double?) ?? 0.18
        if (defaults.object(forKey: "Stored Bill Amount") != nil) {
            let lastTime = defaults.object(forKey: "Stored Bill Time") as! NSDate
            if NSDate().timeIntervalSince(lastTime as Date) < 600 {
                billField.text = defaults.object(forKey: "Stored Bill Amount") as! String?
                calculateTip(billField)
            }
            else {
                defaults.removeObject(forKey: "Stored Bill Amount")
                defaults.removeObject(forKey: "Stored Bill Time")
            }
        }
        changeTipButtonByPercAndCalculate(selectedTip)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

