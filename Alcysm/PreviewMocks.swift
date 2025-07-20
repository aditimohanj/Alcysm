//
//  PreviewMocks.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/19/25.
//
import SwiftUI

extension View {
    func injectPreviewContext() -> some View {
        self.environmentObject(CocktailViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
