//
//  CocktailTarotCardView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/15/25.
//

import SwiftUI

struct CocktailTarotCardView: View {
    var cocktail: Cocktail

    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()

            VStack(spacing: 30) {
                Text("🔮 Your Cocktail Destiny 🔮")
                    .font(.title2)
                    .foregroundColor(Color("Lavender"))

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("ML"), Color("BG")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 280, height: 400)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .foregroundColor(Color("SoftGold").opacity(0.6))
                        )
                        .shadow(color: Color("BP").opacity(0.6), radius: 20)
                        .overlay(
                            VStack(spacing: 20) {
                                Text(cocktail.name)
                                    .font(.title)
                                    .foregroundColor(Color("SoftGold"))
                                    .shadow(radius: 5)

                                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                                    Text(ingredient)
                                        .font(.headline)
                                        .foregroundColor(Color("Lavender"))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 6)
                                        .background(Color("BG").opacity(0.5))
                                        .cornerRadius(12)
                                }

                                Spacer()
                            }
                            .padding()
                        )
                }

                if let instructions = cocktail.instructions {
                    Text("✨ How to Make It ✨")
                        .font(.headline)
                        .foregroundColor(Color("SoftGold"))

                    Text(instructions)
                        .font(.body)
                        .foregroundColor(Color("ML"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()

                Button(action: {
                    // Restart navigation if you'd like
                }) {
                    Text("Start Again 🔁")
                }
                .buttonStyle(SoftGlowingButton())
            }
            .padding()
        }
    }
}

#Preview {
    let mock = Cocktail(id: "1", name: "Mystic Margarita", imageURL: nil, instructions: "Shake well.", ingredient1: "Tequila", ingredient2: "Lime", ingredient3: nil, ingredient4: nil, ingredient5: nil)
    return CocktailTarotCardView(cocktail: mock).injectPreviewContext()
}
