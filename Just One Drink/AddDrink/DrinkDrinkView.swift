//
//  AddFavoriteDrinkView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/17/25.
//

import SwiftData
import SwiftUI

struct DrinkDrinkView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query() private var drinks: [Drink]
    
    @Binding var tabSelection: Int
    
    @State var date = Date()
    @State var selectedDrink: Drink?
    
    var body: some View {
        VStack {
            DatePicker(
                "Drink time: ",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.compact)
            
            Spacer()
            Picker("Drink", selection: $selectedDrink) {
                ForEach(drinks, id: \.self) { drink in
                    let drinkText = drink.name + " - " + String(drink.size) + drink.sizeUnits.rawValue
                    Text(drinkText).tag(drink as Drink?)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            Button("Drink") {
                if let drink = selectedDrink {
                    modelContext.insert(DrinkDrunk(
                        drink: drink,
                        whenDrunk: date))
                    tabSelection = 3
                }
            }.buttonStyle(.borderedProminent)
        }
        .onAppear {
            date = Date() // Update the date to the current time whenever the view appears
            if selectedDrink == nil, let firstDrink = drinks.first {
                selectedDrink = firstDrink // Pre-select the first drink
            }
        }
        .padding()
        .font(.title)
    }
}

#Preview {
    struct Preview: View {
        @State var tabSelection = 1
        var body: some View {
            DrinkDrinkView(tabSelection: $tabSelection)
        }
    }
    
    return Preview()
}
