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

    @IBAction func onTap(_ sender: Any) {
        //print("Hello")
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0
        
        let tipPercentages = [0.18, 0.20, 0.22]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f" , tip)
        totalLabel.text = String(format: "$%.2f" , total)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Open keyboard automatically when view loads
        billField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
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

