//
//  CocktailDetailView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/16/25.
//
import SwiftUI
import CoreData

struct CocktailDetailView: View {
    let cocktail: Cocktail
    @EnvironmentObject var cocktailVM: CocktailViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let imageURL = cocktail.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 250)
                }

                Text(cocktail.name)
                    .font(.largeTitle)
                    .foregroundColor(Color("Lavender"))
                    .multilineTextAlignment(.center)

                if let instructions = cocktail.instructions {
                    Text(instructions)
                        .font(.body)
                        .padding()
                        .foregroundColor(Color("ML"))
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(Color("SoftGold"))
                    ForEach(cocktail.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .foregroundColor(Color("ML"))
                    }
                }
                .padding()

                Button(action: {
                    cocktailVM.toggleFavorite(cocktail, context: viewContext)
                }) {
                    HStack {
                        Image(systemName: cocktailVM.isFavorite(cocktail, context: viewContext) ? "star.fill" : "star")
                        Text(cocktailVM.isFavorite(cocktail, context: viewContext) ? "Remove from Favorites" : "Add to Favorites")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("BP"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(cocktail.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
