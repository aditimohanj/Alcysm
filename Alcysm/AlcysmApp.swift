//
//  AlcysmApp.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/14/25.
//

import SwiftUI

@main
struct AlcysmApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var cocktailVM = CocktailViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cocktailVM)
        }
    }
}
