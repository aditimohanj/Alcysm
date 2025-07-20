//
//  CocktailViewModel.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/15/25.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
class CocktailViewModel: ObservableObject {
    @Published var selectedFlavors: [String] = []
    @Published var selectedSpirits: [String] = []
    @Published var favorites: [Cocktail] = []
    @Published var cocktails: [Cocktail] = []
    @Published var cocktailOfTheWeekend: Cocktail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let flavorToIngredients: [String: [String]] = [
        "Citrus 🍋": ["Lime juice", "Lemon juice", "Orange juice", "Triple sec"],
        "Floral 🌸": ["Elderflower liqueur", "Lavender syrup", "Rose water"],
        "Spicy 🌶️": ["Ginger beer", "Chili", "Cinnamon"],
        "Fruity 🍓": ["Pineapple juice", "Cranberry juice", "Strawberry", "Peach schnapps"],
        "Sweet 🍯": ["Simple syrup", "Honey", "Vanilla liqueur", "Amaretto"],
        "Herbal 🌿": ["Mint", "Basil", "Sage", "Green Chartreuse"]
    ]

    func fetchPersonalizedCocktails() {
        guard let spirit = selectedSpirits.first else {
            errorMessage = "No spirit selected."
            return
        }

        let flavorIngredients = selectedFlavors.flatMap { flavorToIngredients[$0] ?? [] }
        let uniqueIngredients = Set([spirit] + flavorIngredients)

        isLoading = true
        let group = DispatchGroup()
        var allMatches: [Cocktail] = []

        for ingredient in uniqueIngredients {
            group.enter()
            CocktailAPIService.shared.fetchCocktails(for: ingredient) { result in
                switch result {
                case .success(let cocktails):
                    allMatches.append(contentsOf: cocktails)
                case .failure:
                    break
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.isLoading = false
            let unique = Dictionary(grouping: allMatches, by: { $0.id }).compactMap { $0.value.first }
            self.cocktails = unique
            if unique.isEmpty {
                self.errorMessage = "No cocktails found with your preferences."
            }
        }
    }

    func fetchCocktailOfTheWeekend() {
        isLoading = true
        CocktailAPIService.shared.fetchRandomCocktail { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cocktail):
                    self?.cocktailOfTheWeekend = cocktail
                case .failure:
                    self?.errorMessage = "Couldn't pull tarot cocktail."
                }
            }
        }
    }

    func toggleFavorite(_ cocktail: Cocktail, context: NSManagedObjectContext) {
        if isFavorite(cocktail, context: context) {
            let fetchRequest: NSFetchRequest<FavoriteCocktail> = FavoriteCocktail.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", cocktail.id)
            if let favorites = try? context.fetch(fetchRequest),
               let favorite = favorites.first {
                context.delete(favorite)
                try? context.save()
            }
        } else {
            let newFavorite = FavoriteCocktail(context: context)
            newFavorite.id = cocktail.id
            newFavorite.name = cocktail.name
            newFavorite.imageURL = cocktail.imageURL
            try? context.save()
        }
    }

    func isFavorite(_ cocktail: Cocktail, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteCocktail> = FavoriteCocktail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cocktail.id)
        let count = (try? context.count(for: fetchRequest)) ?? 0
        return count > 0
    }

    func loadFavoritesFromCoreData(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<FavoriteCocktail> = FavoriteCocktail.fetchRequest()
        if let results = try? context.fetch(fetchRequest) {
            favorites = results.map {
                Cocktail(id: $0.id ?? "", name: $0.name ?? "", imageURL: $0.imageURL, instructions: nil, ingredient1: nil, ingredient2: nil, ingredient3: nil, ingredient4: nil, ingredient5: nil)
            }
        }
    }
}
