//
//  RecipeCellViews.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

// MARK: - Modifying COLORS of Recipe Cell
extension RecipeCell {
    
    func modifyColors() {
        self.backgroundSplash.backgroundColor = self.splashColor ?? UIColor.blue
        self.ingredientsButton.backgroundColor = self.splashColor ?? UIColor.blue
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
    }
    
}


// MARK: - Modifying view PROPERTIES of Recipe Cell
extension RecipeCell {
    
    internal func modifyTitle() {
        self.title.textColor = .white
        self.title.font = UIFont.fontBebas?.withSize(40)
    }
    
    internal func modifyDescription() {
        self.recipeDescription.backgroundColor = .white
        self.recipeDescription.textAlignment = .left
        self.recipeDescription.isEditable = false
        self.recipeDescription.textColor = UIColor.black.withAlphaComponent(0.8)
        let descripFontSize = DeviceViews.recipeDescriptionFontSize[Device.current.deviceType] ?? 15
        self.recipeDescription.font = UIFont.fontCoolvetica?.withSize(descripFontSize)
    }
    
    internal func modifyIngredientsBtn() {
        self.ingredientsButton.setImage(UIImage(named: "ingredients_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.ingredientsButton.tintColor = .white
        self.ingredientsButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.ingredientsButton.addTarget(self, action: #selector(self.userPressedIngredients), for: .touchUpInside)
    }
    
    internal func modifyLikeBtn() {
        
        self.likeButton.backgroundColor = .white
        self.likeButton.setImage(UIImage(named: "heart2_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.likeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.likeButton.addTarget(self, action: #selector(self.userPressedLike), for: .touchUpInside)
    }
    
    internal func modifyNutritionStack() {
        self.nutritionStackContainer.backgroundColor = .white
        
        let proteinLbl = UILabel()
        proteinLbl.text = "Protein"
        let fatsLbl = UILabel()
        fatsLbl.text = "Fats"
        let carbsLbl = UILabel()
        carbsLbl.text = "Carbos"
        let caloriesLbl = UILabel()
        caloriesLbl.text = "Cal."
        
        let labelStackView = UIStackView(arrangedSubviews: [proteinLbl, fatsLbl, carbsLbl, caloriesLbl])
        labelStackView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
        
        let dataStackView = UIStackView(arrangedSubviews: [self.protein, self.fats, self.carbs, self.calories])
        dataStackView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
        
        let nutritionStackSubviews = [labelStackView, dataStackView]
        let nutritionFontSize = DeviceViews.nutritionFontSize[Device.current.deviceType] ?? 12
        
        for stackView in nutritionStackSubviews {
            for view in stackView.arrangedSubviews {
                if let label = view as? UILabel {
                    label.font = UIFont.fontCoolvetica?.withSize(nutritionFontSize)
                    label.textColor = UIColor.black.withAlphaComponent(0.9)
                }
            }
        }
        
        self.nutritionStack.addArrangedSubview(labelStackView)
        self.nutritionStack.addArrangedSubview(dataStackView)
        self.nutritionStack.stackProperties(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fill)
    }
    
    internal func modifyImage() {
        self.image.contentMode = .scaleAspectFill
        self.image.backgroundColor = .white
        self.image.layer.cornerRadius = (self.frame.width * self.imageWidthMultiplier) / 2
        self.image.layer.borderColor = UIColor.white.cgColor
        self.image.layer.borderWidth = 2
        
        self.image.clipsToBounds = true
        
        self.imageShadow.frame = CGRect(x: 0, y: 0, width: (self.frame.width * self.imageWidthMultiplier), height: (self.frame.width * self.imageWidthMultiplier))
        self.imageShadow.addShadow(path: UIBezierPath(ovalIn: self.imageShadow.layer.bounds),
                                   color: .black,
                                   offset: CGSize(width: 3.0, height: 3.0),
                                   radius: 15,
                                   opacity: 0.5)
    }
    
    internal func modifyRating() {
        self.rating.backgroundColor = .gray
        self.rating.recipeUserInteractionDelegate = self
    }
    
    internal func modifyIngredientsView() {
        let ingredientButtonHeight = (self.frame.width * self.BtnSizeMultiplier) + 15
        self.ingredientsView.headerHeight = ingredientButtonHeight
        self.ingredientsView.alpha = 0.0
    }
    
}
