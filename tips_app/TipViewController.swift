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
    @IBOutlet weak var numberOfGuests: UILabel!
    @IBOutlet weak var splitTip: UILabel!
    
    var tipPercentages = [0.1, 0.2, 0.3]
    var animationFLAG = false
    

    @IBOutlet weak var tipView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates the instance for the leftSwipe.
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "swipeChangeNumberOfGuests:")
        leftSwipe.direction = .Left
        self.view.addGestureRecognizer(leftSwipe)
        
        // Creates the instance for the rightSwipe.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "swipeChangeNumberOfGuests:")
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
        
        billField.center.y += 65.5
        tipView.center.y += view.bounds.height
        tipControl.center.y += view.bounds.height
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // These two lines of code change the currency based on locale (Ex: $ to ...).
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        
        
        // This makes the textfield the first responder when the view is loaded.
        billField.becomeFirstResponder()
        billField.placeholder = numberFormatter.currencySymbol
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
        // These two lines of code change the currency based on locale (Ex: $ to ...).
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        
        if(!animationFLAG){
            if(billField.text != nil){
                UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
                    self.billField.center.y -= 65.5
                    self.tipControl.center.y -= self.view.bounds.height
                    self.tipView.center.y -= self.view.bounds.height
                    }, completion: nil)
                animationFLAG = true
            }
        }else{
            if(billField.text == ""){
                UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
                    self.billField.center.y += 65.5
                    self.tipControl.center.y += self.view.bounds.height
                    self.tipView.center.y += self.view.bounds.height
                    }, completion: nil)
                animationFLAG = false
                
            }
        }
        
        // This function returns the total amount, the split amount, and the tip amount in the view.
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = tip + billAmount
        let numbofGuest = (numberOfGuests.text! as NSString).doubleValue
        let splitBill = total / numbofGuest
        
        tipLabel.text = numberFormatter.stringFromNumber(tip)
        totalLabel.text = numberFormatter.stringFromNumber(total)
        splitTip.text = numberFormatter.stringFromNumber(splitBill)
    }
    
    
    
    @IBAction func endBillingOnTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func swipeChangeNumberOfGuests(sender: AnyObject) {
        // These two lines of code change the currency based on locale (Ex: $ to ...).
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        
        let total = numberFormatter.numberFromString(totalLabel.text! as String)
        var count = (numberOfGuests.text! as NSString).intValue
        
        // The swipe gestures increments the number of guests number and divides the total amount by that number.
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            // If the swipe is left decrement, if the swipe is right increment.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if let old_total = total{
                    count += 1
                    let new_total = (old_total as Double)/Double(count)
                    numberOfGuests.text = String(count)
                    splitTip.text = numberFormatter.stringFromNumber(new_total)
                }
            case UISwipeGestureRecognizerDirection.Left:
                if (count > 1){
                    if let old_total = total{
                        count -= 1
                        let new_total = (old_total as Double)/Double(count)
                        numberOfGuests.text = String(count)
                        splitTip.text = numberFormatter.stringFromNumber(new_total)
                    }
                }
            default:
                break
            }
        }
    }
}

