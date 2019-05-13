//
//  RecipeCellConstraints.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

// MARK: - View AutoLayout Constraint Methods
extension RecipeCell {
    
    // MARK: - Background Splash + Animatable Constraints
    internal func backgroundSplashConstraints() {
        self.backgroundSplash.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundSplash.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundSplash.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundSplash.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundSplashHeight = self.backgroundSplash.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.53)
        backgroundSplashHeightSquished = self.backgroundSplash.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        backgroundSplashHeight?.isActive = true
    }
    
    internal func squishBackgroundSplash() {
        let isSquished = self.isIngredientsVisible ?? false
        if !isSquished {
            backgroundSplashHeightSquished?.isActive = false
            backgroundSplashHeight?.isActive = true
        } else {
            backgroundSplashHeight?.isActive = false
            backgroundSplashHeightSquished?.isActive = true
        }
    }
    
    // MARK: - Title
    internal func titleConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 88).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Image + Animatable Constraints
    internal func ImageConstraints() {
        // Make sure imageShadoe and image constraints are identical as they are both in the same view heirarchy
        self.imageShadow.translatesAutoresizingMaskIntoConstraints = false
        imageShadowBottom = self.imageShadow.bottomAnchor.constraint(equalTo: self.backgroundSplash.bottomAnchor, constant: self.frame.height * 0.03)
        self.imageShadow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        self.imageShadow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        self.imageShadow.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        imageShadowBottom?.isActive = true
        
        self.image.translatesAutoresizingMaskIntoConstraints = false
        imageBottom = self.image.bottomAnchor.constraint(equalTo: self.backgroundSplash.bottomAnchor, constant: self.frame.height * 0.03)
        self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        self.image.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        self.image.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        imageBottom?.isActive = true
    }
    
    internal func squishImage() {
        let scaleMultiplier: CGFloat = 0.55
        let isSquished = self.isIngredientsVisible ?? false
        if !isSquished {
            imageShadow.transform = CGAffineTransform.identity
            image.transform = CGAffineTransform.identity
        } else {
            imageShadow.transform = CGAffineTransform(translationX: -sideMargin * 1.15, y: self.frame.height * 0.0075).scaledBy(x: scaleMultiplier, y: scaleMultiplier)
            image.transform = CGAffineTransform(translationX: -sideMargin * 1.15, y: self.frame.height * 0.0075).scaledBy(x: scaleMultiplier, y: scaleMultiplier)
        }
    }
    
    // MARK: - Description
    internal func descriptionConstraints() {
        self.recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        self.recipeDescription.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        self.recipeDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.recipeDescription.bottomAnchor.constraint(equalTo: self.ingredientsButton.topAnchor, constant: -5).isActive = true
        self.recipeDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
    }
    
    // MARK: - Ingredients Button
    internal func ingredientsButtonConstraints() {
        self.ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.BtnSizeMultiplier).isActive = true
        self.ingredientsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.BtnSizeMultiplier).isActive = true
        self.ingredientsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.ingredientsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin / 2).isActive = true
    }
    
    // MARK: - Nutrition Box
    internal func nutritionConstraints() {
        self.nutritionStackContainer.translatesAutoresizingMaskIntoConstraints = false
        self.nutritionStackContainer.topAnchor.constraint(equalTo: self.ingredientsButton.topAnchor).isActive = true
        self.nutritionStackContainer.bottomAnchor.constraint(equalTo: self.ingredientsButton.bottomAnchor, constant: -5).isActive = true
        self.nutritionStackContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.nutritionStackContainer.trailingAnchor.constraint(equalTo: self.ingredientsButton.leadingAnchor, constant: -sideMargin * 0.4).isActive = true
        
        self.nutritionStack.translatesAutoresizingMaskIntoConstraints = false
        self.nutritionStack.topAnchor.constraint(equalTo: self.nutritionStackContainer.topAnchor).isActive = true
        self.nutritionStack.bottomAnchor.constraint(equalTo: self.nutritionStackContainer.bottomAnchor).isActive = true
        self.nutritionStack.trailingAnchor.constraint(equalTo: self.nutritionStackContainer.trailingAnchor).isActive = true
        self.nutritionStack.leadingAnchor.constraint(equalTo: self.nutritionStackContainer.leadingAnchor).isActive = true
    }
    
    // MARK: - Rating
    internal func ratingConstraints() {
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.rating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.rating.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 5).isActive = true
        self.rating.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // (height * number of stars) + (spacing * number of stars - 1)
        self.rating.widthAnchor.constraint(equalToConstant: (20 * 4) + (5 * 3)).isActive = true
    }
    
    // MARK: - Like Button + Animatable Constraints
    internal func likeConstraints() {
        self.likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.likeButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.BtnSizeMultiplier).isActive = true
        self.likeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.BtnSizeMultiplier).isActive = true
        self.likeButton.centerYAnchor.constraint(equalTo: self.image.topAnchor).isActive = true
        self.likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin / 2).isActive = true
    }
    
    internal func squishLike() {
        let isSquished = self.isIngredientsVisible ?? false
        if !isSquished {
            likeButton.transform = CGAffineTransform.identity
        } else {
            likeButton.transform = CGAffineTransform(translationX: 0, y: self.frame.height * 0.10)
        }
    }
    
}