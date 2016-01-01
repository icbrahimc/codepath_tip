//
//  SettingsViewController.swift
//  tips_app
//
//  Created by Ibrahim Conteh on 12/14/15.
//  Copyright © 2015 Ibrahim Conteh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var percentageOneField: UITextField!
    
    @IBOutlet weak var percentageTwoField: UITextField!

    @IBOutlet weak var percentageThreeField: UITextField!
    
    var one: Double?
    var two: Double?
    var three: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Submit"{
            if let oneField = percentageOneField.text{
                if !oneField.isEmpty{
                    // Change the value to a double and make it a percent.
                    one = (oneField as NSString).doubleValue / 100
                }
            }
            
            if let twoField = percentageTwoField.text{
                if !twoField.isEmpty{
                    // Change the value to a double and make it a percent.
                    two = (twoField as NSString).doubleValue / 100
                }
            }
            
            if let threeField = percentageThreeField.text{
                if !threeField.isEmpty{
                    // Change the value to a double and make it a percent.
                    three = (threeField as NSString).doubleValue / 100
                }
            }
        }
    }
    
    @IBAction func endChangesOnTap(sender: AnyObject) {
        view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
