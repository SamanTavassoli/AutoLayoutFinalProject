//
//  RankingsTableViewController.swift
//  Auto Layout Final Project
//
//  Created by Saman on 26/10/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class RankingsTableViewController: UITableViewController {
    
    var playerData: [Player] = {
        (UIApplication.shared.delegate as! AppDelegate).playerData
    }()
    var selectedPlayer: (Player, Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setPlayerValues(forObject object: AnyObject, withPlayer player: Player, withRank rank: Int) -> AnyObject {
        
        object.playerFirstNameLabel.text = player.0
        object.playerLastNameLabel.text = player.1
        object.playerCountryLabel.text = player.2
        object.playerImageView.image = player.3
        object.playerRankLabel.text = "\(rank)"
        
        return object
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Player Cell", for: indexPath) as! PlayerTableViewCell
        
        cell.contentView.backgroundColor = UIColor(red: 0.20 + CGFloat((indexPath.row)) / 25, green: 0.00, blue: 0.00, alpha: 1.0)
        
        cell = setPlayerValues(forObject: cell, withPlayer: playerData[indexPath.row], withRank: indexPath.row + 1) as! PlayerTableViewCell

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedPlayer = (playerData[indexPath.row], indexPath.row)
        return indexPath
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Rankings to Player Segue" {
            if let playerVC = segue.destination as? PlayerViewController {
                playerVC.delegate = self
            }
        }
    }

}

    // MARK: - PlayerViewControllerDelegate

extension RankingsTableViewController: PlayerViewControllerDelegate {
    
    func getPlayerData(to viewController: UIViewController) {
        if let vC = viewController as? PlayerViewController {
            _ = setPlayerValues(forObject: vC, withPlayer: selectedPlayer!.0, withRank: selectedPlayer!.1 + 1)
        }
    }
    
    
}
