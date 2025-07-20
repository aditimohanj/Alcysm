//
//  CocktailAPI.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/15/25.
//
import Foundation

struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}

class CocktailAPIService {
    static let shared = CocktailAPIService()
    private init() {}

    func fetchCocktails(for query: String, completion: @escaping (Result<[Cocktail], Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(query)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                let drinks = response.drinks ?? []

                let group = DispatchGroup()
                var detailedCocktails: [Cocktail] = []

                for drink in drinks {
                    group.enter()
                    self.fetchCocktailDetails(for: drink.id) { result in
                        if case .success(let fullDrink) = result {
                            detailedCocktails.append(fullDrink)
                        }
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    completion(.success(detailedCocktails))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchRandomCocktail(completion: @escaping (Result<Cocktail, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                if let cocktail = response.drinks?.first {
                    completion(.success(cocktail))
                } else {
                    completion(.failure(APIError.noData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCocktailDetails(for id: String, completion: @escaping (Result<Cocktail, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                if let cocktail = response.drinks?.first {
                    completion(.success(cocktail))
                } else {
                    completion(.failure(APIError.noData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    enum APIError: Error {
        case invalidURL
        case noData
    }
}
