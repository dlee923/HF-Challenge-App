//
//  RecipeAPI.swift
//  HF Test
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

class RecipeAPI: NSObject {
    
    static let sharedInstance = RecipeAPI()
    
    /*
     Performs a GET request to retrive recipes from json file
     
     */
    
    func downloadRecipeData(completion: @escaping ([Recipe]) -> ()) {
        // Set a container to add recipe objects to
        var recipesContainer = [Recipe]()
        
        // Access JSON file in the main bundle
        guard let filePath = Bundle.main.path(forResource: "recipes", ofType: "json") else { return }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
        let result = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        
        guard let recipes = result as? [[String: Any?]] else { return }
        
        for recipe in recipes {
            let highlighted = recipe["highlighted"] as? Bool ?? false
            let time = recipe["time"] as? String ?? ""
            
            // Creating RECIPE IMAGE SOURCE object
            let image = recipe["image"] as? String ?? ""
            let thumb = recipe["thumb"] as? String ?? ""
            let card = recipe["card"] as? String ?? ""
            
            let recipeImageSource = Recipe.RecipeImageSource(image: image, thumb: thumb, card: card)
            
            // Creating RECIPE STATS object
            let rating = recipe["rating"] as? Double ?? 0.0
            let ratings = recipe["ratings"] as? Int ?? 0
            let difficulty = recipe["difficulty"] as? Int ?? 0
            
            let recipeStats = Recipe.RecipeStats(rating: rating, ratings: ratings, difficulty: difficulty)
            
            // Creating RECIPE CLASSIFICATION object
            let country = recipe["country"] as? String ?? ""
            let products = recipe["products"] as? [String] ?? [String]()
            let favorites = recipe["favorites"] as? Int ?? 0
            let keywords = recipe["keywords"] as? [String] ?? [String]()
            let weeks = recipe["weeks"] as? [String] ?? [String]()
            
            let recipeClassification = Recipe.RecipeClassification(country: country, products: products, favorites: favorites, keywords: keywords, weeks: weeks)
            
            // Creating USER object
            let user = recipe["user"] as? [String: String]
            let email = user != nil ? user?["email"] ?? "" : ""
            let latlng = user != nil ? user?["latlng"] ?? "" : ""
            let usersName = user != nil ? user?["name"] ?? "" : ""
            
            let userObject = User(email: email, latlng: latlng, name: usersName)
            
            // Creating NUTRITION object
            let calories = recipe["calories"] as? String ?? ""
            let carbos = recipe["carbos"] as? String ?? ""
            let proteins = recipe["proteins"] as? String ?? ""
            let fibers = recipe["fibers"] as? String ?? ""
            let fats = recipe["fats"] as? String ?? ""
            
            let nutrition = Recipe.Nutrition(proteins: proteins, fibers: fibers, carbos: carbos, calories: calories, fats: fats)
            
            // Creating RECIPE INFO object
            let name = recipe["name"] as? String ?? ""
            let headline = recipe["headline"] as? String ?? ""
            let descript = recipe["description"] as? String ?? ""
            let id = recipe["id"] as? String ?? ""
            let ingredients = recipe["ingredients"] as? [String] ?? [String]()
            let undeliverableIngredients = recipe["undeliverableIngredients"] as? [String] ?? [String]()
            let deliverableIngredients = recipe["deliverable_ingredients"] as? [String] ?? [String]()
            let incompatibilities = recipe["incompatibilities"] as? String ?? ""
            
            let recipeInfo = Recipe.RecipeInfo(name: name, headline: headline, descript: descript, id: id, ingredients: ingredients, undeliverableIngredients: undeliverableIngredients, deliverableIngredients: deliverableIngredients, incompatibilities: incompatibilities)
            
            /*
            Creating RECIPE object
            */
            let recipeObject = Recipe(highlighted: highlighted, time: time, recipeInfo: recipeInfo, user: userObject, nutrition: nutrition, recipeStats: recipeStats, recipeClassification: recipeClassification, recipeImageSource: recipeImageSource)

            recipesContainer.append(recipeObject)
        }
        
        completion(recipesContainer)
    }
    
}
