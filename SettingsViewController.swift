//
//  SettingsViewController.swift
//  Tippr
//
//  Created by Girish Rawat on 1/6/17.
//  Copyright © 2017 Girish Rawat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tipIndexValue = UserDefaults.standard.integer(forKey: "tipIndex")
        //print (tipIndexValue)
        tipControl.selectedSegmentIndex = tipIndexValue
        
    }
    @IBAction func dismissModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func defaultTipChanged(_ sender: AnyObject) {
        let tipIndex = tipControl.selectedSegmentIndex
        //print ("Tip setting changed")
        UserDefaults.standard.set(tipIndex, forKey: "tipIndex")
        UserDefaults.standard.set(true, forKey: "defaultsChanged")
        UserDefaults.standard.synchronize()
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
