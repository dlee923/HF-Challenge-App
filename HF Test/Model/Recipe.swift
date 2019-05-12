//
//  Recipe.swift
//  HF Test
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

class Recipe: NSObject {
    
    // MARK: - Properties
    var highlighted: Bool?
    var time: String?
    var recipeInfo: RecipeInfo?
    var user: User?
    var nutrition: Nutrition?
    var recipeStats: RecipeStats?
    var recipeClassification: RecipeClassification?
    var recipeImageSource: RecipeImageSource?
    var imageData: Data?
    var isLiked: Bool?
    
    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    init(highlighted: Bool, time: String, recipeInfo: RecipeInfo, user: User, nutrition: Nutrition, recipeStats: RecipeStats, recipeClassification: RecipeClassification, recipeImageSource: RecipeImageSource) {
        super.init()
        self.highlighted = highlighted
        self.time = time
        self.recipeInfo = recipeInfo
        self.user = user
        self.nutrition = nutrition
        self.recipeStats = recipeStats
        self.recipeClassification = recipeClassification
        self.recipeImageSource = recipeImageSource
    }
    
    // MARK: - Class Structs
    struct Nutrition {
        var proteins: String?
        var fibers: String?
        var carbos: String?
        var calories: String?
        var fats: String?
    }
    
    struct RecipeInfo {
        var name: String?
        var headline: String?
        var descript: String?
        var id: String?
        var ingredients: [String]?
        var undeliverableIngredients: [String]?
        var deliverableIngredients: [String]?
        var incompatibilities: String?
    }
    
    struct RecipeStats {
        var rating: Double?
        var ratings: Int?
        var difficulty: Int?
    }
    
    struct RecipeClassification {
        var country: String?
        var products: [String]?
        var favorites: Int?
        var keywords: [String]?
        var weeks: [String]?
    }
    
    struct RecipeImageSource {
        var image: String?
        var thumb: String?
        var card: String?
    }

    
}
