//
//  Just_One_DrinkApp.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import SwiftData
import SwiftUI

@main
struct Just_One_DrinkApp: App {
    var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Drink.self, User.self)
            let empty = try container.mainContext.fetch(FetchDescriptor<User>()).isEmpty
            if empty {
                container.mainContext.insert(User(weight: 130, sex: .male))
            }
        } catch {
            fatalError("Couldn't set up SwiftData container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}
