//
//  ItemsTableViewController.swift
//  New App
//
//  Created by Saman on 10/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    @IBOutlet var categoryNavigationItem: UINavigationItem!
    @IBOutlet var itemsTableView: UITableView!
    
    var chosenCategory: Category!
    var allowSegue = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryNavigationItem.title = chosenCategory.name
        let item1 = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("unwindToMonthVC")))
        let item2 = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("tableViewEditingTrue")))
        navigationItem.leftBarButtonItems = [item1]
        navigationItem.rightBarButtonItems?.append(item2)
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    // MARK: - Table view data source
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    @IBAction func tableViewEditingTrue() {
        allowSegue = false
        tableView.setEditing(true, animated: true)
        navigationItem.rightBarButtonItems![1] = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("tableViewEditingFalse")))
    }
    
    @IBAction func tableViewEditingFalse() {
        allowSegue = true
        tableView.setEditing(false, animated: true)
        navigationItem.rightBarButtonItems![1] = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("tableViewEditingTrue")))
    }
    
    func deleteItems() {
        let indexPathsToDelete = tableView.indexPathsForSelectedRows!.sorted(by: { $0.row > $1.row })
        for indexPath in indexPathsToDelete {
            chosenCategory.items.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: indexPathsToDelete, with: .automatic)
        recalculateTotalCost()
    }
    
    @IBAction func pressedDelete() {
        if tableView.indexPathsForSelectedRows != nil {
            deleteItems()
        }
        tableViewEditingFalse()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section != 1 {
            return false
        } else {
            return true
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsForSection = chosenCategory.items.count
        if section == 0 || section == 2 {
            rowsForSection = 1
        }
        return rowsForSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "total", for: indexPath) as! TotalCell
            cell.stackView1.totalCostLabel.text = "\(chosenCategory.total)"
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! ItemCell
            cell.nameTextfield.text = chosenCategory.items[indexPath.row].name
            cell.costTextfield.text = String(chosenCategory.items[indexPath.row].cost)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newItem", for: indexPath) as! NewItemCell
            cell.newItemLabel.text = "New Item"
            cell.newItemLabel.textAlignment = .center
            cell.newItemLabel.font = UIFont.boldSystemFont(ofSize: 16)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            addNewItem(tableView)
            tableView.deselectRow(at: indexPath, animated: true)
        } else if tableView.isEditing {
            navigationItem.rightBarButtonItems![1] = UIBarButtonItem(title: "Delete", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("pressedDelete")))
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            if tableView.indexPathsForSelectedRows == nil {
                navigationItem.rightBarButtonItems![1] = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("tableViewEditingFalse")))
            }
        }
    }
    
    func addNewItem(_ tableView: UITableView) {            chosenCategory.items.append(Item(name: "new", cost: 0.00))
        tableView.insertRows(at: [IndexPath(row: chosenCategory.items.count - 1, section: 1)], with: .automatic)
    }
    
    @IBAction func costTextFieldEditingDidEnd(_ sender: Any) {
        recalculateTotalCost()
    }
    
    func recalculateTotalCost() {
        updateItemNamesAndCostsFromTextfields()
        updateTotalCostLabel(chosenCategory)
    }
    
    func updateItemNamesAndCostsFromTextfields() {
        var countRow = 0
        var totalCost = 0.0
        for item in chosenCategory.items {
            if let cell = tableView.cellForRow(at: IndexPath(row: countRow, section: 1)) as? ItemCell {
                item.name = cell.nameTextfield.text!
                if let cost = Double(cell.costTextfield.text!) {
                    item.cost = cost
                    totalCost += cost
                } else {
                    print("not a valid cost")
                    cell.costTextfield.text = String(item.cost)
                    totalCost += item.cost
                }
            }
            countRow += 1
        }
        chosenCategory.total = totalCost
    }
    
    func updateTotalCostLabel(_ category: Category) {
        let totalCost = category.total.rounded() // fix rounding
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TotalCell {
            cell.stackView1.totalCostLabel.text = "\(totalCost)"
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        chosenCategory.items.swapAt(fromIndexPath.row, to.row)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.section == 1 {
            return proposedDestinationIndexPath
        } else if proposedDestinationIndexPath.section == 2 {
            return IndexPath(row: tableView.numberOfRows(inSection: 1) - 1, section: 1)
        } else {
            return IndexPath(row: 0, section: 1)
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section != 1 {
            return false
        } else {
            return true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "renameCategorySegue" {
            if let renameViewController = segue.destination as? RenameViewController {
                renameViewController.renameDelegate = self
                renameViewController.passedOnName = chosenCategory.name
                if tableView!.indexPathsForSelectedRows != nil {
                    for indexPath in tableView!.indexPathsForSelectedRows! {
                        tableView.deselectRow(at: indexPath, animated: false)
                    }
                    tableViewEditingFalse()
                }
            }
        }
        
        if segue.identifier == "unwindToMonthVCSegue" {
            if let monthVC = segue.destination as? MonthViewController {
                updateItemNamesAndCostsFromTextfields()
                monthVC.updateCategory(category: chosenCategory)
                monthVC.updateMonthTotal()
            }
        }
    }
    
    @IBAction func unwindToMonthVC() {
        if allowSegue == true {
            performSegue(withIdentifier: "unwindToMonthVCSegue", sender: self)
        }
    }

}

extension ItemsTableViewController: RenameDelegate {
    func didRename(newName: String) {
        chosenCategory.name = newName
        categoryNavigationItem.title = chosenCategory.name
    }
}
