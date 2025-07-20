//
//  Cocktail.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/16/25.
//

import Foundation

struct Cocktail: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let imageURL: String?
    let instructions: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?

    var ingredients: [String] {
        [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
    }

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
    }
}
