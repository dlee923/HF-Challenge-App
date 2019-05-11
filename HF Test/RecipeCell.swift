//
//  RecipeCell.swift
//  HF Test
//
//  Created by Daniel Lee on 5/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet { self.loadRecipeData() }
    }
    
    let title = UILabel()
    let subtitle = UILabel()
    let rating = UIView()
    let image = UIImageView()
    let recipeDescription = UITextView()
    let like = UIImageView()
    let difficulty = UILabel()
    let nutrition = UIView()
    let ingredientsButton = UIButton()
    
    let testStackView = UIStackView()
    let testStackViewContainer = UIView()
    
    private func setup() {
        self.backgroundColor = .blue
        self.addStackView()
        self.addViewConstraints()
        self.modifyViews()
    }
    
    private func addViews() {
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.rating)
        self.addSubview(self.image)
        self.addSubview(self.recipeDescription)
        self.addSubview(self.like)
        self.addSubview(self.difficulty)
        self.addSubview(self.nutrition)
        self.addSubview(self.ingredientsButton)
    }
    
    private func addStackView() {
        self.addSubview(self.testStackViewContainer)
        self.testStackViewContainer.addSubview(self.testStackView)
        
        self.testStackView.addArrangedSubview(self.title)
        self.testStackView.addArrangedSubview(self.subtitle)
        self.testStackView.addArrangedSubview(self.rating)
        self.testStackView.addArrangedSubview(self.image)
        self.testStackView.addArrangedSubview(self.recipeDescription)
        self.testStackView.addArrangedSubview(self.like)
        self.testStackView.addArrangedSubview(self.difficulty)
        self.testStackView.addArrangedSubview(self.nutrition)
        self.testStackView.addArrangedSubview(self.ingredientsButton)
        
    }
    
    private func addViewConstraints() {
        self.testStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.testStackViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.testStackViewContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.testStackViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.testStackViewContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        
        self.testStackView.translatesAutoresizingMaskIntoConstraints = false
        self.testStackView.topAnchor.constraint(equalTo: self.testStackViewContainer.topAnchor, constant: 5).isActive = true
        self.testStackView.rightAnchor.constraint(equalTo: self.testStackViewContainer.rightAnchor, constant: -5).isActive = true
        self.testStackView.bottomAnchor.constraint(equalTo: self.testStackViewContainer.bottomAnchor, constant: -5).isActive = true
        self.testStackView.leftAnchor.constraint(equalTo: self.testStackViewContainer.leftAnchor, constant: 5).isActive = true
    }
    
    private func modifyViews() {
        testStackViewContainer.backgroundColor = .yellow
        
        testStackView.spacing = 5
        testStackView.axis = .vertical
        testStackView.distribution = .fillEqually
        testStackView.alignment = .fill
        for view in self.testStackView.arrangedSubviews {
            view.backgroundColor = .gray
        }
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
