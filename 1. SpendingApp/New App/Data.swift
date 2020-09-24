//
//  Data.swift
//  New App
//
//  Created by Saman on 19/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import Foundation

class Data {
    var years: [Year]
    
    init(years: [Year]) {
        self.years = years
    }
}

class Year: Hashable {
    static func == (lhs: Year, rhs: Year) -> Bool {
        return lhs.name == rhs.name && lhs.months == rhs.months
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(months)
    }
    
    var name: Int
    var months: [Month]
    
    init(name: Int, months: [Month]) {
        self.name = name
        self.months = months
    }
}

class Month: Hashable {
    static func == (lhs: Month, rhs: Month) -> Bool {
        return lhs.name == rhs.name && lhs.categories == rhs.categories && lhs.total == rhs.total
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(categories)
        hasher.combine(total)
    }

    var name: String
    var categories: [Category]
    var total: Double
    
    init(name: String, categories: [Category], total: Double) {
        self.name = name
        self.categories = categories
        self.total = total
    }
}

class Category: Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name && lhs.items == rhs.items && lhs.total == rhs.total
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(items)
        hasher.combine(total)
    }
    var name: String
    var items = [Item(name: "something", cost: 0.00)]
    var total: Double
    
    init(name: String, items: [Item], total: Double) {
        self.name = name
        self.items = items
        self.total = total
    }
}

class Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.cost == rhs.cost
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(cost)
    }
    var name: String
    var cost: Double
    
    init(name: String, cost: Double) {
        self.name = name
        self.cost = cost
    }
}

