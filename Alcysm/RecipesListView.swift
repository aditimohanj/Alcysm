//
//  RecipesListView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/16/25.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject var cocktailVM: CocktailViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BG").ignoresSafeArea()
                content
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        VStack(spacing: 20) {
            Text("🍹 Your Curated Cocktails 🍹")
                .font(.title2)
                .foregroundColor(Color("Lavender"))

            if cocktailVM.isLoading {
                ProgressView("Mixing your perfect sip...")
                    .foregroundColor(Color("SoftLavender"))
            } else if let error = cocktailVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else if cocktailVM.cocktails.isEmpty {
                Text("No cocktails found for your preferences.")
                    .foregroundColor(Color("ML"))
            } else {
                cocktailsList
            }
        }
        .padding()
    }

    private var cocktailsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(cocktailVM.cocktails) { cocktail in
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail)
                        .environmentObject(cocktailVM)
                        .environment(\.managedObjectContext, viewContext)
                    ) {
                        cocktailRow(for: cocktail)
                    }
                }
            }
            .padding(.vertical)
        }
    }

    private func cocktailRow(for cocktail: Cocktail) -> some View {
        HStack {
            Text(cocktail.name)
                .font(.headline)
                .foregroundColor(Color("SoftGold"))

            Spacer()

            Button(action: {
                cocktailVM.toggleFavorite(cocktail, context: viewContext)
            }) {
                Image(systemName: cocktailVM.isFavorite(cocktail, context: viewContext) ? "star.fill" : "star")
                    .foregroundColor(cocktailVM.isFavorite(cocktail, context: viewContext) ? Color.yellow : Color.gray)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color("ML").opacity(0.4))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
