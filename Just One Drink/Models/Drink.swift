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

extension Drink {
    @MainActor static var preview: ModelContainer {
        let container = try! ModelContainer(for: Drink.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true), ModelConfiguration(isStoredInMemoryOnly: true))
        
        let d1: Drink = .init(type:.beer, alcoholContent: 8.3, size: 12, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736120590))
        
        let d2: Drink = .init(name: "d2", type:.beer, alcoholContent: 4.3, size: 16, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735785990))
        
        let d3: Drink = .init(name: "d3", type:.wine, alcoholContent: 18.3, size: 5, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736131590))
        
        let d4: Drink = .init(type:.wine, alcoholContent: 13.4, size: 6, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736130590))
        
        let d5: Drink = .init(type:.spirits, alcoholContent: 40, size: 2, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735796790))
        
        let d6: Drink = .init(name: "d6", type:.spirits, alcoholContent: 50, size: 2.5, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735710390))
        
        container.mainContext.insert(d1)
        container.mainContext.insert(d2)
        container.mainContext.insert(d3)
        container.mainContext.insert(d4)
        container.mainContext.insert(d5)
        container.mainContext.insert(d6)

        return container
    }
}
