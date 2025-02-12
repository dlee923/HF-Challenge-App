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
    
    // MARK: - Layout Properties
    let imageWidthMultiplier: CGFloat = DeviceViews.imageWidthMultiplier[Device.current.deviceType] ?? 0.65
    let sideMarginMultiplier: CGFloat = 0.12
    let BtnSizeMultiplier: CGFloat = DeviceViews.BtnSizeMultiplier[Device.current.deviceType] ?? 0.13
    
    // MARK: - Mutable Properties
    var isIngredientsVisible: Bool? {
        didSet {
            if let isIngredientsVisible = self.isIngredientsVisible {
                self.ingredientsButton.tintColor = isIngredientsVisible ? UIColor.white.withAlphaComponent(0.5) : UIColor.white
            }
        }
    }
    var recipe: Recipe? {
        didSet { self.loadRecipeData() }
    }
    var splashColor: UIColor? {
        didSet {
            self.ingredientsView.splashColor = self.splashColor
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
    let ingredientsView = IngredientsListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var ingredientsButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    lazy var likeButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    
    // MARK: - Delegate Properties
    weak var userFeedbackDelegate: UserFeedbackDelegate?
    
    // Margin padding property - influenced by sideMarginMultiplier in static properties
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
        self.ingredientsViewConstraints()
        
        self.modifyColors()
        self.modifyTitle()
        self.modifyImage()
        self.modifyDescription()
        self.modifyIngredientsBtn()
        self.modifyNutritionStack()
        self.modifyLikeBtn()
        self.modifyRating()
        self.modifyIngredientsView()
    }
    
    private func addViews() {
        self.addSubview(self.backgroundSplash)                          // Included
        self.addSubview(self.title)                                     // Included
//        self.addSubview(self.subtitle)                                // NOT INCLUDED
        self.addSubview(self.rating)                                    // Included
        self.addSubview(self.likeButton)                                // Included
//        self.addSubview(self.difficulty)                              // NOT INCLUDED
        self.addSubview(self.nutritionStackContainer)                   // Included
        self.addSubview(self.ingredientsView)                           // Included + must overlap nutritionStackContainer in view heirarchy
        self.addSubview(self.recipeDescription)                         // Included + must overlap ingredientsView in view heirarchy
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
            self.rating.highlightStars(rating: userRating)
        }
        self.ingredientsView.ingredients = self.recipe?.recipeInfo?.ingredients
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
        self.ingredientsButtonBottomSquished?.isActive = false
        self.ingredientsButtonBottom?.isActive = true
        self.ingredientsButton.tintColor = .white
        self.nutritionStackContainer.alpha = 1.0
        self.ingredientsViewTopSquished?.isActive = false
        self.ingredientsViewBottomSquished?.isActive = false
        self.ingredientsViewTop?.isActive = true
        self.ingredientsViewBottom?.isActive = true
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
    
    var ingredientsButtonBottom: NSLayoutConstraint?
    var ingredientsButtonBottomSquished: NSLayoutConstraint?
    
    var ingredientsViewBottom: NSLayoutConstraint?
    var ingredientsViewTop: NSLayoutConstraint?
    
    var ingredientsViewBottomSquished: NSLayoutConstraint?
    var ingredientsViewTopSquished: NSLayoutConstraint?
    
}
