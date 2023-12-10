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

enum Range {
    case week
    case month
    case year
    case custom
}

struct Period {
    
    var startDate: Date?
    var endDate: Date?
    
    init(range: Range, startDate: Date? = nil, endDate: Date? = nil) {
        switch range {
            case .week:
                self.startDate = Date() - 7
                if let endDate = endDate {
                    self.endDate = endDate
                }
            case .month:
                self.startDate = Date() - 30
                if let endDate = endDate {
                    self.endDate = endDate
                }
            case .year:
                self.startDate = Date() - 365
                if let endDate = endDate {
                    self.endDate = endDate
                }
            default:
                if let startDate = startDate, let endDate = endDate {
                    self.startDate = startDate
                    self.endDate = endDate
                }
        }
    }
}

struct Stat {
    var fuelEconomy: Double
    var period: Period
    var costOfUnit: Double
    var totalDistanse: UInt
    var totalExpenses: Double
    
}

//enum Category: String {
//    case gas = "Gas"
//    case electricity = "Electricity"
//    case insuranse = "Insuranse"
//    case inspection = "State inspection"
//    case parts = "Parts"
//    case service = "Service"
//    case other = "Other"
//}
