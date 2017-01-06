//
//  ViewController.swift
//  Tippr
//
//  Created by Girish Rawat on 1/5/17.
//  Copyright © 2017 Girish Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var upperView: UIView!

    @IBAction func onTap(_ sender: Any) {
        //print("Hello")
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0
        
        let tipPercentages = [0.18, 0.20, 0.22]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.groupingSeparator = ","
        let currencysymbol = Locale.current.currencySymbol
        billField.placeholder = currencysymbol
        
        tipLabel.text = String(format: (currencysymbol ?? "$") + "%.2f" , tip)
        totalLabel.text = formatter.string(from: total)
        
        if (billField.text?.isEmpty)! {
            degradeView(animated: true)
        } else {
            highlightView()
        }
    }
    
    private func degradeView(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                let pureWhite = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0)
                self.upperView.backgroundColor = pureWhite
                self.tipLabel.text = "Tip"
                self.tipLabel.alpha = 0.4
                self.totalLabel.text = "Total"
                self.totalLabel.alpha = 0.4
            })
        }
    }
    
    private func highlightView() {
        UIView.animate(withDuration: 0.3, animations: {
            let offWhite = UIColor(red: 203.0/255.0, green: 243.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            self.upperView.backgroundColor = offWhite
            self.tipLabel.alpha = 1.0
            self.totalLabel.alpha = 1.0
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let bill = Double(billField.text!) ?? 0
        let currentTimestamp = Int(NSDate().timeIntervalSince1970);
        UserDefaults.standard.set(currentTimestamp, forKey: "lastCalculationTime")
        UserDefaults.standard.set(bill, forKey: "lastTip")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Open keyboard automatically when view loads
        // Do any additional setup after loading the view, typically from a nib.
            }
    
    override func viewDidAppear(_ animated: Bool) {
        // Save data for 10 minutes
        let lastSessionTime = UserDefaults.standard.integer(forKey: "lastCalculationTime") ?? 0;
        let currentTimestamp = Int(NSDate().timeIntervalSince1970);
        let lastSavedTip = UserDefaults.standard.integer(forKey: "lastTip") ?? 0;
        if(currentTimestamp - lastSessionTime < 600) { // 10 minutes
            print (currentTimestamp)
            print (lastSessionTime)
            print ("Less than 10 minutes")
            if (lastSavedTip != 0) {
                billField.text = String(lastSavedTip)
                self.calculateTip(self)
            }
        }
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let bill = Double(billField.text!) ?? 0
        let defaultsChanged = UserDefaults.standard.bool(forKey: "defaultsChanged")
        //print (defaultsChanged)

        if (defaultsChanged || bill == 0) {
            let tipIndexValue = UserDefaults.standard.integer(forKey: "tipIndex")
            tipControl.selectedSegmentIndex = tipIndexValue
            UserDefaults.standard.set(false, forKey: "defaultsChanged")
        }
        self.calculateTip(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

