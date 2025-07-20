//
//  WelcomeView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/14/25.
//
//
//  WelcomeView.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/14/25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var cocktailVM: CocktailViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("DeepNavy"), Color("DarkerNavy")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("⭐ Alcysm ~~")
                        .font(.custom("PlayfairDisplay-Regular", size: 48))
                        .foregroundColor(Color("SoftGold"))
                        .shadow(color: Color("SoftGold"), radius: 10)

                    Text("Curate your perfect sip.")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(Color("Lavender"))

                    VStack(spacing: 20) {
                        NavigationLink(destination: PreferencesView().environmentObject(cocktailVM)) {
                            Text("✨ Find Your Perfect Cocktail")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 48)
                                .padding(.vertical, 16)
                                .background(Color("SoftLavender"))
                                .cornerRadius(24)
                                .shadow(color: Color("SoftLavender"), radius: 20)
                        }

                        NavigationLink(destination: FavoritesView().environmentObject(cocktailVM)) {
                            Text("⭐ View Your Favorites")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 48)
                                .padding(.vertical, 16)
                                .background(Color("SoftLavender"))
                                .cornerRadius(24)
                                .shadow(color: Color("SoftLavender"), radius: 20)
                        }

                        NavigationLink(destination: BirthdateTarotView().environmentObject(cocktailVM)) {
                            Text("🔮 Pull Your Cocktail Card")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 48)
                                .padding(.vertical, 16)
                                .background(Color("SoftLavender"))
                                .cornerRadius(24)
                                .shadow(color: Color("SoftLavender"), radius: 20)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

// ✅ Correct Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(CocktailViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
