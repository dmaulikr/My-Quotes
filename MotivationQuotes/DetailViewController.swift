//
//  DetailViewController.swift
//  MotivationQuotes
//
//  Created by Ty rainey on 5/10/17.
//  Copyright © 2017 Ty rainey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var vc: ViewController!
    var quotePassed = ""
    var authorPassed = ""
    var categoryPassed = ""

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateUI() {
        
        quoteLabel.text = quotePassed
        authorLabel.text = authorPassed
        categoryLabel.text = categoryPassed
        
    }

}
