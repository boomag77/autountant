//
//  DataModels.swift
//  Autountant
//
//  Created by Sergey on 11/24/23.
//

import Foundation

enum Units: String {
    case metric = "Metric"
    case imperial = "Imperial"
}

struct Period {
    var startDate: Date
    var endDate: Date
}

struct Stat {
    var fuelEconomy: Double
    var period: Period
    var costOfUnit: Double
    var totalDistanse: UInt
    var totalExpenses: Double
    
}
