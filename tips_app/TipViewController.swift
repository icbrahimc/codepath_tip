//
//  ViewController.swift
//  tips_app
//
//  Created by Ibrahim Conteh on 12/13/15.
//  Copyright © 2015 Ibrahim Conteh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipPercentages = [0.1, 0.2, 0.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToTipViewController(segue: UIStoryboardSegue){
        if segue.identifier == "Submit"{
            
            let addVC = segue.sourceViewController as! SettingsViewController
            // Receive all the changed values from the last view.
            if let oneField = addVC.one{
                tipPercentages[0] = oneField
                let title = String(format: "%.0f", oneField*100) + "%"
                tipControl.setTitle(title, forSegmentAtIndex: 0)
            }
            
            if let twoField = addVC.two{
                tipPercentages[1] = twoField
                let title = String(format: "%.0f", twoField*100) + "%"
                tipControl.setTitle(title, forSegmentAtIndex: 1)
            }
            
            if let threeField = addVC.three{
                tipPercentages[2] = threeField
                let title = String(format: "%.0f", threeField*100) + "%"
                tipControl.setTitle(title, forSegmentAtIndex: 2)
            }
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = tip + billAmount
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

