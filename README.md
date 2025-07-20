# Alcysm

# 🍸 Alcysm

**Alcysm** is an iOS app designed to help adults discover unique, personalized cocktails.  
It combines a sense of ritual with modern mixology. Users can pull a tarot-inspired random cocktail, filter recipes by flavor and spirit, and build a personal list of favorites through a clean, intuitive SwiftUI interface.

---

## 🎁 About This Project

This app was created as a special gift for a friend celebrating their 21st birthday.  
**Alcysm** is intended to help mark the milestone with fun, safe, and inspiring cocktail discovery.

---

## 📋 Purpose and Age Requirement

**Alcysm** is intended for responsible adults aged 21 and over.  
Users under the legal drinking age are not permitted to use this app.  
Always enjoy alcoholic beverages responsibly.

---

## 📱 Features

- Birthdate Ritual Tarot: Pull a mystical random "Cocktail of the Weekend"
- Personalized Recipes: Pick flavor profiles and spirits to generate curated suggestions
- Cocktail Details: View ingredients, instructions, and images
- Favorites: Save and manage favorite cocktails with local storage
- Smooth SwiftUI Navigation: Fast, polished transitions and custom design
- Persistent Storage: Save favorites securely with Core Data

---

## ⚙️ Tech Stack

- Platform: iOS 17+
- Language: Swift 5.9+
- Frameworks: SwiftUI, Core Data
- API: [TheCocktailDB](https://www.thecocktaildb.com) for live cocktail data

---

## 📂 Project Structure

- `AlcysmApp.swift` — App entry point
- `Cocktail.swift` — Data model
- `CocktailAPI.swift` — API service for fetching cocktails
- `CocktailViewModel.swift` — Business logic, API calls, Core Data handling
- `PersistenceController.swift` — Core Data setup
- `Views/` — Contains all SwiftUI views:
  - `WelcomeView`
  - `BirthdateTarotView`
  - `PreferencesView`
  - `SpiritsView`
  - `RecipesListView`
  - `CocktailDetailView`
  - `FavoritesView`
- `SoftGlowingButton.swift` — Custom reusable button style
- `PreviewMocks.swift` — Preview helpers for Xcode Canvas

---

## 🗃️ Core Data

Make sure your `.xcdatamodeld` file is named `DataBase.xcdatamodeld`.  
Include a `FavoriteCocktail` entity with these attributes:
- `id: String`
- `name: String`
- `imageURL: String`

This stores favorite cocktails locally.

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/aditimohanj/Alcysm.git
   cd Alcysm

