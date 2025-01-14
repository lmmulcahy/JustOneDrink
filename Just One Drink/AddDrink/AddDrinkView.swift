//
//  AddDrinkView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import SwiftData
import SwiftUI

struct AddDrinkView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var tabSelection: Int
    
    @State private var date = Date()
    @State private var selectedDrinkType: DrinkType = .beer
    @State private var selectedUnits: SizeUnits = .oz
    @State private var drinkSize: Double = 12
    @State private var alcoholContent: Double = 5

    struct NormalDrinkStats {
        var averageSize: Double
        var averageAlcoholContent: Double
        var minSize: Double
        var maxSize: Double
        var minAlcoholContent: Double
        var maxAlcoholContent: Double
        
        init(averageSize: Double, averageAlcoholContent: Double, minSize: Double, maxSize: Double, minAlcoholContent: Double, maxAlcoholContent: Double) {
            self.averageSize = averageSize
            self.averageAlcoholContent = averageAlcoholContent
            self.minSize = minSize
            self.maxSize = maxSize
            self.minAlcoholContent = minAlcoholContent
            self.maxAlcoholContent = maxAlcoholContent
        }
    }
    
    init(tabSelection: Binding<Int>) {
        self._tabSelection = tabSelection
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .title2)], for: .normal)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Add a drink")
                .font(.largeTitle)
            DatePicker(
                "Drink time: ",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.compact)
            Spacer()
            Text("Drink Type")
            Picker("Drink", selection: $selectedDrinkType) {
                ForEach(DrinkType.allCases, id: \.self) { drink in
                    Text(drink.rawValue)
                }
            }
            .pickerStyle(.palette)
            .onChange(of: selectedDrinkType) {
                switch(selectedDrinkType) {
                case .beer:
                    drinkSize = 12
                    alcoholContent = 5
                case .wine:
                    drinkSize = 5
                    alcoholContent = 13
                case .spirits:
                    drinkSize = 1.5
                    alcoholContent = 40
                }
            }
            Spacer()
            Text("Size Units")
            Picker("Units", selection: $selectedUnits) {
                ForEach(SizeUnits.allCases, id: \.self) { units in
                    Text(units.rawValue)
                }
            }
            .pickerStyle(.palette)
            Spacer()
            Text("Drink Size: " + String(format: "%0.1f", drinkSize) + "\(selectedUnits.rawValue)")
            if selectedUnits == .oz {
                Slider(value: $drinkSize, in: 0...32) {} minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("32")
                }
            } else if selectedUnits == .pint {
                Slider(value: $drinkSize, in: 0...4) {} minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("4")
                }
            } else if selectedUnits == .l {
                Slider(value: $drinkSize, in: 0...2) {} minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("2")
                }
            } else {
                Slider(value: $drinkSize, in: 0...1000) {} minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1000")
                }
            }
            Spacer()
            Text("Alcohol Content: " + String(format: "%0.1f", alcoholContent) + "%")
            if selectedDrinkType == .beer {
                Slider(value: $alcoholContent, in: 0...12) {} minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("12")
                }
            } else if selectedDrinkType == .wine {
                Slider(value: $alcoholContent, in: 7...20) {} minimumValueLabel: {
                    Text("7")
                } maximumValueLabel: {
                    Text("20")
                }
            } else if selectedDrinkType == .spirits {
                Slider(value: $alcoholContent, in: 20...100) {} minimumValueLabel: {
                    Text("20")
                } maximumValueLabel: {
                    Text("100")
                }
            }
            Spacer()
            Button("Add") {
                modelContext.insert(Drink(
                    type: selectedDrinkType,
                    alcoholContent: alcoholContent,
                    size: drinkSize,
                    sizeUnits: selectedUnits,
                    whenDrunk: date))
                tabSelection = 2
            }.buttonStyle(.borderedProminent)
        }
        .padding()
        .font(.title)
    }
}

#Preview {
    struct Preview: View {
        @State var tabSelection = 1
        var body: some View {
            AddDrinkView(tabSelection: $tabSelection)
        }
    }
    
    return Preview()
}
