//
//  PlayerViewController.swift
//  Auto Layout Final Project
//
//  Created by Saman on 26/10/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

protocol PlayerViewControllerDelegate: class {
    func getPlayerData(to viewController: UIViewController)
}

class PlayerViewController: UIViewController {
    
    
    // MARK: - Vars and Outlets
    
    weak var delegate: PlayerViewControllerDelegate?
    var constraints: [NSLayoutConstraint] = []

    //passed on data
    @IBOutlet var playerFirstNameLabel: UILabel!
    @IBOutlet var playerLastNameLabel: UILabel!
    @IBOutlet var playerCountryLabel: UILabel!
    @IBOutlet var playerRankLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    
    //Outlets for constraints
    @IBOutlet var infoStackView: UIStackView!
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet var leftTableView: UITableView!
    @IBOutlet var rightTableView: UITableView!
    
    
    // MARK: - View Loading functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // to be able to use programmed constraints
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        for subview in infoStackView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        activateConstraints(hSC: traitCollection.horizontalSizeClass, vSC: traitCollection.verticalSizeClass)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.getPlayerData(to: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        infoStackView.addBackground(color: .darkGray, withBorderWidth: 2.5)
        
        playerImageView.layer.borderWidth = 2.5
        
        playerCountryLabel.backgroundColor = .darkGray
        playerCountryLabel.layer.borderWidth = 2.5
        
        flagImageView.backgroundColor = .darkGray
        flagImageView.layer.borderWidth = 2.5
        
        leftTableView.backgroundColor = .darkGray
        leftTableView.layer.borderWidth = 2.5
        
        rightTableView.backgroundColor = .darkGray
        rightTableView.layer.borderWidth = 2.5
        
    }
    
    // MARK: - Constraints and Size Class handle
    
    override func viewSafeAreaInsetsDidChange() {
        activateConstraints(hSC: traitCollection.horizontalSizeClass, vSC: traitCollection.verticalSizeClass)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass != previousTraitCollection!.verticalSizeClass
            || traitCollection.horizontalSizeClass != previousTraitCollection!.horizontalSizeClass {
            activateConstraints(hSC: traitCollection.horizontalSizeClass, vSC: traitCollection.verticalSizeClass)
        }
    }
    
    
    func styleStackView() {
        infoStackView.isLayoutMarginsRelativeArrangement = true // taking margins into account
        infoStackView.layoutMargins.top = 50 // hardcoded cause idk why it kept calculating different values
        infoStackView.layoutMargins.bottom = 50
        print(infoStackView.frame.height)
        infoStackView.spacing = 5.0
        if traitCollection.verticalSizeClass != .regular {
            infoStackView.isLayoutMarginsRelativeArrangement = false
        }
    }
    
    // vfl + anchor constraints depending on Size Class
    
    func activateConstraints(hSC: UIUserInterfaceSizeClass, vSC: UIUserInterfaceSizeClass) {
        NSLayoutConstraint.deactivate(constraints)
        constraints = []
        
        
        let views: [String: Any] = [
            "firstName" : playerFirstNameLabel!,
            "lastName" : playerLastNameLabel!,
            "rank" : playerRankLabel!,
            "infoStackView" : infoStackView!,
            "image" : playerImageView!,
            "country" : playerCountryLabel!,
            "flag" : flagImageView!,
            "leftTable" : leftTableView!,
            "rightTable" : rightTableView!
        ]
        
        let metrics: [String: CGFloat] = [
            "safeL" : view.safeAreaInsets.left + 8.0,
            "safeR" : view.safeAreaInsets.right + 8.0,
            "safeT" : view.safeAreaInsets.top + 8.0,
            "safeB" : view.safeAreaInsets.bottom + 8.0,
            "RRmidT" : view.safeAreaInsets.top + 32.0,
            "RRmidB" : view.safeAreaInsets.bottom + 32.0
        ]
        
        var vfls: [String] = []
        
        if hSC == .compact && vSC == .regular {
            vfls.append("H:|-safeL-[infoStackView(>=1)]-[image(>=1)]-safeR-|") //row1
            vfls.append("H:|-safeL-[country(>=1)]-[flag(>=1)]-safeR-|") //row2
            vfls.append("H:|-safeL-[leftTable(>=1)]-[rightTable(>=1)]-safeR-|") //row 3
            vfls.append("V:|-safeT-[infoStackView(200)]-[country(100)]-[leftTable(>=1)]-safeB-|") //colLeft
            vfls.append("V:|-safeT-[image(200)]-[flag(100)]-[rightTable(>=1)]-safeB-|") //colRight
            
            constraints += [
                infoStackView.widthAnchor.constraint(equalTo: playerImageView.widthAnchor),
                playerCountryLabel.widthAnchor.constraint(equalTo: flagImageView.widthAnchor),
                leftTableView.widthAnchor.constraint(equalTo: rightTableView.widthAnchor),
            ]
            
        } else if hSC == .regular {
            vfls.append("H:|-safeL-[leftTable(>=1)]-[infoStackView(>=1)]-[rightTable(>=1)]-safeR-|") // only row
            vfls.append("V:|-safeT-[leftTable(>=1)]-safeB-|") // vert left
            if vSC == .regular { // vert middle
                vfls.append("V:|-RRmidT-[infoStackView(>=1)]-[image(>=1)]-[country(>=1)]-[flag(>=1)]-RRmidB-|")
            } else {
                vfls.append("V:|-safeT-[infoStackView(>=1)]-[image(>=1)]-[country(>=1)]-[flag(>=1)]-safeB-|")
            }
            vfls.append("V:|-safeT-[rightTable(>=1)]-safeB-|") // vert right
            
            constraints += [
                // widths of row connected
                leftTableView.widthAnchor.constraint(equalTo: infoStackView.widthAnchor),
                leftTableView.widthAnchor.constraint(equalTo: rightTableView.widthAnchor),
                
                // widths of middle collumn connected
                infoStackView.widthAnchor.constraint(equalTo: playerImageView.widthAnchor),
                infoStackView.widthAnchor.constraint(equalTo: playerCountryLabel.widthAnchor),
                infoStackView.widthAnchor.constraint(equalTo: flagImageView.widthAnchor),
                
                //heights of middle collumn connected
                infoStackView.heightAnchor.constraint(equalTo: playerImageView.heightAnchor),
                infoStackView.heightAnchor.constraint(equalTo: playerCountryLabel.heightAnchor),
                infoStackView.heightAnchor.constraint(equalTo: flagImageView.heightAnchor),
                
                //alligment of center of middle collumn
                infoStackView.centerXAnchor.constraint(equalTo: playerImageView.centerXAnchor),
                infoStackView.centerXAnchor.constraint(equalTo: playerCountryLabel.centerXAnchor),
                infoStackView.centerXAnchor.constraint(equalTo: flagImageView.centerXAnchor)
            ]

        } else if hSC == .compact && vSC == .compact {
            vfls.append("H:|-safeL-[infoStackView(>=1)]-[image(>=1)]-safeR-|") // row 1
            vfls.append("H:|-safeL-[leftTable(>=1)]-safeR-|") // row 2
            vfls.append("H:|-safeL-[rightTable(>=1)]-safeR-|") // row 3
            vfls.append("V:|-safeT-[infoStackView(>=1)]-[leftTable(>=1)]-[rightTable(>=1)]-safeB-|") // left collumn
            
            constraints += [
                // connecting heights
                infoStackView.heightAnchor.constraint(equalTo: playerImageView.heightAnchor),
                infoStackView.heightAnchor.constraint(equalTo: leftTableView.heightAnchor),
                infoStackView.heightAnchor.constraint(equalTo: rightTableView.heightAnchor),
                //connecting top row y-axis centers
                infoStackView.centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor)
            ]
        } else {
            fatalError("No correct size class has been passed in")
        }

        // activating all constraints
        var count = 0
        for _ in vfls {
            let constraint = NSLayoutConstraint.constraints(
                withVisualFormat: vfls[count],
                metrics: metrics,
                views: views
            )
            constraints += constraint
            count += 1
        }
        
        NSLayoutConstraint.activate(constraints)
        styleStackView()
    }

}
