//
//  CollectionViewController.swift
//  links
//
//  Created by Saman on 27/03/2020.
//  Copyright © 2020 Samans. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public var websiteList = WebsiteList([URL(string: "www.apple.com"),nil,nil,nil,nil])

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return websiteList.getWebsiteCount() + 1 // 1 extra box for adding new boxes
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        setCellProperties(forCell: cell, withIndexPath: indexPath)
        // TODO: add a "+" to the last cell of the collection to add new cells
    
        return cell
    }
    
    // Setting cell properties such as background color
    private func setCellProperties(forCell cell: UICollectionViewCell, withIndexPath indexPath: IndexPath) {
        
        // evenly spacing out the colors based on the ratio of cell number to total number of cells, red values starting at 0.2 and going to 0.5
        let startingRedValue = 0.2
        let endingRedValue = 0.4
        let redValue = CGFloat(indexPath.row)
            / CGFloat(websiteList.getWebsiteCount() + 1) // + 1 box at for adding new items
            * CGFloat(endingRedValue - startingRedValue)
            + CGFloat(startingRedValue)
        let cellColor = UIColor(red: redValue, green: 0, blue: 0, alpha: 0.85)
        
        cell.backgroundColor = cellColor
        cell.layer.cornerRadius = 8
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    // Setting cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.bounds.width / 4
        return CGSize(width: size , height: size)
    }
    
    // Adding spacing between left and right of view using insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // display pop up view with values for position selected
        // unless we selected the "add" box
        if indexPath.row == websiteList.getWebsiteCount() {
            websiteList.addWebsite()
            collectionView.insertItems(at: [indexPath])
        } else {
            showPopup(position: indexPath.row)
        }
    }
    
    // MARK: PopUpView
    
    private func showPopup(position: Int) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUpVC") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
        // styling popupVC's only subview
        let subview = popOverVC.view.subviews[0]
        subview.layer.cornerRadius = 10
        subview.backgroundColor = collectionView.cellForItem(at: IndexPath(row: position, section: 0))?.backgroundColor
        
        // giving the position and previous user input values to new view for display
        popOverVC.websitePosition = position
        popOverVC.textField.text = websiteList.getWebsite(position)?.absoluteString
        
        animatePopUp(popOverVC)
    }
    
    private func animatePopUp(_ popOverVC: PopUpViewController) {
        popOverVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.4,
            animations: {
                popOverVC.view.transform = .identity
        }, completion: { _ in
            popOverVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        })
        
    }
}
