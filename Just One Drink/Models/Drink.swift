//
//  Drink.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import Foundation
import SwiftData

@Model
class Drink {
    var name: String
    var type: DrinkType
    var alcoholContent: Double
    var size: Double
    var sizeUnits: SizeUnits
    var whenDrunk: Date
    
    convenience init(type: DrinkType, alcoholContent: Double, size: Double, sizeUnits: SizeUnits) {
        self.init(name: type.rawValue, type: type, alcoholContent: alcoholContent, size: size, sizeUnits: sizeUnits)
    }
    
    convenience init(name: String, type: DrinkType, alcoholContent: Double, size: Double, sizeUnits: SizeUnits) {
        self.init(name: type.rawValue, type: type, alcoholContent: alcoholContent, size: size, sizeUnits: sizeUnits, whenDrunk: Date.now)
    }
    
    convenience init(type: DrinkType, alcoholContent: Double, size: Double, sizeUnits: SizeUnits, whenDrunk: Date) {
        self.init(name: type.rawValue, type: type, alcoholContent: alcoholContent, size: size, sizeUnits: sizeUnits, whenDrunk: whenDrunk)
    }
    
    init(name: String, type: DrinkType, alcoholContent: Double, size: Double, sizeUnits: SizeUnits, whenDrunk: Date) {
        self.name = name
        self.type = type
        self.alcoholContent = alcoholContent / 100
        self.size = size
        self.sizeUnits = sizeUnits
        self.whenDrunk = whenDrunk
    }
    
    func standardDrinks() -> Double {
        switch sizeUnits {
        case SizeUnits.ml:
            return 0.78899 * size * alcoholContent / 14
        case SizeUnits.l:
            return 0.78899 * (size / 1000) * alcoholContent / 14
        case SizeUnits.oz:
            return 23.333333 * size * alcoholContent / 14
        case SizeUnits.pint:
            return 373.333333 * size * alcoholContent / 14
        }
    }
}

enum DrinkType: String, Codable, CaseIterable {
    case beer = "Beer"
    case wine = "Wine"
    case spirits = "Spirits"
}

enum SizeUnits: String, Codable, CaseIterable {
    case oz
    case pint
    case ml
    case l
}

func dateFromString(string: String) -> Date {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFullDate] // Added format options
    let date = dateFormatter.date(from: string) ?? Date.now
    print(date)
    print("ISO TIME: " + string)
    return date
}

