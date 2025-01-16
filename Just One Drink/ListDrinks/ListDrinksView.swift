//
//  ListDrinksView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import Foundation
import SwiftData
import SwiftUI

struct ListDrinksView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Drink.whenDrunk) private var drinks: [Drink]
    
    private var drinksByDate: [Date: [Drink]] {
        drinks.reduce(into: [:]) { result, drink in
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: drink.whenDrunk)
            let date = Calendar.current.date(from: calendarDate)!
            let existing = result[date] ?? []
            result[date] = existing + [drink]
        }
    }
    
    private var dates: [Date] { Array(drinksByDate.keys) }
    
    private var standardDrinksByDate: [Date: Double] {
        var result = [Date: Double]()
        
        for date in dates {
            result[date] = drinksByDate[date]?.reduce(0, { $0 + $1.standardDrinks() })
        }
        
        return result
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let drink = drinks[offset]
            modelContext.delete(drink)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("When")
                Spacer()
                Text("What")
                Spacer()
                Text("Standard\nDrinks")
            }
            .font(.title2)
            .padding()
            List(dates.sorted(by: >), id: \.self) { date in
                Section {
                    if let thisDateDrinks = drinksByDate[date] {
                        ForEach(thisDateDrinks.sorted(by: { $0.whenDrunk > $1.whenDrunk})) { drink in
                            HStack {
                                Text(drink.whenDrunk.formatted(date: .omitted, time: .shortened))
                                Spacer()
                                Text(drink.name)
                                Spacer()
                                Text(String(format: "%0.1f", drink.standardDrinks()))
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
                header: {
                    HStack {
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                        Spacer()
                        Text(String(format: "Total: %0.1f", standardDrinksByDate[date] ?? 0))
                    }
                }
                .headerProminence(.increased)
            }
            .padding(.bottom, 1)
        }
    }
}

#Preview {
    ListDrinksView().modelContainer(PreviewData.shared)
}
