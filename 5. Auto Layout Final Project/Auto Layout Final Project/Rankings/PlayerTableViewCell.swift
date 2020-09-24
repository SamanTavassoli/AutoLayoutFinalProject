//
//  PlayerTableViewCell.swift
//  Auto Layout Final Project
//
//  Created by Saman on 28/10/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var playerFirstNameLabel: UILabel!
    @IBOutlet var playerLastNameLabel: UILabel!
    @IBOutlet var playerCountryLabel: UILabel!
    @IBOutlet var playerRankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
