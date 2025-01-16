//
//  ContentView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @State private var showingProfile = false // State to control the profile sheet
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                Group {
                    AddDrinkView(tabSelection: $tabSelection)
                        .tabItem {
                            Label("Add Drink", systemImage: "wineglass")
                        }
                        .tag(1)
                    ListDrinksView()
                        .tabItem {
                            Label("List Drinks", systemImage: "list.bullet")
                        }
                        .tag(2)
                    StatsView()
                        .tabItem {
                            Label("Stats", systemImage: "chart.bar.xaxis")
                        }
                        .tag(3)
                }
            }
            .navigationTitle(tabTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { // Add profile button to toolbar
                    Button(action: {
                        showingProfile = true
                    }) {
                        Image(systemName: "person.crop.circle") // Profile icon
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingProfile) {
                EditUserView() // Show the EditUser view in a modal
            }
        }
    }
    
    // Dynamic title based on the selected tab
    private var tabTitle: String {
        switch tabSelection {
        case 1: return "Add Drink"
        case 2: return "List Drinks"
        case 3: return "Stats"
        default: return "App"
        }
    }
}

#Preview {
    ContentView().modelContainer(PreviewData.shared)
}
