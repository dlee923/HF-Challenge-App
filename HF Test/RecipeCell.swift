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
    let sideMarginMultiplier: CGFloat = 0.2
    
    // MARK: - Mutable Properties
    var recipe: Recipe? {
        didSet { self.loadRecipeData() }
    }
    
    let title = UILabel()
    let subtitle = UILabel()
    let rating = UIView()
    let image = UIImageView()
    let imageShadow = UIView()
    let recipeDescription = UITextView()
    let like = UIImageView()
    let difficulty = UILabel()
    let nutrition = UIView()
    let ingredientsButton = UIButton()
    let backgroundSplash = UIView()
    
    // MARK: - Methods
    private func setup() {
        self.backgroundColor = .white
        self.addViews()
        self.addViewConstraints()
        self.modifyBackroundColor()
        self.modifyTitle()
        self.modifyImage()
    }
    
    private func addViews() {
        self.addSubview(self.backgroundSplash)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.rating)
        self.addSubview(self.recipeDescription)
        self.addSubview(self.like)
        self.addSubview(self.difficulty)
        self.addSubview(self.nutrition)
        self.addSubview(self.ingredientsButton)
        self.addSubview(self.imageShadow)
        self.addSubview(self.image)
    }
    
    private func addViewConstraints() {
        let sideMargin: CGFloat = self.frame.width * self.sideMarginMultiplier
        
        self.backgroundSplash.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundSplash.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundSplash.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundSplash.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundSplash.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: sideMargin).isActive = true
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
        self.recipeDescription.topAnchor.constraint(equalTo: self.backgroundSplash.bottomAnchor, constant: 5).isActive = true
        self.recipeDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        self.recipeDescription.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        self.recipeDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
    }
    
    private func modifyBackroundColor() {
        self.backgroundSplash.backgroundColor = .orange
    }
    
    private func modifyTitle() {
        self.title.textColor = .white
        self.title.font = UIFont.fontBebas?.withSize(30)
    }
    
    private func modifyDescription() {
        self.backgroundColor = .gray
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
        self.imageShadow.layer.shadowRadius = 8
        self.imageShadow.layer.shadowOpacity = 0.5
    }
    
    
    private func loadRecipeData() {
        self.title.text = self.recipe?.recipeInfo?.name
        self.subtitle.text = self.recipe?.recipeInfo?.headline
        if let imageData = self.recipe?.imageData {
            self.image.image = UIImage(data: imageData)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
