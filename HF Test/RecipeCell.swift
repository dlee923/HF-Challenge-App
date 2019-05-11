//
//  RecipeCell.swift
//  HF Test
//
//  Created by Daniel Lee on 5/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    // MARK: - Static Properties
    let imageWidthMultiplier: CGFloat = 0.65
    let sideMarginMultiplier: CGFloat = 0.12
    let ingredientsBtnSizeMultiplier: CGFloat = 0.15
    
    // MARK: - Mutable Properties
    var recipe: Recipe? {
        didSet { self.loadRecipeData() }
    }
    var splashColor: UIColor?
    
    let title = UILabel()
    let subtitle = UILabel()
    let rating = UIView()
    let image = UIImageView()
    let imageShadow = UIView()
    let recipeDescription = UITextView()
    let like = UIImageView()
    let difficulty = UILabel()
    
    let nutritionStack = UIStackView()
    let nutritionStackContainer = UIView()
    let protein = UILabel()
    let calories = UILabel()
    let carbs = UILabel()
    let fats = UILabel()
    
    let ingredientsButton = UIButton()
    let backgroundSplash = UIView()
    
    // MARK: - Setup Methods
    private func setup() {
        self.backgroundColor = .white
        self.addViews()
        self.addViewConstraints()
        
        self.modifyBackroundColor()
        self.modifyTitle()
        self.modifyImage()
        self.modifyDescription()
        self.modifyIngredientsBtn()
        self.modifyNutritionStack()
    }
    
    private func addViews() {
        self.addSubview(self.backgroundSplash)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.rating)
        self.addSubview(self.recipeDescription)
        self.addSubview(self.like)
        self.addSubview(self.difficulty)
        self.addSubview(self.nutritionStackContainer)
        self.nutritionStackContainer.addSubview(self.nutritionStack)
        self.addSubview(self.ingredientsButton)
        self.addSubview(self.imageShadow)
        self.addSubview(self.image)
    }
    
    private func loadRecipeData() {
        self.title.text = self.recipe?.recipeInfo?.name
        self.subtitle.text = self.recipe?.recipeInfo?.headline
        if let imageData = self.recipe?.imageData {
            self.image.image = UIImage(data: imageData)
        }
        self.recipeDescription.text = self.recipe?.recipeInfo?.descript
        self.protein.text = self.recipe?.nutrition?.proteins
        self.fats.text = self.recipe?.nutrition?.fats
        self.carbs.text = self.recipe?.nutrition?.carbos
        self.calories.text = self.recipe?.nutrition?.calories
        self.subtitle.text = self.recipe?.recipeInfo?.headline
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: - View Constraint Methods
extension RecipeCell {
    
    private func addViewConstraints() {
        let sideMargin: CGFloat = self.frame.width * self.sideMarginMultiplier
        
        self.backgroundSplash.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundSplash.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundSplash.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundSplash.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundSplash.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.imageShadow.translatesAutoresizingMaskIntoConstraints = false
        self.imageShadow.bottomAnchor.constraint(equalTo: self.backgroundSplash.bottomAnchor, constant: self.frame.height * 0.05).isActive = true
        self.imageShadow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        self.imageShadow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        self.imageShadow.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.bottomAnchor.constraint(equalTo: self.backgroundSplash.bottomAnchor, constant: self.frame.height * 0.05).isActive = true
        self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        self.image.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        self.image.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.imageWidthMultiplier).isActive = true
        
        self.recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        self.recipeDescription.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        self.recipeDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.recipeDescription.bottomAnchor.constraint(equalTo: self.ingredientsButton.topAnchor, constant: -5).isActive = true
        self.recipeDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
        
        self.ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.ingredientsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.ingredientsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.ingredientsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin / 2).isActive = true
        
        self.nutritionStackContainer.translatesAutoresizingMaskIntoConstraints = false
        self.nutritionStackContainer.topAnchor.constraint(equalTo: self.recipeDescription.bottomAnchor, constant: 5).isActive = true
        self.nutritionStackContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.nutritionStackContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.nutritionStackContainer.trailingAnchor.constraint(equalTo: self.ingredientsButton.leadingAnchor, constant: -sideMargin * 0.4).isActive = true
        
        self.nutritionStack.translatesAutoresizingMaskIntoConstraints = false
        self.nutritionStack.topAnchor.constraint(equalTo: self.nutritionStackContainer.topAnchor, constant: 0).isActive = true
        self.nutritionStack.bottomAnchor.constraint(equalTo: self.nutritionStackContainer.bottomAnchor, constant: -5).isActive = true
        self.nutritionStack.trailingAnchor.constraint(equalTo: self.nutritionStackContainer.trailingAnchor, constant: 0).isActive = true
        self.nutritionStack.leadingAnchor.constraint(equalTo: self.nutritionStackContainer.leadingAnchor, constant: 0).isActive = true
    }
    
}

//MARK: - Modifying views of Recipe Cell Methods
extension RecipeCell {
    
    private func modifyBackroundColor() {
        self.backgroundSplash.backgroundColor = self.splashColor ?? UIColor.blue
    }
    
    private func modifyTitle() {
        self.title.textColor = .white
        self.title.font = UIFont.fontBebas?.withSize(40)
    }
    
    private func modifyDescription() {
        self.recipeDescription.backgroundColor = .white
        self.recipeDescription.textAlignment = .left
        self.recipeDescription.isEditable = false
        
        self.recipeDescription.font = UIFont.fontCoolvetica?.withSize(15)
    }
    
    private func modifyIngredientsBtn() {
        self.ingredientsButton.backgroundColor = .blue
        self.ingredientsButton.layer.cornerRadius = (self.frame.width * self.ingredientsBtnSizeMultiplier) / 2
        self.ingredientsButton.clipsToBounds = true
    }
    
    private func modifyNutritionStack() {
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
        
        for stackView in nutritionStackSubviews {
            for view in stackView.arrangedSubviews {
                if let label = view as? UILabel {
                    label.font = UIFont.fontCoolvetica?.withSize(12)
                    label.textColor = UIColor.black.withAlphaComponent(0.9)
                }
            }
        }
        
        self.nutritionStack.addArrangedSubview(labelStackView)
        self.nutritionStack.addArrangedSubview(dataStackView)
        self.nutritionStack.stackProperties(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fill)
//        self.nutritionStack.setCustomSpacing(-5, after: labelStackView)
    }
    
    private func modifyImage() {
        self.image.contentMode = .scaleAspectFill
        self.image.backgroundColor = .white
        self.image.layer.cornerRadius = (self.frame.width * self.imageWidthMultiplier) / 2
        self.image.layer.borderColor = UIColor.white.cgColor
        self.image.layer.borderWidth = 2
        
        self.image.clipsToBounds = true
        
        self.imageShadow.frame = CGRect(x: 0, y: 0, width: (self.frame.width * self.imageWidthMultiplier), height: (self.frame.width * self.imageWidthMultiplier))
        self.imageShadow.layer.shadowPath = UIBezierPath(ovalIn: self.imageShadow.layer.bounds).cgPath
        self.imageShadow.layer.shadowColor = UIColor.black.cgColor
        self.imageShadow.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.imageShadow.layer.shadowRadius = 15
        self.imageShadow.layer.shadowOpacity = 0.5
    }
    
}
