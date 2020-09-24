//
//  ItemCell.swift
//  New App
//
//  Created by Saman on 10/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var costTextfield: UITextField!
    
    @IBAction func editingDidEnd(_ sender: Any) {
        // here maybe make it so if you enter 2 it updates to 2.0 to make everything uniform
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
