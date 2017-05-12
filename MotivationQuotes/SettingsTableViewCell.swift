//
//  SettingsTableViewCell.swift
//  MotivationQuotes
//
//  Created by Ty rainey on 5/12/17.
//  Copyright © 2017 Ty rainey. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBAction func switchAction(_ sender: UISwitch) {
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
