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
    let ingredientsBtnSizeMultiplier: CGFloat = 0.14
    
    // MARK: - Mutable Properties
    var isIngredientsVisible: Bool? {
        didSet {
            if let isIngredientsVisible = self.isIngredientsVisible {
                self.ingredientsButton.tintColor = isIngredientsVisible ? UIColor.color2 : UIColor.white
            }
        }
    }
    
    // MARK: - UI Elements
    let backgroundSplash = UIView()
    let title = UILabel()
    let subtitle = UILabel()
    let rating = UIView()
    let image = UIImageView()
    let imageShadow = UIView()
    let recipeDescription = UITextView()
    let difficulty = UILabel()
    let nutritionStack = UIStackView()
    let nutritionStackContainer = UIView()
    let protein = UILabel()
    let calories = UILabel()
    let carbs = UILabel()
    let fats = UILabel()
    lazy var ingredientsButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.ingredientsBtnSizeMultiplier, height: self.frame.width * self.ingredientsBtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    lazy var likeButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.ingredientsBtnSizeMultiplier, height: self.frame.width * self.ingredientsBtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    
    // MARK: - Delegate Properties
    weak var userFeedbackDelegate: UserFeedbackDelegate?
    
    // Margin padding property - influenced by sideMarginMultiplier in static properties
    var recipe: Recipe? {
        didSet { self.loadRecipeData() }
    }
    var splashColor: UIColor?
    var sideMargin: CGFloat { return self.frame.width * self.sideMarginMultiplier }
    
    // MARK: - Setup Methods
    private func setup() {
        self.backgroundColor = .white
        self.addViews()
        
        self.backgroundSplashConstraints()
        self.titleConstraints()
        self.ImageConstraints()
        self.descriptionConstraints()
        self.ingredientsButtonConstraints()
        self.nutritionConstraints()
        self.ratingConstraints()
        self.likeConstraints()
        
        self.modifyBackroundColor()
        self.modifyTitle()
        self.modifyImage()
        self.modifyDescription()
        self.modifyIngredientsBtn()
        self.modifyNutritionStack()
        self.modifyLikeBtn()
        self.modifyRating()
    }
    
    private func addViews() {
        self.addSubview(self.backgroundSplash)                          // Included
        self.addSubview(self.title)                                     // Included
        self.addSubview(self.subtitle)
        self.addSubview(self.rating)                                    // Included
        self.addSubview(self.recipeDescription)                         // Included
        self.addSubview(self.likeButton)                                // Included
        self.addSubview(self.difficulty)
        self.addSubview(self.nutritionStackContainer)                   // Included
        self.nutritionStackContainer.addSubview(self.nutritionStack)    // Included
        self.addSubview(self.ingredientsButton)                         // Included
        self.addSubview(self.imageShadow)                               // Included
        self.addSubview(self.image)                                     // Included
    }
    
    // Method to load and reload data based on changes to Recipe Obj.
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
        if let isLiked = self.recipe?.isLiked {
            self.likeButton.tintColor = isLiked ? UIColor.color2 : self.splashColor ?? UIColor.blue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}


// MARK: - View AutoLayout Constraint Methods
extension RecipeCell {
    
    fileprivate func backgroundSplashConstraints() {
        self.backgroundSplash.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundSplash.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundSplash.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundSplash.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundSplash.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    fileprivate func titleConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func ImageConstraints() {
        // Make sure imageShadoe and image constraints are identical as they are both in the same view heirarchy
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
    }
    
    fileprivate func descriptionConstraints() {
        self.recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        self.recipeDescription.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        self.recipeDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.recipeDescription.bottomAnchor.constraint(equalTo: self.ingredientsButton.topAnchor, constant: -5).isActive = true
        self.recipeDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin * 0.8).isActive = true
    }
    
    fileprivate func ingredientsButtonConstraints() {
        self.ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.ingredientsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.ingredientsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.ingredientsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin / 2).isActive = true
    }
    
    fileprivate func nutritionConstraints() {
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
    
    private func ratingConstraints() {
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.rating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin * 0.8).isActive = true
        self.rating.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 5).isActive = true
        self.rating.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.rating.trailingAnchor.constraint(equalTo: self.title.trailingAnchor).isActive = true
    }
    
    private func likeConstraints() {
        self.likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.likeButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.likeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.ingredientsBtnSizeMultiplier).isActive = true
        self.likeButton.centerYAnchor.constraint(equalTo: self.image.topAnchor).isActive = true
        self.likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin / 2).isActive = true
    }
    
}


// MARK: - Modifying views of Recipe Cell Methods
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
        // add function to animate collectionView new layout and create ingredients view
        self.ingredientsButton.setImage(UIImage(named: "ingredients_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.ingredientsButton.tintColor = .white
        self.ingredientsButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.ingredientsButton.addTarget(self, action: #selector(self.userPressedIngredients), for: .touchUpInside)
    }
    
    private func modifyLikeBtn() {
        // add function to call delegate method to handle pushing likes to server
        self.likeButton.backgroundColor = .white
        self.likeButton.setImage(UIImage(named: "heart_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
        self.likeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.likeButton.addTarget(self, action: #selector(self.userPressedLike), for: .touchUpInside)
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
    }
    
    private func modifyImage() {
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
    
    private func modifyRating() {
        self.rating.backgroundColor = .gray
    }
    
}


// MARK: - User Interaction methods
extension RecipeCell {
    
    @objc private func userPressedLike() {
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
    
    @objc private func userPressedIngredients() {
        if let isIngredientsVisible = self.isIngredientsVisible {
            self.isIngredientsVisible = isIngredientsVisible ? false : true
            
        } else {
            // If nil then assume false and switch to true
            self.isIngredientsVisible = true
        }
    }
    
    override func prepareForReuse() {
        // reset reusable cell's default color
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
        super.prepareForReuse()
    }
    
}
