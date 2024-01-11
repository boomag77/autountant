//
//  DataModels.swift
//  Autountant
//
//  Created by Sergey on 11/24/23.
//

import Foundation

enum UnitsSystem: String, CaseIterable {
    static var allValues: [String] {
        return allCases.map { $0.rawValue }
    }
    case metric = "metric"
    case imperial = "imperial"
}

enum Category: String, CaseIterable {
    
    case fuel = "Fuel"
    case electricity = "Electricity"
    case insuranse = "Insuranse"
    case inspection = "State inspection"
    case parts = "Parts"
    case service = "Service"
    case other = "Other"
    
    static func getList(for vehicleType: String) -> [Category] {
        
        if let type = VehicleType(rawValue: vehicleType) {
            switch type {
                case .electric:
                    return Category.allCases.filter { $0 != .fuel }
                case .diesel, .gasoline:
                    return Category.allCases.filter { $0 != .electricity }
                default:
                    return Category.allCases
            }
        }
        return []
    }
}

enum VehicleType: String {
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Electric"
    case phev = "Plug-in Electric"
    case hybrid = "Hybrid"
}

enum Currency: String {
    case usd = "dollar"
    case eur = "Euro"
    case chr = "Swiss frank"
}
