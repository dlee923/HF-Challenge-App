//
//  RecipeCellInteraction.swift
//  HF Test
//
//  Created by Daniel Lee on 5/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

protocol RecipeUserInteractionDelegate: RecipeCell {
    
    func userPressedLike()
    func userPressedIngredients()
    func userPressedRating()
    
}

// MARK: - User Interaction methods
extension RecipeCell: RecipeUserInteractionDelegate {
    
    @objc internal func userPressedLike() {
        if let isLiked = self.recipe?.isLiked {
            self.recipe?.isLiked = isLiked ? false : true
            self.userFeedbackDelegate?.userLiked(liked: (self.recipe?.isLiked)!)
        } else {
            // If nil then assume false and switch to true
            self.recipe?.isLiked = true
            self.userFeedbackDelegate?.userLiked(liked: (self.recipe?.isLiked)!)
        }
        // reload view based on recipe changes
        loadRecipeData()
    }
    
    @objc internal func userPressedIngredients() {
        if let isIngredientsVisible = self.isIngredientsVisible {
            self.isIngredientsVisible = isIngredientsVisible ? false : true
        } else {
            // If nil then assume false and switch to true
            self.isIngredientsVisible = true
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.squishBackgroundSplash()
            self.squishImage()
            self.squishLike()
            self.squishIngredientsButton()
            self.squishNutrition()
            self.squishIngredients()
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc internal func userPressedRating() {
        if let rating = self.rating.rating {
            // Set recipe object rating here
            self.recipe?.userRating = rating
            // Command view controller to send rating to server
            self.userFeedbackDelegate?.userRated(rating: rating, isRated: self.rating.isRated ?? false)
        }
    }
    
}
