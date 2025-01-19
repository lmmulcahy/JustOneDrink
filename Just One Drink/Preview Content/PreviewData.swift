//
//  PreviewContent.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/15/25.
//

import Foundation
import SwiftData

@MainActor
class PreviewData {
    static let shared: ModelContainer = {
        let container = try! ModelContainer(
            for: User.self, Drink.self, DrinkDrunk.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Insert User data
        container.mainContext.insert(User(weight: 129, sex: .male))
        
        // Insert Drinks data
        let standardBeer = Drink(name: "Standard Beer", type: .beer, alcoholContent: 5, size: 12, sizeUnits: .oz)
        container.mainContext.insert(standardBeer)
        let strongBeer = Drink(name: "Strong Beer", type: .beer, alcoholContent: 8.3, size: 12, sizeUnits: .oz)
        container.mainContext.insert(strongBeer)
        let largeBeer = Drink(name: "Large Beer", type: .beer, alcoholContent: 5.3, size: 16, sizeUnits: .oz)
        container.mainContext.insert(largeBeer)
        let standardWine = Drink(name: "Standard Wine", type: .wine, alcoholContent: 14.1, size: 5, sizeUnits: .oz)
        container.mainContext.insert(standardWine)
        let scotchNeat = Drink(name: "Scotch, neat", type: .spirits, alcoholContent: 40, size: 2, sizeUnits: .oz)
        container.mainContext.insert(scotchNeat)

        // Insert DrinkDrunk data
        container.mainContext.insert(DrinkDrunk(drink: strongBeer, whenDrunk: Date(timeIntervalSince1970: 1736120590)))
        container.mainContext.insert(DrinkDrunk(drink: strongBeer, whenDrunk: Date(timeIntervalSince1970: 1735785990)))
        container.mainContext.insert(DrinkDrunk(drink: standardWine, whenDrunk: Date(timeIntervalSince1970: 1736131590)))
        container.mainContext.insert(DrinkDrunk(drink: standardWine, whenDrunk: Date(timeIntervalSince1970: 1736130590)))
        container.mainContext.insert(DrinkDrunk(drink: scotchNeat, whenDrunk: Date(timeIntervalSince1970: 1735796790)))
        container.mainContext.insert(DrinkDrunk(drink: scotchNeat, whenDrunk: Date(timeIntervalSince1970: 1735710390)))
        container.mainContext.insert(DrinkDrunk(drink: standardBeer, whenDrunk: dateFromString(string: "2022-05-02T00:00-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: standardBeer, whenDrunk: dateFromString(string: "2023-05-12T13:30-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: largeBeer, whenDrunk: dateFromString(string: "2024-01-22T18:30-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: standardWine, whenDrunk: dateFromString(string: "2024-01-22T19:30-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: standardBeer, whenDrunk: dateFromString(string: "2024-01-22T19:50-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: strongBeer, whenDrunk: dateFromString(string: "2024-01-22T20:10-08:00")))
        container.mainContext.insert(DrinkDrunk(drink: strongBeer, whenDrunk: dateFromString(string: "2024-01-22T20:30-08:00")))

        return container
    }()
}
