//
//  YearMonthTableViewController.swift
//  New App
//
//  Created by Saman on 06/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class YearMonthTableViewController: UITableViewController {
    @IBOutlet var showDataBarButton: UIBarButtonItem!
    
    var data = Data(years: [])
    var yearAndMonthSelected : [Year : Month] = [:]
    private var allowSegue = false
    
    override func viewDidLoad() {
        self.tableView.allowsSelection = true
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
        addYears()
    }
    
    func addYears() {
        data.years.append(Year(name: 2018, months: []))
        data.years.append(Year(name: 2019, months: []))
        addMonthsToYear(years: data.years)
        data.years.append(Year(name: 1, months: []))
        data.years[2].months.append(Month(name: "New Year", categories: [], total: 0.0))
    }

    func addMonthsToYear(years: [Year]) {
        for year in years {
            year.months.append(Month(name: "January", categories: [], total: 0.0))
            year.months.append(Month(name: "New Month", categories: [], total: 0.0))
            addCategoriesToMonth(months: year.months)
        }
    }
    
    func addCategoriesToMonth(months: [Month]) {
        for month in months {
            month.categories.append(Category(name: "Food", items: [], total: 0.0))
            month.categories.append(Category(name: "Transport", items: [], total: 0.0))
            month.categories.append(Category(name: "New Category", items: [], total: 0.0))
        }
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        navigationItem.rightBarButtonItem = nil
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                data.years[indexPath.section].months.remove(at: indexPath.row)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
}
    
    // MARK: - TableView

extension YearMonthTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.years.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.years[section].months.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = String(data.years[section].name)
        if title == "1" {
            title = ""
        }
        return title
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "month", for: indexPath) as! MonthCell
        cell = assginStyleToCell(tableView, cell: cell, indexPath: indexPath)
        return cell
    }
    
    func assginStyleToCell(_ tableView: UITableView, cell: MonthCell, indexPath: IndexPath) -> MonthCell {
        cell.monthLabel.text = data.years[indexPath.section].months[indexPath.row].name
        cell.monthLabel.font = UIFont.systemFont(ofSize: 18)
        cell.monthLabel.textAlignment = .left
        cell.monthTotalLabel.text = String(Int(data.years[indexPath.section].months[indexPath.row].total)) //
        if cell.monthLabel.text == "New Month" {
            cell.monthLabel.textAlignment = .center
            cell.monthLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.monthTotalLabel.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allowSegue = false
        if let cell = tableView.cellForRow(at: indexPath) as? MonthCell {
            if cell.monthLabel.text == "New Month" {
                if !tableView.isEditing {
                    tableView.deselectRow(at: indexPath, animated: true)
                    var untitledMonthsBefore = 1
                    var newMonthName = "Untitled Month"
                    for month in data.years[indexPath.section].months { // numbering each new month
                        if month.name == newMonthName {
                            untitledMonthsBefore += 1
                            newMonthName = "Untitled Month \(untitledMonthsBefore)"
                        }
                    }
                    data.years[indexPath.section].months.insert(Month(name: newMonthName, categories: [], total: 0.0), at: indexPath.row)
                    addCategoriesToMonth(months: [data.years[indexPath.section].months[indexPath.row]])
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                tableView.deselectRow(at: indexPath, animated: true)
            } else if cell.monthLabel.text == "New Year" {
                if !tableView.isEditing {
                    tableView.deselectRow(at: indexPath, animated: true)
                    data.years.insert(Year(name: data.years[data.years.count - 2].name + 1, months: []), at: indexPath.section)
                    addMonthsToYear(years: [data.years[indexPath.section]])
                    tableView.beginUpdates()
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    tableView.insertSections(IndexSet(integer: indexPath.section + 1), with: .automatic)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                }
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                if tableView.isEditing {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItem.Style.done, target: self, action: #selector (YearMonthTableViewController.deleteItems(_:)))
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = tableView.cellForRow(at: indexPath) as? MonthCell {
            if !tableView.isEditing && cell.monthLabel.text != "New Year" {
                let year = data.years[indexPath.section]
                let month = year.months[indexPath.row]
                yearAndMonthSelected = [year : month]
                if cell.monthLabel.text != "New Month" {
                    allowSegue = true
                }
            }
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing && tableView.indexPathsForSelectedRows == nil {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var canEdit: Bool = true
        if let cell = tableView.cellForRow(at: indexPath) as? MonthCell {
            if cell.monthLabel.text == "New Month" || cell.monthLabel.text == "New Year" {
                canEdit = false
            }
        }
        return canEdit
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let initialMonth = data.years[fromIndexPath.section].months[fromIndexPath.row]
        let destinationMonth = data.years[to.section].months[to.row]
        data.years[to.section].months[to.row] = initialMonth
        data.years[fromIndexPath.section].months[fromIndexPath.row] = destinationMonth
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let cell = tableView.cellForRow(at: indexPath) as? MonthCell {
            if cell.textLabel?.text == "New Month" || cell.textLabel?.text == "New Year" {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var whatToReturn = sourceIndexPath
        if let fromCell = tableView.cellForRow(at: sourceIndexPath) as? MonthCell, let _ = tableView.cellForRow(at: proposedDestinationIndexPath) as? MonthCell {
            let numberOfRows = tableView.numberOfRows(inSection: proposedDestinationIndexPath.section)
            var monthAlreadyPresent = false
            if proposedDestinationIndexPath.section != sourceIndexPath.section {
                for number in Range(0...numberOfRows) {
                    if let toCell = tableView.cellForRow(at: IndexPath(row: number, section: proposedDestinationIndexPath.section)) as? MonthCell {
                        if fromCell.monthLabel.text == toCell.monthLabel.text {
                            monthAlreadyPresent = true
                        }
                    }
                }
            }
            if monthAlreadyPresent {
                if proposedDestinationIndexPath.section > sourceIndexPath.section {
                    whatToReturn = IndexPath(row: tableView.numberOfRows(inSection: sourceIndexPath.section) - 2, section: sourceIndexPath.section)
                } else {
                    whatToReturn = IndexPath(row: 0, section: sourceIndexPath.section)
                }
            } else if proposedDestinationIndexPath.section == data.years.count - 1 {
                whatToReturn = IndexPath(row: tableView.numberOfRows(inSection: sourceIndexPath.section) - 2, section: sourceIndexPath.section)
                // prevent going in new year section
            } else if proposedDestinationIndexPath.row == tableView.numberOfRows(inSection: proposedDestinationIndexPath.section) {
                whatToReturn = IndexPath(row: proposedDestinationIndexPath.row - 1, section: proposedDestinationIndexPath.section)
                // prevent going past new month
            } else {
                whatToReturn = proposedDestinationIndexPath
            }
        }
        return whatToReturn
    }
}

// MARK: - Navigation

extension YearMonthTableViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return allowSegue
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "monthSegue" {
            if let monthViewController = segue.destination as? MonthViewController {
                for (year, month) in yearAndMonthSelected {
                    monthViewController.chosenMonth = month
                    monthViewController.chosenYear = year
                }
            }
        }
    }
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
    }
}

// MARK: - Delegates

extension YearMonthTableViewController: UpdateMonthDelegate {
    
    func updateMonth(passedMonth: Month, passedYear: Year) {
        for year in data.years {
            if year.name == passedYear.name {
                var count = 0
                for month in year.months {
                    if month.name == passedMonth.name {
                        year.months.remove(at: count)
                        year.months.insert(passedMonth, at: count)
                    }
                    count += 1
                }
            }
        }
        tableView.reloadData()
    }
}
