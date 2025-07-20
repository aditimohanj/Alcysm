//
//  FavoritesView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/16/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var cocktailVM: CocktailViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()

            VStack(spacing: 20) {
                Text("⭐️ Your Favorites ⭐️")
                    .font(.title2)
                    .foregroundColor(Color("Lavender"))

                if cocktailVM.favorites.isEmpty {
                    Text("No favorites yet. Go find your signature sip!")
                        .foregroundColor(Color("ML"))
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(cocktailVM.favorites) { cocktail in
                                HStack {
                                    Text(cocktail.name)
                                        .font(.headline)
                                        .foregroundColor(Color("SoftGold"))
                                    Spacer()
                                    Button {
                                        cocktailVM.toggleFavorite(cocktail, context: viewContext)
                                    } label: {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color.yellow)
                                    }
                                }
                                .padding()
                                .background(Color("ML").opacity(0.4))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            cocktailVM.loadFavoritesFromCoreData(context: viewContext)
        }
    }
}
