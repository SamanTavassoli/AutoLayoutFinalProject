//
//  MonthCell.swift
//  New App
//
//  Created by Saman on 06/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class MonthCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet var monthTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

