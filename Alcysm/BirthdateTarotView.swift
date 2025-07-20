import SwiftUI

struct BirthdateTarotView: View {
    @State private var birthdate = Date()
    @State private var showTarotCard = false

    @EnvironmentObject var cocktailVM: CocktailViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BG").ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("✨ Your Birthdate Ritual ✨")
                        .font(.title2)
                        .foregroundColor(Color("Lavender"))

                    Text("Select Your Birthday~")
                        .bold()
                        .italic()
                        .foregroundColor(Color("DeepNavy"))
                        .font(.system(size: 30))

                    DatePicker(
                        "Select your birthdate:",
                        selection: $birthdate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .accentColor(Color("SoftLavender"))
                    .colorMultiply(Color("ML"))

                    Spacer()

                    VStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 40))
                            .foregroundColor(Color("SoftLavender"))
                            .opacity(0.7)
                            .padding(.bottom, 10)

                        Text("The cosmos stirs... your cocktail fate awaits.")
                            .font(.footnote)
                            .italic()
                            .foregroundColor(Color("ML"))
                    }

                    Spacer()

                    Button(action: {
                        cocktailVM.fetchCocktailOfTheWeekend()
                        showTarotCard = true
                    }) {
                        Text("Pull Your Cocktail Card 🔮")
                    }
                    .buttonStyle(SoftGlowingButton())
                }
                .padding()
            }
            .navigationDestination(isPresented: $showTarotCard) {
                if let cocktail = cocktailVM.cocktailOfTheWeekend {
                    CocktailTarotCardView(cocktail: cocktail)
                } else {
                    Text("No cocktail found.")
                        .foregroundColor(Color("Lavender"))
                }
            }
        }
    }
}

#Preview {
    BirthdateTarotView()
        .environmentObject(CocktailViewModel())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
