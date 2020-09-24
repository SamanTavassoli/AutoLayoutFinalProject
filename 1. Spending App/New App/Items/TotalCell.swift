//
//  TitleAndTotalTableViewCell.swift
//  New App
//
//  Created by Saman on 10/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class TotalCell: UITableViewCell {

    @IBOutlet var stackView1: StackView1!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
class StackView1: UIStackView {
    @IBOutlet weak var totalCostLabel: UILabel!
}
