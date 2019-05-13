//
//  RatingView.swift
//  HF Test
//
//  Created by Daniel Lee on 5/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RatingView: UIStackView {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
    }
    
    // MARK: - Mutable Properties
    var rating: Int?
    weak var recipeUserInteractionDelegate: RecipeUserInteractionDelegate?
    
    // MARK: - UI elements
    let star1 = UIButton(type: .custom)
    let star2 = UIButton(type: .custom)
    let star3 = UIButton(type: .custom)
    let star4 = UIButton(type: .custom)
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = .gray
        self.tintColor = .white
        let arrangeViews = [star1, star2, star3, star4]
        for view in arrangeViews {
            self.modifyStars(button: view)
            self.addArrangedSubview(view)
        }
    }
    
    private func modifyStars(button: UIButton) {
        if button.buttonType == UIButton.ButtonType.custom {
            button.setImage(UIImage(named: "star_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.addTarget(self, action: #selector(didRateRecipe(button:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Rating button actions
    @objc private func didRateRecipe(button: UIButton) {
        let index = self.arrangedSubviews.firstIndex(of: button) ?? 0
        
        // Setting rating of recipe
        self.rating = index
        
        // Highlight stars
        self.highlightStars(rating: index)
        
        self.recipeUserInteractionDelegate?.userPressedRating()
    }
    
    func highlightStars(rating: Int) {
        if let views = self.arrangedSubviews as? [UIButton] {
            for y in 0...3 {
                views[y].tintColor = .white
            }
            for x in 0...rating {
                views[x].tintColor = .orange
            }
        }
    }
    
    func prepareForReuse() {
        if let views = self.arrangedSubviews as? [UIButton] {
            for y in 0...3 {
                views[y].tintColor = .white
            }
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

}
