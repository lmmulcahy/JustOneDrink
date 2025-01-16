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
            for: User.self, Drink.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Insert User data
        container.mainContext.insert(User(weight: 129, sex: .male))
        
        // Insert Drink data
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 8.3, size: 12, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736120590)))
        container.mainContext.insert(Drink(name: "d2", type: .beer, alcoholContent: 4.3, size: 16, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735785990)))
        container.mainContext.insert(Drink(name: "d3", type: .wine, alcoholContent: 18.3, size: 5, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736131590)))
        container.mainContext.insert(Drink(type: .wine, alcoholContent: 13.4, size: 6, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1736130590)))
        container.mainContext.insert(Drink(type: .spirits, alcoholContent: 40, size: 2, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735796790)))
        container.mainContext.insert(Drink(name: "d6", type: .spirits, alcoholContent: 50, size: 2.5, sizeUnits: .oz, whenDrunk: Date(timeIntervalSince1970: 1735710390)))
        container.mainContext.insert(Drink(type: .spirits, alcoholContent: 50, size: 2.5, sizeUnits: .oz, whenDrunk: dateFromString(string: "2022-05-02T00:00-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2023-05-12T13:30-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2024-01-22T18:30-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2024-01-22T19:30-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2024-01-22T19:50-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2024-01-22T20:10-08:00")))
        container.mainContext.insert(Drink(type: .beer, alcoholContent: 5.8, size: 16, sizeUnits: .oz, whenDrunk: dateFromString(string: "2024-01-22T20:30-08:00")))

        return container
    }()
}
