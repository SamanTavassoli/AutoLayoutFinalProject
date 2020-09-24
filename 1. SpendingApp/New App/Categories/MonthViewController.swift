//
//  MonthViewController.swift
//  New App
//
//  Created by Saman on 06/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

protocol UpdateMonthDelegate: class {
    func updateMonth(passedMonth: Month, passedYear: Year)
}

class MonthViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet var totalMonthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var chosenMonth: Month!
    var chosenYear: Year!
    private var allowSegue = false
    private var indexPathsForCategoriesToDelete = [IndexPath(row: 0, section: 0)]
    
    
    @IBAction func showEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    override func viewDidLoad() {
        allowSegue = false
        super.viewDidLoad()
        
        monthLabel.text = chosenMonth.name
        yearLabel.text = String(chosenYear.name)
        updateMonthTotal()
        
        tableView.isEditing = false
        tableView.allowsMultipleSelectionDuringEditing = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("showEditing")))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("unwindToMain")))
        navigationItem.title = "\(chosenMonth.name) \(chosenYear.name)"
    }
    
    func updateCategory(category: Category) {
        var count = 0
        for oldCategory in chosenMonth.categories {
            if oldCategory.name == category.name {
                chosenMonth.categories.remove(at: count)
                chosenMonth.categories.insert(category, at: count)
            }
            count += 1
        }
        tableView.reloadData()
    }
    
    func updateMonthTotal() {
        var totalCount = 0.0
        for category in chosenMonth.categories {
            totalCount += category.total
        }
        chosenMonth.total = totalCount
        totalMonthLabel.text = "total \(Int(chosenMonth.total.rounded()))"
    }
    
    @IBAction func deleteItems() {
        tableView.setEditing(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("showEditing")))
        for indexPath in indexPathsForCategoriesToDelete {
            if indexPath.row != 99999 {
                chosenMonth.categories.remove(at: indexPath.row)
            }
        }
        tableView.deleteRows(at: indexPathsForCategoriesToDelete, with: .automatic)
    }
}

// MARK: - TableView

extension MonthViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenMonth.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categories", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = chosenMonth.categories[indexPath.row].name
        cell.costLabel.text = "\(chosenMonth.categories[indexPath.row].total)"
        cell.categoryLabel.textAlignment = .left
        cell.categoryLabel.font = .systemFont(ofSize: 17)
        if chosenMonth.categories[indexPath.row].name == "New Category" {
            cell.categoryLabel.textAlignment = .center
            cell.categoryLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.costLabel.text = " "
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if !tableView.isEditing {
            if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {
                if cell.categoryLabel.text == "New Category" {
                    allowSegue = false
                } else {
                    allowSegue = true
                }
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {
            if cell.categoryLabel.text == "New Category" {
                tableView.deselectRow(at: indexPath, animated: true)
                if !tableView.isEditing {
                    var newCategoriesBefore = 1
                    var newCategoryName = "New"
                    for category in chosenMonth.categories {
                        if category.name == newCategoryName {
                            newCategoriesBefore += 1
                            newCategoryName = "New \(newCategoriesBefore)"
                        }
                    }
                    chosenMonth.categories.insert(Category(name: newCategoryName, items: [], total: 0.0), at: indexPath.row)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            } else {
                if tableView.isEditing {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("deleteItems")))
                    indexPathsForCategoriesToDelete = tableView.indexPathsForSelectedRows ?? [IndexPath(row: 99999, section: 99999)]
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForSelectedRows == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("showEditing")))
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var canEdit: Bool = true
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {
            if cell.categoryLabel.text == "New Category" {
                canEdit = false
            }
        }
        return canEdit
    }
}

// MARK: - Navigation

extension MonthViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !tableView.isEditing {
            if identifier == "renameMonthSegue" {
                return true
            } else {
                return allowSegue
            }
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "categoryToItemSegue" {
            if let itemsTableViewController = segue.destination as? ItemsTableViewController {
                let selectedCategory = chosenMonth.categories[tableView.indexPathForSelectedRow!.row]
                itemsTableViewController.chosenCategory = selectedCategory
                tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
                itemsTableViewController.updateTotalCostLabel(selectedCategory)
            }
        }
        
        if segue.identifier == "unwindToMainSegue" {
            if let mainVC = segue.destination as? YearMonthTableViewController {
                mainVC.updateMonth(passedMonth: chosenMonth, passedYear: chosenYear)
            }
        }
        
        if segue.identifier == "renameMonthSegue" {
            if let renameVC = segue.destination as? RenameViewController {
                renameVC.renameDelegate = self
                renameVC.passedOnName = chosenMonth.name
            }
        }
    }
    
    @IBAction func unwindToMain() {
        performSegue(withIdentifier: "unwindToMainSegue", sender: self)
    }
    
    @IBAction func unwindToMonthVC(_ unwindSegue: UIStoryboardSegue) {
    }
}

// MARK: - Delegates

extension MonthViewController: RenameDelegate {
    func didRename(newName: String) {
        chosenMonth.name = newName
        monthLabel.text = chosenMonth.name
    }
}
