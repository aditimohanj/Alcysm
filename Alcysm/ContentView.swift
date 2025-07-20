//
//  ContentView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/14/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cocktailVM = CocktailViewModel()
    var body: some View {
        NavigationStack {
            WelcomeView()
        }
        .padding()
        .environmentObject(cocktailVM)
    }
}

#Preview {
    ContentView()
}
