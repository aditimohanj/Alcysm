//
//  SpritisView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/15/25.
//

import SwiftUI

struct SpiritsView: View {
    let spiritsDisplay = [
        ("Gin", "Gin 🍸"),
        ("Vodka", "Vodka 🍸"),
        ("Rum", "Rum 🥃"),
        ("Tequila", "Tequila 🥃"),
        ("Whiskey", "Whiskey 🥃"),
        ("Mezcal", "Mezcal 🔥"),
        ("Brandy", "Brandy 🍷"),
        ("Liqueur", "Liqueur 🍷")
    ]

    @State private var selectedSpirits: Set<String> = []
    @State private var navigateToRecipes = false

    @EnvironmentObject var cocktailVM: CocktailViewModel

    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Pick Your Spirits")
                    .font(.title2)
                    .foregroundColor(Color("Lavender"))

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(spiritsDisplay, id: \.0) { spirit, label in
                            Button(action: {
                                toggleSpirit(spirit)
                            }) {
                                Text(label)
                                    .font(.title3)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedSpirits.contains(spirit) ? Color("BP") : Color("ML"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .shadow(color: selectedSpirits.contains(spirit) ? Color("BP") : .clear, radius: 5)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }

                Spacer()

                NavigationLink(destination: RecipesListView().environmentObject(cocktailVM), isActive: $navigateToRecipes) {
                    EmptyView()
                }

                Button("Next") {
                    guard !selectedSpirits.isEmpty else { return }
                    cocktailVM.selectedSpirits = Array(selectedSpirits)
                    cocktailVM.fetchPersonalizedCocktails()
                    navigateToRecipes = true
                }
                .buttonStyle(SoftGlowingButton())
                .disabled(selectedSpirits.isEmpty)
            }
            .padding()
        }
    }

    func toggleSpirit(_ spirit: String) {
        if selectedSpirits.contains(spirit) {
            selectedSpirits.remove(spirit)
        } else {
            selectedSpirits.insert(spirit)
        }
    }
}
