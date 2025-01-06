//
//  ContentView.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
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
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(Drink.preview)
}
