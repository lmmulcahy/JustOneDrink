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
    @State private var previousUnits: SizeUnits = .oz
    @State private var drinkSize: Double = 12
    @State private var alcoholContent: Double = 5
    @State private var isShowingNameAlert = false
    @State private var favoriteDrinkName = ""

    struct DrinkConstants {
        var averageSize: Double
        var averageAlcoholContent: Double
        var minSizeOz: Double
        var maxSizeOz: Double
        var minAlcoholContent: Double
        var maxAlcoholContent: Double
        
        static let beer = DrinkConstants(averageSize: 12, averageAlcoholContent: 5, minSizeOz: 0, maxSizeOz: 33.813, minAlcoholContent: 0, maxAlcoholContent: 12)
        static let wine = DrinkConstants(averageSize: 5, averageAlcoholContent: 13, minSizeOz: 0, maxSizeOz: 12, minAlcoholContent: 7, maxAlcoholContent: 20)
        static let spirits = DrinkConstants(averageSize: 1.5, averageAlcoholContent: 40, minSizeOz: 0, maxSizeOz: 5, minAlcoholContent: 20, maxAlcoholContent: 100)
        
        // A function to get constants based on the selected drink type
        static func forDrinkType(_ type: DrinkType) -> DrinkConstants {
            switch type {
            case .beer: return .beer
            case .wine: return .wine
            case .spirits: return .spirits
            }
        }
    }
    
    init(tabSelection: Binding<Int>) {
        self._tabSelection = tabSelection
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .title2)], for: .normal)
    }
    
    var body: some View {
        VStack {
            Spacer()
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
                let constants = DrinkConstants.forDrinkType(selectedDrinkType)
                drinkSize = convertFromOz(constants.averageSize, units: selectedUnits)
                alcoholContent = constants.averageAlcoholContent
            }
            
            Spacer()
            Text("Size Units")
            Picker("Units", selection: $selectedUnits) {
                ForEach(SizeUnits.allCases, id: \.self) { units in
                    Text(units.rawValue)
                }
            }
            .pickerStyle(.palette)
            .onChange(of: selectedUnits) {
                drinkSize = convertUnits(drinkSize, from: previousUnits, to: selectedUnits)
                previousUnits = selectedUnits
            }

            Spacer()
            if selectedUnits == .pint || selectedUnits == .l {
                Text("Drink Size: " + String(format: "%0.2f", drinkSize) + "\(selectedUnits.rawValue)")
            } else {
                Text("Drink Size: " + String(format: "%0.1f", drinkSize) + "\(selectedUnits.rawValue)")
            }
            Slider(value: $drinkSize, in: drinkSliderRange()) {
                Text("Size")
            } minimumValueLabel: {
                Text("\(drinkSliderRange().lowerBound, specifier: "%.0f")")
            } maximumValueLabel: {
                Text("\(drinkSliderRange().upperBound, specifier: "%.0f")")
            }
            
            Spacer()
            Text("Alcohol Content: " + String(format: "%0.1f", alcoholContent) + "%")
            Slider(value: $alcoholContent, in: alcoholSliderRange()) {
                Text("Alcohol")
            } minimumValueLabel: {
                Text("\(alcoholSliderRange().lowerBound, specifier: "%.0f")")
            } maximumValueLabel: {
                Text("\(alcoholSliderRange().upperBound, specifier: "%.0f")")
            }
            
            Spacer()
            HStack {
                Button("Drink") {
                    modelContext.insert(DrinkDrunk(
                        drink: Drink(
                        type: selectedDrinkType,
                        alcoholContent: alcoholContent,
                        size: drinkSize,
                        sizeUnits: selectedUnits),
                        whenDrunk: date))
                    tabSelection = 3
                }.buttonStyle(.borderedProminent)
                Spacer()
                Button("Add Favorite") {
                    isShowingNameAlert = true
                }.buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            date = Date() // Update the date to the current time whenever the view appears
        }
        .padding()
        .font(.title)
        .alert("Enter Favorite Drink Name", isPresented: $isShowingNameAlert, actions: {
            TextField("Drink Name", text: $favoriteDrinkName)
            Button("Save") {
                modelContext.insert(Drink(
                    name: favoriteDrinkName,
                    type: selectedDrinkType,
                    alcoholContent: alcoholContent,
                    size: drinkSize,
                    sizeUnits: selectedUnits))
                favoriteDrinkName = ""
                tabSelection = 1
            }
            .disabled(favoriteDrinkName.isEmpty) // Disable Save if name is empty
            Button("Cancel", role: .cancel) {
                favoriteDrinkName = ""
            }
        }, message: {
            Text("Please provide a name for your favorite drink.")
        })
    }
    
    // Helper function to get slider range for drink size based on units
    private func drinkSliderRange() -> ClosedRange<Double> {
        let constants = DrinkConstants.forDrinkType(selectedDrinkType)
        return 0...convertFromOz(constants.maxSizeOz, units: selectedUnits)
    }
    
    private func convertToOz(_ value: Double, units: SizeUnits) -> Double {
        switch units {
        case .oz:
            return value
        case .pint:
            return value * 16
        case .ml:
            return value / 29.5735
        case .l:
            return value * 33.814
        }
    }
    
    private func convertFromOz(_ value: Double, units: SizeUnits) -> Double {
        switch units {
        case .oz:
            return value
        case .pint:
            return value / 16
        case .ml:
            return value * 29.5735
        case .l:
            return value / 33.814
        }
    }
    
    private func convertUnits(_ value: Double, from: SizeUnits, to: SizeUnits) -> Double {
        return convertFromOz(convertToOz(value, units: from), units: to)
    }
    
    // Helper function to get slider range for alcohol content based on drink type
    private func alcoholSliderRange() -> ClosedRange<Double> {
        let constants = DrinkConstants.forDrinkType(selectedDrinkType)
        return constants.minAlcoholContent...constants.maxAlcoholContent
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
