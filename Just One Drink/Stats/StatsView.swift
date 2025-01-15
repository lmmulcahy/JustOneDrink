//
//  StatsView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/13/25.
//

import Charts
import SwiftData
import SwiftUI

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Drink.whenDrunk) private var drinks: [Drink]
    
    @State private var selectedUnit: Calendar.Component = .day
    
    var body: some View {
        VStack {
            Chart {
                ForEach(drinks, id: \.id) { drink in
                    BarMark(
                        x: .value("Date", drink.whenDrunk, unit: selectedUnit),
                        y: .value("Drinks", drink.standardDrinks())
                    )
                    .foregroundStyle(by: .value("Drink Type", drink.type.rawValue))
                }
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: domainLength(for: selectedUnit))
            .chartScrollPosition(initialX: Date())
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine()
                    AxisTick()
                    if selectedUnit == .hour {
                        AxisValueLabel(format: .dateTime.month().day().hour())
                    } else if selectedUnit == .day {
                        AxisValueLabel(format: .dateTime.day().month()) // Format for day view
                    } else if selectedUnit == .weekOfYear {
                        AxisValueLabel(format: .dateTime.day().month()) // Format for week view
                    } else if selectedUnit == .month {
                        AxisValueLabel(format: .dateTime.year().month()) // Format for month view
                    } else if selectedUnit == .year {
                        AxisValueLabel(format: .dateTime.year()) // Format for year view
                    } else {
                        AxisValueLabel() // Default formatting for other units
                    }
                }
            }
            .padding()
            
            // Picker to select the time units for the chart
            HStack {
                Text("Drinks Per")
                Picker("Time Unit", selection: $selectedUnit) {
                    Text("Hour").tag(Calendar.Component.hour)
                    Text("Day").tag(Calendar.Component.day)
                    Text("Week").tag(Calendar.Component.weekOfYear)
                    Text("Month").tag(Calendar.Component.month)
                    Text("Year").tag(Calendar.Component.year)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // For horizontal buttons
            .padding()
            
            Spacer()
        }
    }

    // Helper function to determine the domain length for each unit
    private func domainLength(for unit: Calendar.Component) -> Double {
        switch unit {
        case .hour:
            return 3600 * 24 // 24 hours
        case .day:
            return 86400 * 7 // 7 days
        case .weekOfYear:
            let now = Date()
            let range = Calendar.current.range(of: .day, in: .month, for: now)
            return Double((range?.count ?? 30) * 86400) // Days in the current month
        case .month:
            return 86400 * 365 // 1 year
       case .year:
            return 86400 * 365 * 10 // 10 years
        default:
            return 86400 * 7 // Default to 1 week
        }
    }
}

#Preview {
    StatsView().modelContainer(Drink.preview)
}
