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
    let BtnSizeMultiplier: CGFloat = 0.13
    
    // MARK: - Mutable Properties
    var isIngredientsVisible: Bool? {
        didSet {
            if let isIngredientsVisible = self.isIngredientsVisible {
                self.ingredientsButton.tintColor = isIngredientsVisible ? UIColor.white.withAlphaComponent(0.5) : UIColor.white
            }
        }
    }
    
    // MARK: - UI Elements
    let backgroundSplash = UIView()
    let title = UILabel()
    let subtitle = UILabel()
    let rating = RatingView()
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
    lazy var ingredientsButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    lazy var likeButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    
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
        
        self.modifyColors()
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
    internal func loadRecipeData() {
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
        if let userRating = self.recipe?.userRating {
            print(recipe?.recipeInfo?.name)
            print(userRating)
            self.rating.highlightStars(rating: userRating)
        }
    }
    
    // reset reusable cell's default color and other non content properties
    override func prepareForReuse() {
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
        self.backgroundSplashHeightSquished?.isActive = false
        self.backgroundSplashHeight?.isActive = true
        self.imageShadow.transform = CGAffineTransform.identity
        self.image.transform = CGAffineTransform.identity
        self.likeButton.transform = CGAffineTransform.identity
        self.rating.prepareForReuse()
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Animatable Constraint Properties
    var backgroundSplashHeight: NSLayoutConstraint?
    var backgroundSplashHeightSquished: NSLayoutConstraint?
    
    var imageShadowBottom: NSLayoutConstraint?
    var imageBottom: NSLayoutConstraint?
}


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
    
    private func modifyTitle() {
        self.title.textColor = .white
        self.title.font = UIFont.fontBebas?.withSize(40)
    }
    
    private func modifyDescription() {
        self.recipeDescription.backgroundColor = .white
        self.recipeDescription.textAlignment = .left
        self.recipeDescription.isEditable = false
        self.recipeDescription.textColor = UIColor.black.withAlphaComponent(0.8)
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
        self.likeButton.setImage(UIImage(named: "heart2_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
