//
//  DrinkDrunk.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/17/25.
//

import Foundation
import SwiftData

@Model
class DrinkDrunk {
    var drink: Drink
    var whenDrunk: Date
    
    init(drink: Drink, whenDrunk: Date) {
        self.drink = drink
        self.whenDrunk = whenDrunk
    }
}
