//
//  PreferancesView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/14/25.
//

import SwiftUI

struct PreferencesView: View {
    let flavors = [
        "Citrus 🍋", "Fruity 🍓", "Floral 🌸", "Herbal 🌿",
        "Spicy 🌶️", "Sweet 🍯"
    ]
    
    @State private var selectedFlavors: Set<String> = []
    @State private var navigateToSpirits = false
    
    @EnvironmentObject var cocktailVM: CocktailViewModel

    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Choose Your Flavor Vibe")
                    .font(.title2)
                    .foregroundColor(Color("Lavender"))

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(flavors, id: \.self) { flavor in
                            Button(action: { toggleFlavor(flavor) }) {
                                Text(flavor)
                                    .font(.title3)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedFlavors.contains(flavor) ? Color("BP") : Color("ML"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .shadow(color: selectedFlavors.contains(flavor) ? Color("BP") : .clear, radius: 5)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                Spacer()

                NavigationLink(destination: SpiritsView().environmentObject(cocktailVM), isActive: $navigateToSpirits) {
                    EmptyView()
                }

                Button("Next") {
                    cocktailVM.selectedFlavors = Array(selectedFlavors)
                    navigateToSpirits = true
                }
                .buttonStyle(SoftGlowingButton())
                .disabled(selectedFlavors.isEmpty)
            }
            .padding()
        }
    }

    func toggleFlavor(_ flavor: String) {
        if selectedFlavors.contains(flavor) {
            selectedFlavors.remove(flavor)
        } else {
            selectedFlavors.insert(flavor)
        }
    }
}
