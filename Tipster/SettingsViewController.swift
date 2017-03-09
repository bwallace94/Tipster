//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Bria Wallace on 3/7/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var Tip15: UIButton!
    @IBOutlet weak var Tip18: UIButton!
    @IBOutlet weak var Tip20: UIButton!
    @IBOutlet weak var Tip25: UIButton!
    
    var defaultTip:Double = 0.18
    
    @IBAction func changeDefaultTip(_ sender: AnyObject) {
        changeTipButtons(sender)
        let defaults = UserDefaults.standard
        defaults.set(defaultTip, forKey: "Default Tip")
        defaults.synchronize()
    }
    
    func changeTipButtonByPerc(_ sender: Double) {
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
    }
    
    func changeTipButtons(_ sender: AnyObject) {
        resetButtons()
        sender.titleLabel??.font = UIFont(name: "Lato-Regular", size: 24)
        sender.setTitleColor(tealColor, for: .normal)
        switch sender as! UIButton {
        case Tip15:
            defaultTip = 0.15
        case Tip18:
            defaultTip = 0.18
        case Tip20:
            defaultTip = 0.20
        case Tip25:
            defaultTip = 0.25
        default:
            defaultTip = 0.18
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaultTip = (defaults.object(forKey: "Default Tip") as! Double?) ?? 0.18
        changeTipButtonByPerc(defaultTip)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
